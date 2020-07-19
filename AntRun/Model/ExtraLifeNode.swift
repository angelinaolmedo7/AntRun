//
//  ExtraLifeNode.swift
//  AntRun
//
//  Created by Angelina Olmedo on 7/18/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import Foundation
import SpriteKit

class ExtraLifeNode: SKSpriteNode {
        
    init() {
        super.init(texture: nil, color: UIColor.clear, size: CGSize(width: 50, height: 50))
        
        let lifeParticles = SKEmitterNode(fileNamed: "ExtraLife.sks")!
        lifeParticles.position = CGPoint(x: 0, y: 0)
        self.addChild(lifeParticles)
        
        self.zPosition = 3
        self.name = "extralife"
        
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = false
        self.physicsBody?.allowsRotation = true
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.Enemy
        self.physicsBody?.collisionBitMask = PhysicsCategory.Player
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Player
    }
    
    
    convenience init(scene: SKScene) {
        self.init()
        self.setRandomStartingPos(scene: scene)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRandomStartingPos(scene: SKScene) {
        let xValue = CGFloat(Int.random(in: 0 ... Int(scene.size.width)))
        let yValue = scene.size.height + CGFloat(Int.random(in: 100...700))
        self.position = CGPoint(x: xValue, y: yValue)
    }
}
