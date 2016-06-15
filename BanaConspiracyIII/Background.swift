//
//  Background.swift
//  BanaConspiracyIII
//
//  Created by a9632 - Pedro Carvalho on 31/05/16.
//  Copyright (c) 2016 a9632 - Pedro Carvalho. All rights reserved.
//

import Foundation
import SpriteKit

class Background : Actor
{
    private var Speed = CGFloat()
    
    func Background(speed : CGFloat)
    {
        self.Speed = speed
        
        self.Actor("Background", CGPointMake(1,1))
        
        self.Node.zPosition = 0
    }
    
    func MoveBackground (moveRight : Bool, _ distanceToMove : CGFloat)
    {
        if(moveRight)
        {
         //If Nerd is attacking right, that means that everything must move left to seem more real
            self.Node.position = CGPoint(x: self.Node.position.x - (distanceToMove-self.Speed), y: self.Node.position.y)
        }
        else
        {
            //if he attacks in the oposite direction, everything moves to the right side
            self.Node.position = CGPoint(x: self.Node.position.x + (distanceToMove-self.Speed), y:self.Node.position.y)
        }
    }
    
}

