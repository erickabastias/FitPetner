//
//  GameViewController.swift
//  FitPetner
//
//  Created by Ericka Bastias on 08/12/2017.
//  Copyright © 2017 Ericka Bastias. All rights reserved.
//
//  Created by Xenia on 08/12/2017.
//  Copyright © 2017 Xenia Lin. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import ARKit
import HealthKit
import HealthKitUI
import CoreMotion
import SpriteKit

class GameViewController: UIViewController, ARSessionDelegate, ARSCNViewDelegate {
    @IBOutlet weak var score_lbl: UILabel!
    @IBOutlet weak var timer_lbl: UILabel!
    @IBOutlet weak var coins_lbl: UILabel!
    @IBOutlet weak var announcement_lbl: UILabel!
    @IBOutlet weak var coin_img: UIImageView!
    @IBOutlet weak var dogbtn: UIButton!
    @IBOutlet weak var homebtn: UIButton!
    @IBOutlet var scnView: ARSCNView!
    @IBOutlet weak var pointsLabel: UILabel!
    
    let pedometer: CMPedometer = CMPedometer() // An object for fetching the system-generated live walking data.
    
    // Interface-related elements
    //var coinsLabel: UILabel!
    var levelLabel: UILabel!
    var progressBar: UIProgressView!
    var timerLabel: UILabel!
    
    // Global counters
    var coinsCounter: Int = 0
    var ingredientsCollectedCounter: Int = 0
    var globalTimer: GlobalTimer!
    var timer_duration = 30
    
    // Global boolean to determine user state
    var isExercise: Bool = true
    
    // Step-counter
    var stepCounterStartDate: Date?
    
    // Character
    var characterController: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        scnView.delegate = self
        
        // Show statistics such as fps and timing information
        // scnView.showsStatistics = true
        
        self.configureWorldBottom()
        
        let camera = scnView.pointOfView
        let pet = NodeGenerator.generateCubeInFrontOf(node: camera!, physics: true)
        scnView.scene.rootNode.addChildNode(pet)
        characterController = Character(model: pet)
        characterController?.loadAnimations()
        
        // add a tap gesture recognizer
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.numberOfTouchesRequired = 1
        self.scnView.addGestureRecognizer(tap)

        foodAppear()
        coinAppear()
        
        showUI()
        startTimer()
    }
    
    // Util to easily get frame boundaries
    func getFrameFor(parent: CGRect = UIScreen.main.bounds, x: CGFloat = 0, y: CGFloat = 0, width: CGFloat = -1, height: CGFloat = -1, margin: CGFloat = 0, padding: CGFloat = 0) -> CGRect {
        let screenSize = parent
        var rectWidth = width
        var rectHeight = height
        
        if width == -1 {
            rectWidth = screenSize.width
        }
        
        if height == -1 {
            rectHeight = screenSize.height
        }
        
        let rect = CGRect(x: x + margin, y: y + margin, width: rectWidth - (margin * 2), height: rectHeight - margin)
        let insets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        return UIEdgeInsetsInsetRect(rect, insets)
    }
    
    // Print food nutrition info
    func printFoodInfo(_ foodNode: SCNNode){
        var title = "Unkown Ingredient"
        var description = "This would be an ingredient description!"
        
        if foodNode.name == "FOOD_apple"{
            // UI text appear on screen, displaying food nutrition info
            title = "Apple"
            description = "One apple a day keeps the doctor away!"
        }
        else if foodNode.name == "FOOD_boletus"{
            title = "Boletus"
            description = "One of the best mushrooms on Earth!"
        }
        else if foodNode.name == "FOOD_rawmeat"{
            title = "Raw Meat"
            description = "Actually, be careful with raw meat =_="
        }
        else if foodNode.name == "FOOD_cookie"{
            title = "Cookie"
            description = "Eat adequate amount of cookies!"
        }
        
        Popup(parent: self, title: title, content: description, okActionTitle: "Keep Exercising").show()
    }
    
    // Add coin to coin collector
    func rewardCoin(_ nbCoins: Int = 1) {
        self.setCoins(self.coinsCounter + nbCoins)
    }
    
    // Update experience bar progress
    func updateProgress() {
        // let bonus = self.ingredientsCollectedCounter > 1 ? 2 : 1
        
        // TODO: should be updated when we'll have an accurate step counter
        // let exp = steps * bonus
        
        // Temporary: each ingredient would be worth 100pts
        // No bonus involved in there
        //******************************************************
        let exp = self.ingredientsCollectedCounter * 100
        // One level every 500 experience points
        let EACH_LEVEL_EXP = 500
        let level = exp / EACH_LEVEL_EXP
        //******************************************************
        // Retrieve the current progress
        var currentProgress: Float = Float(exp - level * EACH_LEVEL_EXP)
        pointsLabel.text = String(exp)
        // Then normalize it to 1
        currentProgress = currentProgress / Float(EACH_LEVEL_EXP)
        
        self.levelLabel.text = "Level " + String(level)
        self.progressBar.setProgress(Float(currentProgress), animated: true)
    }
    
    //send level to Stats screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //******************************************************
        let exp = self.ingredientsCollectedCounter * 100
        let EACH_LEVEL_EXP = 500
        let level = exp / EACH_LEVEL_EXP
        //******************************************************
        // Get the new view controller using segue.destinationViewController.
        let destination = segue.destination as! StatsViewController
        destination.leveltext = String(level)
        // Pass the selected object to the new view controller.
    }
    
    // Update both coins counter and UI
    func setCoins(_ coins: Int = 0) {
        self.coinsCounter += 1
        self.coins_lbl.text = String(coins) + " coins"
    }
    
    // Initialize timer
    func startTimer() {
        self.globalTimer = GlobalTimer(duration: timer_duration, onTick: {
            let timerStatus = self.globalTimer.getCurrentStatus()
            self.timerLabel.text = timerStatus
        }, whenFinished: {
            self.timerLabel.backgroundColor = UIColor(red: 0.94, green: 0.33, blue: 0.31, alpha: 1)
            self.timerLabel.textColor = UIColor.white
            self.isExercise = false;
            // Trophy appears
            self.trophyAppear()
            
//            if CMPedometer.isStepCountingAvailable() {
//                self.pedometer.queryPedometerData(from: self.stepCounterStartDate!, to: Date(), withHandler: { data, error in
//                    print("Nb of steps: " + String(describing: data?.numberOfSteps) + ";" + "Distance: " + String(describing: data?.distance))
//                })
//            }
        })
    }
    
    // Initialize UI elements
    func showUI() {
        if CMPedometer.isStepCountingAvailable() {
            self.stepCounterStartDate = Date()
        }
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        
        // Player progress container
        let container = UIVisualEffectView(effect: blurEffect)
        container.frame = self.getFrameFor(height: 30, margin: 5)
        container.layer.cornerRadius = 5
        container.layer.masksToBounds = true
        
        // Level label
        self.levelLabel = UILabel(frame: self.getFrameFor(parent: container.bounds, padding: 5))
        self.levelLabel.text = "Level 0"
        self.levelLabel.textColor = UIColor.white
        self.levelLabel.textAlignment = NSTextAlignment.center
        self.levelLabel.font = UIFont.boldSystemFont(ofSize: 30)
        container.contentView.addSubview(self.levelLabel)
        
        // Coins View
        let coinsView = UIView(frame: self.getFrameFor(parent: container.bounds, width: 60, padding: 5))
        coinsView.backgroundColor = UIColor(red: 1, green: 0.92, blue: 0.23, alpha: 1)
        coinsView.layer.cornerRadius = 2
        container.contentView.addSubview(coinsView)
        
        // Coins label
        //self.coinsLabel = UILabel(frame: self.getFrameFor(parent: coinsView.bounds))
        //self.coinsLabel.text = "0 coins"
        //self.coinsLabel.textAlignment = NSTextAlignment.center
        //self.coinsLabel.font = UIFont.boldSystemFont(ofSize: 7)
        //coinsView.addSubview(self.coinsLabel)
        
        // Progress bar (leveling)
        self.progressBar = UIProgressView(frame: self.getFrameFor(parent: container.bounds, y: 23))
        self.progressBar.progressViewStyle = UIProgressViewStyle.default
        self.progressBar.progress = 0
        self.progressBar.progressTintColor = UIColor(red: 1, green: 0.43, blue: 0.25, alpha: 1)
        self.progressBar.trackTintColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.3)
        container.contentView.addSubview(self.progressBar)
        
        // Timer container
        let timerView = UIVisualEffectView(effect: blurEffect)
        timerView.frame = self.getFrameFor(x: UIScreen.main.bounds.width - 60, y: UIScreen.main.bounds.height - 30 - 10, width: 60, height: 30, margin: 10)
        timerView.layer.cornerRadius = 10
        timerView.layer.masksToBounds = true
        
        // Timer label
        self.timerLabel = UILabel(frame: self.getFrameFor(parent: timerView.bounds))
        self.timerLabel.text = "00:00"
        self.timerLabel.textAlignment = NSTextAlignment.center
        self.timerLabel.textColor = UIColor.white
        self.timerLabel.font = UIFont.boldSystemFont(ofSize: 8)
        timerView.contentView.addSubview(self.timerLabel)
        
        self.scnView.addSubview(container)
        self.scnView.addSubview(timerView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        var configuration: ARWorldTrackingConfiguration!
        configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        configuration.isLightEstimationEnabled = true
        scnView.session.run(configuration, options: .removeExistingAnchors)
    }
    
    // Tell AR session to stop tracking motion and processing image for the view’s content
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        scnView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Let food appear, depending on time
    func foodAppear(){
        var itemToAppear: SCNNode!
        itemToAppear = itemGenerator.loadFood()
        //scnView.pointOfView?.addChildNode(itemToAppear)
        scnView.scene.rootNode.addChildNode(itemToAppear)
        
        // Particle effect
        let particleEmitter = itemGenerator.createBokeh()
        itemToAppear.addParticleSystem(particleEmitter)
    }
    
    func coinAppear(){
        var coinToAppear: SCNNode!
        coinToAppear = itemGenerator.loadCoin()
        //scnView.pointOfView?.addChildNode(coinToAppear)
        scnView.scene.rootNode.addChildNode(coinToAppear)
    }
    
    func trophyAppear(){
        var itemToAppear: SCNNode!
        itemToAppear = itemGenerator.loadTrophy()
        scnView.scene.rootNode.addChildNode(itemToAppear)
        
        // Particle effect
        let particleEmitter = itemGenerator.createConfetti()
        itemToAppear.addParticleSystem(particleEmitter)
    }
    
    // Handle Tap on coin and food
    @objc
    func handleTap(_ gestureRecognize: UITapGestureRecognizer) {
        // check what nodes are tapped
        let p = gestureRecognize.location(in: scnView)
        let hitResults = scnView.hitTest(p, options: [:])
        // check that we clicked on at least one object
        if hitResults.count > 0 {
            // retrieved the first clicked object
            let result = hitResults[0]
            // get its node
            let resultNode = result.node
            
            // Food/coins only appear while user is exercising
            if (self.isExercise){
                if (resultNode.name)?.range(of:"FOOD") != nil {
                    // Make it disappear
                    resultNode.removeFromParentNode()
                    
                    // We display the ingredient's information
                    self.printFoodInfo(resultNode)
                    
                    // We now update our progress
                    self.ingredientsCollectedCounter += 1
                    self.updateProgress()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                        self.foodAppear()
                    })
                } else if resultNode.name == "COIN" {
                    resultNode.removeFromParentNode()
                    
                    self.rewardCoin()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
                        self.coinAppear()
                    })
                } else if resultNode.name == "FoxNode" || resultNode.name == "Max" {
                    print("TAP FOXNODE")
                    let location: CGPoint = gestureRecognize.location(in: scnView)
                    let hits = self.scnView.hitTest(location, options: nil)
                    
                    if let tappedNode = hits.first?.node {
                        print(tappedNode.name ?? "N/A")
                        tappedNode.parent?.parent?.physicsBody?.applyForce(SCNVector3(0, 5, 0), asImpulse: true)
                    }
                }
            }
            else{
                if (resultNode.name)?.range(of:"FOOD") != nil {
                    // Make it disappear
                    resultNode.removeFromParentNode()
                    // We display the ingredient's information
                    self.printFoodInfo(resultNode)
                    // We now update our progress
                    self.ingredientsCollectedCounter += 1
                    self.updateProgress()
                } else if resultNode.name == "COIN" {
                    resultNode.removeFromParentNode()
                    self.rewardCoin()
                }
            }
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    private func configureWorldBottom() {
        let bottomPlane = SCNBox(width: 100000, height: 0.5, length: 100000, chamferRadius: 0)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor(white: 1.0, alpha: 0.0)
        bottomPlane.materials = [material]
        
        let bottomNode = SCNNode(geometry: bottomPlane)
        bottomNode.position = SCNVector3(x: 0, y: -2, z: 0)
        
        let physicsBody = SCNPhysicsBody.static()
        physicsBody.categoryBitMask = CollisionTypes.bottom.rawValue
        physicsBody.contactTestBitMask = CollisionTypes.shape.rawValue
        bottomNode.physicsBody = physicsBody
        
        self.scnView.scene.rootNode.addChildNode(bottomNode)
        self.scnView.scene.physicsWorld.contactDelegate = self
    }
}

// Close AR Plane Detection for now
//extension GameViewController{
//    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor){
//        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
//
//        let planeNode = createPlaneNode(anchor: planeAnchor)
//
//        // ARKit owns the node corresponding to the anchor, so make the plane a child node.
//        node.addChildNode(planeNode)
//    }
//
//    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor){
//        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }
//
//        // Remove existing plane nodes
//        node.enumerateChildNodes {
//            (childNode, _) in
//            childNode.removeFromParentNode()
//        }
//
//        let planeNode = createPlaneNode(anchor: planeAnchor)
//
//        node.addChildNode(planeNode)
//    }
//
//    func renderer(_ renderer: SCNSceneRenderer, didRenderScene scene: SCNScene, atTime time: TimeInterval){
//
//    }
//
//    func createPlaneNode(anchor: ARPlaneAnchor) -> SCNNode {
//        // Create a SceneKit plane to visualize the node using its position and extent.
//        // Create the geometry and its materials
//        let plane = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
//
//        let tronImage = UIImage(named: "tron_grid")
//        let tronMaterial = SCNMaterial()
//        tronMaterial.diffuse.contents = tronImage
//        tronMaterial.isDoubleSided = true
//
//        plane.materials = [tronMaterial]
//
//        // Create a node with the plane geometry we created
//        let planeNode = SCNNode(geometry: plane)
//        planeNode.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
//
//        // SCNPlanes are vertically oriented in their local coordinate space.
//        // Rotate it to match the horizontal orientation of the ARPlaneAnchor.
//        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)
//
//        return planeNode
//    }
//}

extension GameViewController : SCNPhysicsContactDelegate {
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        _ = contact.nodeA.physicsBody!.categoryBitMask | contact.nodeB.physicsBody!.categoryBitMask
    }
}

class ARPlane: SCNNode{
    var planeAnchor: ARPlaneAnchor!
    var planeGeometry: SCNPlane!
    
    public convenience init(_ anchor: ARPlaneAnchor){
        self.init()
        
        planeAnchor = anchor
        planeGeometry = SCNPlane(width: CGFloat(anchor.extent.x), height: CGFloat(anchor.extent.z))
        
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "tron_grid")
        planeGeometry.materials = [material]
        
        let planeNode = SCNNode(geometry: planeGeometry)
        planeNode.position = SCNVector3Make(0, 0, 0)
        
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)
        setTextureScale()
        addChildNode(planeNode)
    }
    
    func update(_ planeAnchor: ARPlaneAnchor){
        planeGeometry.width = CGFloat(planeAnchor.extent.x)
        planeGeometry.height = CGFloat(planeAnchor.extent.z)
        
        position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z)
        setTextureScale()
    }
    
    func setTextureScale() {
        let width = planeGeometry.width
        let height = planeGeometry.height
        
        let material = planeGeometry.firstMaterial
        material?.diffuse.contentsTransform = SCNMatrix4MakeScale(Float(width), Float(height), 1)
        material?.diffuse.wrapS = .repeat
        material?.diffuse.wrapT = .repeat
    }
}
