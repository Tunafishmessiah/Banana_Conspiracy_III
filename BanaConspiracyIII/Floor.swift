//
//  Floor.swift
//  BanaConspiracyIII
//
//  Created by El Capitan on 26/05/16.
//  Copyright © 2016 a9632 - Pedro Carvalho. All rights reserved.
//

import Foundation
import SpriteKit

class Floor : Actor
{
    var Speed = CGFloat()
    
    
    func Floor ()
    {
        self.Actor("Floor", CGPointMake(1,1))
        self.Node.zPosition = 1
    }
    
    public func MoveFloors(moveRight : Bool, _ distanceToMove : CGFloat)
    {
        //Se o Nerd estiver a atacar para a direita, o campo e tudo o resto deve mover-se para a esquerda
        //logo a coordenada X deve diminuir
        if(moveRight)
        {
            self.Node.position = CGPoint(x: self.Node.position.x - distanceToMove,y: self.Node.position.y)
        }
        //Ja se o ataque for para a esquerda, deve-se mover o mundo para a direita
        else
        {
            self.Node.position = CGPoint(x: self.Node.position.x + distanceToMove,y: self.Node.position.y)
        }
    }
}