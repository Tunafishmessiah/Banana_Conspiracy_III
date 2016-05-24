//
//  Player.swift
//  BanaConspiracyIII
//
//  Created by a9632 - Pedro Carvalho on 24/05/16.
//  Copyright (c) 2016 a9632 - Pedro Carvalho. All rights reserved.
//

import Foundation
import SpriteKit

class Player : Pawn
{
    var AttackTimer = CGFloat()
    var PlayerAtlas : SKTextureAtlas = SKTextureAtlas(named: "player.atlas")
    var PlayerSprites : [SKTexture] = []
    var Resting = Bool()
    
    func Player(screenSize : CGSize)
    {
        
        PlayerSprites.append(SKTexture(imageNamed: "Player0"))
        PlayerSprites.append(SKTexture(imageNamed: "Player1"))
        self.Node.texture = PlayerSprites[0]
        self.Pawn("Player", CGPoint(x: 1, y: 1), false, 10)
        self.Node.position = CGPoint(x: screenSize.width/2 - self.Node.size.width/2 , y: screenSize.height/10 + self.Node.size.height)
        self.Resting = true
    }
    
    override func Attack() {
        AttackTimer = 20
        Resting = false
        
        //Do the random attack to the side it's clicked on

    }
    override func Update() {
        
        if AttackTimer > 0
        {
            AttackTimer--
        }
        else
        {
            if(!Resting)
            {
                Resting = true
                self.Node.texture = PlayerSprites[0]
            }
        }
    }
}