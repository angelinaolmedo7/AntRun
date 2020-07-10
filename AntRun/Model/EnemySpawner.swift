//
//  EnemySpawner.swift
//  AntRun
//
//  Created by Angelina Olmedo on 7/9/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import Foundation
import SpriteKit

class EnemySpawner: SKNode {
    
    var spawnTimer: CFTimeInterval = 0
    let fixedDelta: CFTimeInterval = 1.0 / 60.0 /* 60 FPS */
    var timeSpace: CFTimeInterval?
    
    func initTimeSpace(){
        // check
        if timeSpace == nil {
            timeSpace = 0
            // get a child from self since we should have 9
            let child = self.children[0] as! SKSpriteNode
            // record the initial position to test speed
            let initialPos = self.children[0].position.x
            // user a timer that fires at 60 FPS to mesure the time it takes to get to a certain distance
            let _ = Timer.scheduledTimer(timeInterval: fixedDelta, target: self, selector: #selector(timerCheck(_:)), userInfo: ["child":child, "pos":initialPos], repeats: true)
        }
    }

    @objc func timerCheck(_ timer: Timer){
        // get the info we sent through the timer in this case a dictionary because we needed more than one data.
        let info = timer.userInfo as! [String: Any]
        // get thhe child from dict
        let child = info["child"] as! SKSpriteNode
        // get initial pos from dict
        let initialPos = info["pos"] as! CGFloat
        // check the position of child until it's more than 90% past itself
        if child.position.x <= initialPos + (child.size.width * 0.90) {
            // add time everytime the child is still not where we need it
            timeSpace! += fixedDelta
        } else {
            // we are done the child is where we need it so we stop the timer
            timer.invalidate()
            // remove all of the  animations
            child.removeAllActions()
            // reset the position
            child.position.x = initialPos
        }
    }
    
    func generate(scene: SKScene) {
//        initTimeSpace()
        spawnTimer += fixedDelta
//        print(spawnTimer)
        if spawnTimer > 3.0 { //Double(timeSpace!) {
            print("BEETLE TIME")
            self.addChild(Beetle(scene: scene))
            spawnTimer = 0
        }
        print(self.children)
    }
}
