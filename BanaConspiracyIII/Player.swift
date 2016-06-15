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
    let AttackRange = 200
    
    func Player(screenSize : CGPoint)
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
        
        self.Pawn("Nerd0", CGPoint(x: 0.15, y: 0.15), false, 10)
        
        //
        
        self.Node.position = CGPoint(x: screenSize.x/2, y: screenSize.y/10 + (2*self.Node.size.height)/3)
        
        self.MakeThingsCollide(false)
        
        
        self.Node.zPosition = 3
        
    }
    
    public func Attack(attackRight : Bool)
    {
        if(self.HP > 0)
        {
        AttackTimer = 20
        Resting = false
        
        //Escolher entre os diferentes ataques
        
        var nextAttack = arc4random_uniform(4)
        while self.Node.texture == PlayerSprites[3+Int(nextAttack)]
        {
            nextAttack = arc4random_uniform(4)
        }
        self.Node.texture = PlayerSprites[3 + Int(nextAttack)]
        
        
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

    }
    override func DamageHP()
    {
        
        self.Node.texture = PlayerSprites[1]
        self.AttackTimer = 3
        
        super.DamageHP()
    }
    override func Update()
    {
        
        
        if AttackTimer > 0
        {
            AttackTimer--
        }
        else
        {
            if(AttackTimer<=0)
            {
                self.Node.texture = PlayerSprites[0]
            }
        }
        
    }
    
    override func Die()
    {
        self.Node.texture = PlayerSprites[2]
        super.Die()
    }
    
}	