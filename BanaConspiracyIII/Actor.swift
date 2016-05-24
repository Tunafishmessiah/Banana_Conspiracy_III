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
        self.Node.size = CGSize(width: self.Node.size.width * scale.x, height: self.Node.size.height * scale.y)
        self.Body = SKPhysicsBody(rectangleOfSize: self.Node.size)
    }
    
    public func Update()
    {
    }
}