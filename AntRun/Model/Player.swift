//
//  Player.swift
//  AntRun
//
//  Created by Angelina Olmedo on 7/9/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    
    var vel: Double = 200
    var sceneWidth: CGFloat = 0 // this should be set in setup()
    var initialPos: CGPoint! // this should be set in setup()
    var lifeParticles = SKEmitterNode(fileNamed: "ExtraLife.sks")!
    
    func setup(scene: SKScene){
        self.physicsBody?.categoryBitMask = PhysicsCategory.Player
        self.physicsBody?.collisionBitMask = PhysicsCategory.Enemy | PhysicsCategory.Food
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy | PhysicsCategory.Food
        
        lifeParticles.position = CGPoint(x: 0, y: 0)
        self.addChild(lifeParticles)
        lifeParticles.isHidden = true
        
        self.initialPos = CGPoint(x: scene.frame.width/2, y: 300)
        self.position = self.initialPos
        self.sceneWidth = scene.frame.width
    }
    
    func getDuration(left: Bool) -> Double{
        // calculate what duration to give the SKAction to maintain a constant speed of self.vel
        let xPos = Double(self.position.x)
        if left {
            return xPos/vel
        }
        else {
            return (Double(self.sceneWidth)-xPos)/vel
        }
    }
    
    func moveAnt(left: Bool) {
        if left {
            let act = SKAction.moveTo(x: self.size.width, duration: getDuration(left: true))
            self.run(act)
        }
        else { // right
            let act = SKAction.moveTo(x: (self.sceneWidth - self.size.width), duration: getDuration(left: false))
            self.run(act)
        }
    }
    
}
