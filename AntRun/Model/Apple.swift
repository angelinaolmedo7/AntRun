//
//  Apple.swift
//  AntRun
//
//  Created by Angelina Olmedo on 7/12/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import Foundation
import SpriteKit

class Apple: SKSpriteNode {
    let pointValue: Int
    var appleGlow = SKEmitterNode(fileNamed: "AppleGlow.sks")!
    
    init() {
        let texture = SKTexture(imageNamed: "applesprite.png")
        let size = CGSize(width: texture.size().width/5, height: texture.size().height/5) // texture.size()
        let color = UIColor.clear
        self.pointValue  = 1
        
        super.init(texture: texture, color: color, size: size)
        self.zPosition = 2
        self.name = "apple"
        
        appleGlow.position = CGPoint(x: 0, y: 0)
        appleGlow.zPosition = -1
        self.addChild(appleGlow)
        
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = false
        
        self.physicsBody?.categoryBitMask = PhysicsCategory.Food
        self.physicsBody?.collisionBitMask = PhysicsCategory.Player
        self.physicsBody?.contactTestBitMask = PhysicsCategory.Player
    }
    
    convenience init(scene: SKScene) {
        self.init()
        self.setRandomStartingPos(scene: scene)
    }
    
    func setRandomStartingPos(scene: SKScene) {
        let xValue = CGFloat(Int.random(in: 0 ... Int(scene.size.width)))
        let yValue = scene.size.height + CGFloat(Int.random(in: 100...700))
        self.position = CGPoint(x: xValue, y: yValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
