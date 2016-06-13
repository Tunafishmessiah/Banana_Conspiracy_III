//
//  Pawn.swift
//  BanaConspiracyIII
//
//  Created by a9632 - Pedro Carvalho on 24/05/16.
//  Copyright (c) 2016 a9632 - Pedro Carvalho. All rights reserved.
//

import Foundation
import SpriteKit

class Pawn : Actor
{
    var HP : Int8 = 1
    var IsEnemy = Bool()
    var Alpha = CGFloat()
    var IsDead = Bool()
    var DeathAction = SKAction()

    func Pawn(texture : String, _ scale: CGPoint, _ enemy : Bool, _ hp : Int8)
    {
        self.HP = hp
        self.IsEnemy = enemy
        self.IsDead = false
        
        self.Actor(texture, scale)
        self.MakeThingsCollide(enemy)
        
    }
    
    public func Attack()
    {
        
    }
    
    public func Die()
    {
        if HP <= 0
        {
            self.DeathAction = SKAction.fadeAlphaTo(0, duration: 2)
            self.Node.runAction(self.DeathAction, completion: { () -> Void in
                self.IsDead = true
            }
            )
        }
    }
    
    public func DamageHP()
    {
        self.HP -= 1
    }
    
    override func Update()
    {
        
    }
    
    
}