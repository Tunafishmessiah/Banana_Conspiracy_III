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
        
        PlayerSprites.append(SKTexture(imageNamed: "Nerd0"))//Idle
        PlayerSprites.append(SKTexture(imageNamed: "Nerd1"))//Damaged
        PlayerSprites.append(SKTexture(imageNamed: "Nerd2"))//dead
        PlayerSprites.append(SKTexture(imageNamed: "Nerd3"))//FlyKick
        PlayerSprites.append(SKTexture(imageNamed: "Nerd4"))//Headbutt
        PlayerSprites.append(SKTexture(imageNamed: "Nerd5"))//PalmHit
        PlayerSprites.append(SKTexture(imageNamed: "Nerd6"))//Kick
        self.Node.texture = PlayerSprites[0]
        //
        self.Pawn("Nerd0", CGPoint(x: 1, y: 1), false, 10)
        //
        self.Node.position = CGPoint(x: screenSize.width/2 - self.Node.size.width/2 , y: screenSize.height/10 + self.Node.size.height)
        self.Resting = true
        
        self.MakeThingsCollide(false) 
        
    }
    
    public func Attack(attackRight : Bool)
    {
        AttackTimer = 20
        Resting = false
        
        //Escolher entre os diferentes ataques, sendo que o numero dentro do
        //random deve ser NumAtaques - 1
        let nextAttack = arc4random_uniform(4)
        self.Node.texture = PlayerSprites[2 + Int(nextAttack)]
        
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