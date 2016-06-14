//
//  GameScene.swift
//  BanaConspiracyIII
//
//  Created by a9632 - Pedro Carvalho on 24/05/16.
//  Copyright (c) 2016 a9632 - Pedro Carvalho. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate
{
    
    var gameManager = GameManager()
    
    var level = 1
    
    var start = false
    
    override func didMoveToView(view: SKView)
    {
        gameManager.GameManager(self.level, screenSize: CGPointMake(self.size.width, self.size.height), self)
        print(self.size.width/2)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        if(self.start)
        {
        let touch = touches[touches.startIndex].locationInView(self.inputView)
        
        touch.x <= self.size.height/2 ? gameManager.DoAttack(false) : gameManager.DoAttack(true)
        print(touch.x)
        }
        else
        {
            self.start = true
        }
        
    }
   
    override func update(currentTime: CFTimeInterval)
    {
        gameManager.Update(self)
    }
}