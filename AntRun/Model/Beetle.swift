//
//  Beetle.swift
//  AntRun
//
//  Created by Angelina Olmedo on 7/9/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import Foundation
import SpriteKit

class Enemy: SKSpriteNode {
    init(texture: SKTexture, name: String) {
        let size = CGSize(width: texture.size().width/5, height: texture.size().height/5)
        let color = UIColor.clear
                
        super.init(texture: texture, color: color, size: size)
        self.zPosition = 2
        self.name = name
        
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

class Beetle: Enemy {
    init() {
        let texture = SKTexture(imageNamed: "beetlesprite.png")
        super.init(texture: texture, name: "beetle")
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


class Wasp: Enemy {
    init() {
        let texture = SKTexture(imageNamed: "beetlesprite.png")
        super.init(texture: texture, name: "wasp")
    }
    
    convenience init(scene: SKScene) {
        self.init()
        self.setRandomStartingPos(scene: scene)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRandomStartingPos(scene: SKScene) {
        // either spawns on the left and goes right or vice versa
        let randStart = Int.random(in: 0...1)
        switch randStart {
        case 1:
            let xValue = CGFloat(scene.size.width + 400)
            let yValue = scene.size.height + CGFloat(Int.random(in: 100...300))
            self.position = CGPoint(x: xValue, y: yValue)
            
            let moveLeft = SKAction.moveTo(x: -100, duration: 10)
            self.run(moveLeft)
        default:
            let xValue = CGFloat(-400)
            let yValue = scene.size.height + CGFloat(Int.random(in: 100...300))
            self.position = CGPoint(x: xValue, y: yValue)
            
            let moveRight = SKAction.moveTo(x: scene.size.width + 100, duration: 10)
            self.run(moveRight)
        }
    }
}
