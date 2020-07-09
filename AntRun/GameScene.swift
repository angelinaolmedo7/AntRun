//
//  GameScene.swift
//  AntRun
//
//  Created by Angelina Olmedo on 7/6/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let None: UInt32 = 0
    static let Player: UInt32 = 0b1
    static let Enemy: UInt32 = 0b10
//    static let PlayerBody: UInt32 = 0b100
    static let Barrier: UInt32 = 0b1000
}

class GameScene: SKScene {
    
    var scrollNode: SKNode!
    let fixedDelta: CFTimeInterval = 1.0 / 60.0 /* 60 FPS */
    let scrollSpeed: CGFloat = 200
    
    var player: Player!
    var barrier: SKSpriteNode!
    
    override func sceneDidLoad() {
        super.sceneDidLoad()
        
        setRefs()

    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        /* Process world scrolling */
        scrollWorld()
        
    }
    
    func setRefs() {
        // player
        if let player = self.childNode(withName: "player") as? Player {
            self.player = player
        } else {
            print("u dont have a player :/ good luck playing now")
        }
        player.setup(scene: self)
        
        // scroll node
        if let scrollNode = self.childNode(withName: "backgroundScroll") {
            self.scrollNode = scrollNode
        } else {
            print("scrollNode could not be connected properly. u done fucked up")
        }
        
        // barrier for removing obstacles
        if let barrier = self.childNode(withName: "barrier") as? SKSpriteNode {
            self.barrier = barrier
        } else {
            print("booo we hate ur barrier")
        }
        barrier.physicsBody?.categoryBitMask = PhysicsCategory.Barrier
        barrier.physicsBody?.collisionBitMask = PhysicsCategory.None
        barrier.physicsBody?.contactTestBitMask = PhysicsCategory.Enemy
    }
    
    func scrollWorld() {
        
        /* Scroll World */
        scrollNode.position.y -= scrollSpeed * CGFloat(fixedDelta)

        /* Loop through scroll layer nodes */
        for ground in scrollNode.children as! [SKSpriteNode] {

            /* Get ground node position, convert node position to scene space */
            let groundPosition = scrollNode.convert(ground.position, to: self)

            /* Check if ground sprite has left the scene */
            if groundPosition.y <= -ground.size.height / 2 {

                /* Reposition ground sprite to the second starting position */
                let newPosition = CGPoint(x: groundPosition.x, y: (ground.size.height*2.5 + groundPosition.y))

                /* Convert new node position back to scroll layer space */
                ground.position = self.convert(newPosition, to: scrollNode)
            }
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if pos.x < self.size.width/2 { // left
            player.moveAnt(left: true)
        }
        else { // right
            player.moveAnt(left: false)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        player.removeAllActions()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
}
