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
    var StartWindow = StartScreen()
    var gameManager = GameManager()
    
    var level = 1
    
    var start = true
    
    override func didMoveToView(view: SKView)
    {
        StartWindow.StartScreen(self, start: true, points: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        if(self.start)
        {
            StartWindow.Delete(self)
            gameManager.GameManager(self.level, screenSize: CGPointMake(self.size.width, self.size.height), self)
            self.start = false
        }
        else
        {
            let touch = touches[touches.startIndex].locationInView(self.inputView)
            touch.x <= self.size.height/2 ? gameManager.DoAttack(false) : gameManager.DoAttack(true)
        }
    }
   
    override func update(currentTime: CFTimeInterval)
    {
        
        if(!start)
        {
            gameManager.Update(self)
            if(gameManager.SceneChange)
            {
                let aux = gameManager.Points
                gameManager.Delete(self)
                
                self.removeAllChildren()
                
                StartWindow.StartScreen(self, start: false, points: aux)
                start = true
            }
        }
        
    }
}