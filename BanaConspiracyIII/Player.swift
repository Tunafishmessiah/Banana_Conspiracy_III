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
    
    public func Attack(attackRight : Bool, moveFloor : Floor) {
        AttackTimer = 20
        Resting = false
        
        //Escolher entre os diferentes ataques, sendo que o numero dentro do
        //random deve ser NumAtaques - 1
        let nextAttack = arc4random_uniform(4)
        self.Node.texture = PlayerSprites[Int(nextAttack)]
        
        //Verifica se o jogador ja está virado para o lado e vira-o se não estiver
        if !attackRight && self.Node.xScale > 0
        {
            self.Node.xScale *= -1
        }
        else if attackRight && self.Node.xScale < 0
        {
            self.Node.xScale *= -1
        }
        
        
        //Do the random attack to the side it's clicked on

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