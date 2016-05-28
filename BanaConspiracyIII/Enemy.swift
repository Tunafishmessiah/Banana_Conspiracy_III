//
//  Enemy.swift
//  BanaConspiracyIII
//
//  Created by a9632 - Pedro Carvalho on 27/05/16.
//  Copyright (c) 2016 a9632 - Pedro Carvalho. All rights reserved.
//

import Foundation
import SpriteKit

class Enemy : Pawn
{
    
    var EnemySprites : [SKTexture] = []
    var attackTimer : Int = 0
    func Enemy( screenSize : CGPoint, rightScreenSide : Bool)
    {
        //They will be walking always, soo we'll just have 2 sprites of him walking
        EnemySprites.append(SKTexture(imageNamed: "ICUP00"))//right leg front
        EnemySprites.append(SKTexture(imageNamed: "ICUP01"))//left leg fron
        EnemySprites.append(SKTexture(imageNamed: "ICUP02"))//attack
        
        self.Pawn("ICUP", CGPointMake(1,1),true,1)
        
        //como as imagens estão todas viradas para a direita
        
        if(rightScreenSide)
        {
            //virar o men para o outro lado
            self.Node.xScale = -1
        }
        
        
    }
    
    public func Update(playerPos : CGPoint)
    {
        //if the player is near enough, he will attack instead of doing anything else
        var dist : CGFloat = playerPos.x - self.Node.position.x
        
        if(dist < 0)
        {
            dist *= -1
        }
        
        if(dist < self.Node.size.width) //a value that i think it's right, maybe self.size.width/2 + player.size.width/2 wouldn't be bad too
        {
            self.Node.texture = EnemySprites[2]
            self.attackTimer = 20
            //to make him attack
        }
        else if (self.attackTimer == 0)
        {
            attackTimer -= 1
        }
        else
        {
            
        }
        
    }
    
}