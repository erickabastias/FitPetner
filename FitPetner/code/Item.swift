import Foundation
import SceneKit
import ARKit

struct itemGenerator {
    // Load 3D models that will appear in game
    static func loadFood() -> SCNNode{
        // var itemArray : [SCNNode] = [] // Choose not to store items in an array
        
        // Randomly choose item to appear
        let numberOfItem = Int(10) // 新增物品時記得改這邊的數字
        let randomNumber = Int(arc4random_uniform(UInt32(numberOfItem))+1)
        //let randomNumber = 11 // for test use only
        var itemLoaded: SCNNode!
        
        if (randomNumber == 1) {
            // Load model
            let scene = SCNScene( named: "/art.scnassets/Food/apple.scn")!
            itemLoaded = scene.rootNode.childNode(withName: "apple", recursively: true)
            itemLoaded.name = "FOOD_apple"
            itemLoaded.scale = SCNVector3(x:0.02, y:0.02, z:0.02)
        } else if (randomNumber == 2) {
            // Load model
            let scene = SCNScene( named: "/art.scnassets/Food/boletus.scn")!
            itemLoaded = scene.rootNode.childNode(withName: "boletus", recursively: true)
            itemLoaded.name = "FOOD_boletus"
            itemLoaded.scale = SCNVector3(x:0.02, y:0.02, z:0.02)
        } else if (randomNumber == 3) {
            // Load model
            let scene = SCNScene( named: "/art.scnassets/Food/raw_meat.scn")!
            itemLoaded = scene.rootNode.childNode(withName: "Raw_meat", recursively: true)
            itemLoaded.name = "FOOD_rawmeat"
            itemLoaded.scale = SCNVector3(x: 0.25, y: 0.25, z: 0.25)
        } else if (randomNumber == 4) {
            // Load model
            let scene = SCNScene( named: "/art.scnassets/Food/cookie.scn")!
            itemLoaded = scene.rootNode.childNode(withName: "cookie", recursively: true)
            itemLoaded.name = "FOOD_cookie"
            itemLoaded.scale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
        } else if (randomNumber == 5) {
            // Load model
            let scene = SCNScene( named: "/art.scnassets/Food/kiwi.scn")!
            itemLoaded = scene.rootNode.childNode(withName: "kiwi", recursively: true)
            itemLoaded.name = "FOOD_kiwi"
            itemLoaded.scale = SCNVector3(x: 0.06, y: 0.06, z: 0.06)
        } else if (randomNumber == 6) {
            // Load model
            let scene = SCNScene( named: "/art.scnassets/Food/orange.scn")!
            itemLoaded = scene.rootNode.childNode(withName: "orange", recursively: true)
            itemLoaded.name = "FOOD_orange"
            itemLoaded.scale = SCNVector3(x: 15, y: 15, z: 15)
        } else if (randomNumber == 7) {
            // Load model
            let scene = SCNScene( named: "/art.scnassets/New/bread.scn")!
            itemLoaded = scene.rootNode.childNode(withName: "bread", recursively: true)
            itemLoaded.name = "FOOD_bread"
            itemLoaded.scale = SCNVector3(x: 2, y: 2, z: 2)
        } else if (randomNumber == 8) {
            // Load model
            let scene = SCNScene( named: "/art.scnassets/New/Carrot.scn")!
            itemLoaded = scene.rootNode.childNode(withName: "carrot", recursively: true)
            itemLoaded.name = "FOOD_carrot"
            itemLoaded.scale = SCNVector3(x: 0.4, y: 0.4, z: 0.4)
        } else if (randomNumber == 9) {
            // Load model
            let scene = SCNScene( named: "/art.scnassets/New/pumpkin.scn")!
            itemLoaded = scene.rootNode.childNode(withName: "pumpkin", recursively: true)
            itemLoaded.name = "FOOD_pumpkin"
            itemLoaded.scale = SCNVector3(x: 0.9, y: 0.9, z: 0.9)
        } else if (randomNumber == 10) {
            // Load model
            let scene = SCNScene( named: "/art.scnassets/New/banana.scn")!
            itemLoaded = scene.rootNode.childNode(withName: "banana", recursively: true)
            itemLoaded.name = "FOOD_banana"
            itemLoaded.scale = SCNVector3(x: 0.5, y: 0.5, z: 0.5)
        }
        //        else if (randomNumber == 10) {
        //            // Load model
        //            let scene = SCNScene( named: "/art.scnassets/New/Melon.scn")!
        //            itemLoaded = scene.rootNode.childNode(withName: "melon", recursively: true)
        //            itemLoaded.name = "FOOD_melon"
        //            itemLoaded.scale = SCNVector3(x: 50, y: 50, z: 50)
        //        }
        
        itemLoaded.position = SCNVector3(x:1, y:-3, z:-10)
        
        let physicsBody = SCNPhysicsBody(
            type: .static,
            shape: SCNPhysicsShape(geometry: (SCNSphere(radius: 0.1)))
        )
        //        physicsBody.mass = 1
        //        physicsBody.restitution = 0.1
        //        physicsBody.friction = 0
        //        physicsBody.categoryBitMask = CollisionTypes.shape.rawValue
        itemLoaded.physicsBody = physicsBody
        
        return itemLoaded
    }
    
    // Load objects (toys, etc.) ***
    static func loadObj() -> SCNNode{
        // var itemArray : [SCNNode] = [] // Choose not to store items in an array
        
        // Randomly choose item to appear
        let numberOfItem = Int(2) // 新增物品時記得改這邊的數字
        //let randomNumber = Int(arc4random_uniform(UInt32(numberOfItem))+1)
        let randomNumber = 2 // for test use only
        var itemLoaded: SCNNode!
        
        if (randomNumber == 1) {
            // Load model
            let scene = SCNScene( named: "/art.scnassets/Object/dog_bone.scn")!
            itemLoaded = scene.rootNode.childNode(withName: "dog_bone", recursively: true)
            itemLoaded.name = "OBJECT_bone"
            itemLoaded.scale = SCNVector3(x:0.008, y:0.008, z:0.008)
        } else if (randomNumber == 2) {
            // Load model
            let scene = SCNScene( named: "/art.scnassets/Object/piggy_bank.scn")!
            itemLoaded = scene.rootNode.childNode(withName: "piggy_bank", recursively: true)
            itemLoaded.name = "OBJECT_piggy"
            itemLoaded.scale = SCNVector3(x:0.008, y:0.008, z:0.008)
        }
        
        itemLoaded.position = SCNVector3(x:0, y:-3, z:-10)
        
        let physicsBody = SCNPhysicsBody(
            type: .static,
            shape: SCNPhysicsShape(geometry: (SCNSphere(radius: 0.1)))
        )
        itemLoaded.physicsBody = physicsBody
        
        return itemLoaded
    }
    
    // Load trophy that appears when time's up
    static func loadTrophy() -> SCNNode{
        var itemLoaded: SCNNode!
        
        let scene = SCNScene( named: "/art.scnassets/Reward/trophy.scn")!
        itemLoaded = scene.rootNode.childNode(withName: "trophy", recursively: true)
        itemLoaded.scale = SCNVector3(x:0.4, y:0.4, z:0.4)
        itemLoaded.position = SCNVector3(x:0, y:-2, z:-10)
        itemLoaded.name = "TROPHY"
        let newMaterial = SCNMaterial()
        newMaterial.diffuse.contents = UIColor.yellow
        itemLoaded.geometry?.firstMaterial = newMaterial
        
        let physicsBody = SCNPhysicsBody(
            type: .static,
            shape: SCNPhysicsShape(geometry: SCNSphere(radius: 0.1))
        )
        itemLoaded.physicsBody = physicsBody
        
        return itemLoaded
    }
    
    // Load Coins that will appear in game
    static func loadCoin() -> SCNNode{
        // Randomly choose a type of coin to appear
        let numberOfCoin = Int(2) // 新增物品時記得改這邊的數字
        //let randomNumber = Int(arc4random_uniform(UInt32(numberOfCoin))+1)
        let randomNumber = 2
        var coinLoaded: SCNNode!
        
        if (randomNumber == 1) {
            // Load model
            let scene = SCNScene( named: "/art.scnassets/Reward/coin.scn")!
            coinLoaded = scene.rootNode.childNode(withName: "coin", recursively: true)
            coinLoaded.scale = SCNVector3(x:4, y:4, z:4)
        } else if (randomNumber == 2) {
            // Load model
            let scene = SCNScene( named: "/art.scnassets/Reward/coin2.scn")!
            coinLoaded = scene.rootNode.childNode(withName: "coin2", recursively: true)
            coinLoaded.scale = SCNVector3(x:50, y:50, z:50)
        }
        
        coinLoaded.position = SCNVector3(x:-2, y:0, z:-10)
        coinLoaded.name = "COIN"
        
        let physicsBody = SCNPhysicsBody(
            type: .static,
            shape: SCNPhysicsShape(geometry: SCNSphere(radius: 0.1))
        )
        coinLoaded.physicsBody = physicsBody
        
        return coinLoaded
    }
    
    // Particle effect for items appearing
    static func createBokeh() -> SCNParticleSystem {
        let bokeh = SCNParticleSystem(named: "/art.scnassets/Particles/bokeh.scnp", inDirectory: nil)!
        bokeh.particleColor = UIColor.white
        bokeh.emitterShape = SCNGeometry()
        return bokeh
    }
    
    // Particle effect for trophy
    static func createConfetti() -> SCNParticleSystem {
        let confetti = SCNParticleSystem(named: "/art.scnassets/Particles/confetti.scnp", inDirectory: nil)!
        //confetti.emitterShape = SCNGeometry()
        return confetti
    }
}

