//
//  Actor.swift
//  BanaConspiracyIII
//
//  Created by a9632 - Pedro Carvalho on 24/05/16.
//  Copyright (c) 2016 a9632 - Pedro Carvalho. All rights reserved.
//

import Foundation
import SpriteKit

public class Actor
{
    public var Node = SKSpriteNode()
    public var Body = SKPhysicsBody()

    func Actor(texture: String, _ scale: CGPoint)
    {
        self.Node = SKSpriteNode(imageNamed: texture)
        self.Node.size = CGSize(width: self.Node.size.width * scale.x, height: self.Node.size.height * scale.y)//Giving it the scale it deserves
        self.Node.anchorPoint = CGPointMake(0.5,0.5)//Setting all images to the middle of the sprite, soo we won't screw up some code on the future over this
        self.Body = SKPhysicsBody(rectangleOfSize: self.Node.size)//Starting to make the body, the rest is up to the character/thing using it
    }
    
    public func Update()
    {
    }
}