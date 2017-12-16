import Foundation
import SceneKit
import ARKit

struct itemGenerator {    
    // Load 3D models that will appear in game
    static func loadFood() -> SCNNode{
        // var itemArray : [SCNNode] = [] // Choose not to store items in an array
        
        // Randomly choose item to appear
        let numberOfItem = Int(3) // 新增物品時記得改這邊的數字
        let randomNumber = Int(arc4random_uniform(UInt32(numberOfItem))+1)
        var itemLoaded: SCNNode!
        
        if (randomNumber == 1) {
            // Load model
            let scene = SCNScene( named: "/art.scnassets/apple.dae")!
            itemLoaded = scene.rootNode.childNode(withName: "apple", recursively: true)
            itemLoaded.name = "FOOD_apple"
            itemLoaded.scale = SCNVector3(x:0.02, y:0.02, z:0.02)
        } else if (randomNumber == 2) {
            // Load model
            let scene = SCNScene( named: "/art.scnassets/boletus.dae")!
            itemLoaded = scene.rootNode.childNode(withName: "boletus", recursively: true)
            itemLoaded.name = "FOOD_boletus"
            itemLoaded.scale = SCNVector3(x:0.02, y:0.02, z:0.02)
        } else if (randomNumber == 3) {
            // Load model
            let scene = SCNScene( named: "/art.scnassets/raw_meat.dae")!
            itemLoaded = scene.rootNode.childNode(withName: "Raw_meat", recursively: true)
            itemLoaded.name = "FOOD_rawmeat"
            itemLoaded.scale = SCNVector3(x: 0.25, y: 0.25, z: 0.25)
        }
        
        itemLoaded.position = SCNVector3(x:0, y:-3, z:-10)
        
        let physicsBody = SCNPhysicsBody(
            type: .kinematic,
            shape: SCNPhysicsShape(geometry: (SCNSphere(radius: 0.1)))
        )
        physicsBody.mass = 1.25
        physicsBody.restitution = 0.75
        physicsBody.friction = 0.75
        physicsBody.categoryBitMask = CollisionTypes.shape.rawValue
        itemLoaded.physicsBody = physicsBody
        
        return itemLoaded
    }
    
    // Load Coins that will appear in game
    static func loadCoin() -> SCNNode{
        // Randomly choose a type of coin to appear
        let numberOfCoin = Int(2) // 新增物品時記得改這邊的數字
        let randomNumber = Int(arc4random_uniform(UInt32(numberOfCoin))+1)
        var coinLoaded: SCNNode!
        
        if (randomNumber == 1) {
            // Load model
            let scene = SCNScene( named: "/art.scnassets/coin.dae")!
            coinLoaded = scene.rootNode.childNode(withName: "coin", recursively: true)
            coinLoaded.scale = SCNVector3(x:4, y:4, z:4)
        } else if (randomNumber == 2) {
            // Load model
            let scene = SCNScene( named: "/art.scnassets/coin2.dae")!
            coinLoaded = scene.rootNode.childNode(withName: "coin2", recursively: true)
            coinLoaded.scale = SCNVector3(x:50, y:50, z:50)
        }
        
        coinLoaded.position = SCNVector3(x:-1, y:0, z:-10)
        coinLoaded.name = "COIN"
        
        let physicsBody = SCNPhysicsBody(
            type: .kinematic,
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
}
