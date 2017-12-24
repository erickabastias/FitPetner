//
//  CharacterController.swift
//  FitPetner
//
//  Created by Erick on 12/24/17.
//  Copyright © 2017 Ericka Bastias. All rights reserved.
//

import Foundation
import SceneKit

class Character: NSObject {
    static private let speedFactor: CGFloat = 1.0
    
    var model: SCNNode
    
    init(model: SCNNode) {
        self.model  = model
    }
    
    public func loadAnimations() {
        let idleAnimation = Character.loadAnimation(fromSceneNamed: "art.scnassets/character/max_idle.scn")
        model.addAnimationPlayer(idleAnimation, forKey: "idle")
        idleAnimation.play()
        
        let walkAnimation = Character.loadAnimation(fromSceneNamed: "art.scnassets/character/max_walk.scn")
        walkAnimation.speed = Character.speedFactor
        walkAnimation.play()
        
        model.addAnimationPlayer(walkAnimation, forKey: "walk")
        
        let jumpAnimation = Character.loadAnimation(fromSceneNamed: "art.scnassets/character/max_jump.scn")
        jumpAnimation.animation.isRemovedOnCompletion = false
        jumpAnimation.stop()
        
        model.addAnimationPlayer(jumpAnimation, forKey: "jump")
        
        let spinAnimation = Character.loadAnimation(fromSceneNamed: "art.scnassets/character/max_spin.scn")
        spinAnimation.animation.isRemovedOnCompletion = false
        spinAnimation.speed = 1.5
        spinAnimation.play()
        
        model.addAnimationPlayer(spinAnimation, forKey: "spin")
    }
    
    var node: SCNNode! {
        return model
    }
    
    // MARK: utils
    
    class func loadAnimation(fromSceneNamed sceneName: String) -> SCNAnimationPlayer {
        let scene = SCNScene( named: sceneName )!
        // find top level animation
        var animationPlayer: SCNAnimationPlayer! = nil
        scene.rootNode.enumerateChildNodes { (child, stop) in
            if !child.animationKeys.isEmpty {
                animationPlayer = child.animationPlayer(forKey: child.animationKeys[0])
                stop.pointee = true
            }
        }
        return animationPlayer
    }
}
