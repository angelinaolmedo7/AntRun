//
//  Beetle.swift
//  AntRun
//
//  Created by Angelina Olmedo on 7/9/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import Foundation
import SpriteKit

class Beetle: SKSpriteNode {
    init() {
        let texture = SKTexture(imageNamed: "beetlesprite.png")
        let size = CGSize(width: texture.size().width/5, height: texture.size().height/5) // texture.size()
        let color = UIColor.clear
        
        super.init(texture: texture, color: color, size: size)
        self.zPosition = 2
        self.name = "beetle"
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
