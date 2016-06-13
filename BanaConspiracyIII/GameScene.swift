//
//  GameScene.swift
//  BanaConspiracyIII
//
//  Created by a9632 - Pedro Carvalho on 24/05/16.
//  Copyright (c) 2016 a9632 - Pedro Carvalho. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    public var gameManager = GameManager()
    
    public var level = 1
    
    override func didMoveToView(view: SKView)
    {
        gameManager.GameManager(self.level, screenSize: CGPointMake(self.size.width, self.size.height))
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        
    }
   
    override func update(currentTime: CFTimeInterval) {
    }
}