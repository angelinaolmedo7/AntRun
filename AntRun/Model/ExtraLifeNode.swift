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
        super.init(texture: nil, color: UIColor.clear, size: CGSize(width: 0, height: 0))
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
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
