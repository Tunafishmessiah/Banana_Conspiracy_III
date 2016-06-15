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
    var SwitchPosition : Int = 0
    let MovementSpeed : CGFloat = 10
    
    func Enemy( screenSize : CGPoint)
    {
        //They will be walking always, soo we'll just have 2 sprites of him walking
        EnemySprites.append(SKTexture(imageNamed:"ICUP0")) //right leg front
        EnemySprites.append(SKTexture(imageNamed:"ICUP1")) //left leg front
        EnemySprites.append(SKTexture(imageNamed:"ICUP2")) //attack
        
        self.Pawn("ICUP0", CGPointMake(0.15,0.15),true,1)
        
        //como as imagens estão todas viradas para a direita
        let side  = arc4random_uniform(2)

        if(side == 1)
        {
            //virar o men para o outro lado
            self.Node.xScale = -1
        }
        self.Node.zPosition = 2
    }
    
    public func Update(playerPos : CGPoint)
    {
        
        if(self.HP > 0)
        {
        //if the player is near enough, he will attack instead of doing anything else
        //a value that i think it's right, maybe self.size.width/2 + player.size.width/2 wouldn't be bad too
        
        var dist : CGFloat = abs(playerPos.x - self.Node.position.x)
        
        self.attackTimer -= 1
        
        if(dist < self.Node.size.width)
        {
            //Tirar o timer para saber se ele ataca ou nao
            if (self.attackTimer <= 0)
            {
                self.attackTimer = 20
                
                //to make him attack
                //Activate when you have sprites!!
                self.Node.texture = EnemySprites[2]
                
            }
        }
        //Se nao estiver perto do jogador, deve andar para perto dele
        else
        {
            if(self.Node.xScale > 0)
            {//Significa que esta do lado direito, ou seja, tem de vir para o esquerdo
                
                self.Node.position.x -= self.MovementSpeed
            }
            else
            {//Como esta do lado esquerdo, vai para o direito
                
                self.Node.position.x += self.MovementSpeed
                
            }
        }
        
        
        self.SwitchPosition -= 1
            
        if(self.SwitchPosition <= 0)
        {
            if(self.Node.texture == self.EnemySprites[0])
            {
                self.Node.texture = self.EnemySprites[1]
                }
                else
                {
                    self.Node.texture = self.EnemySprites[0]
                }
                self.SwitchPosition = 8
            }
        }
        
        
        //
    }
    
    public func moveEnemies(attackRight : Bool, distanceToMove :CGFloat)
    {
        //Se o Nerd estiver a atacar para a direita, o campo e tudo o resto deve mover-se para a esquerda
        //logo a coordenada X deve diminuir
        if(attackRight)
        {
            self.Node.position = CGPointMake(self.Node.position.x - distanceToMove, self.Node.position.y)
        }
        else
        {
            self.Node.position = CGPointMake(self.Node.position.x + distanceToMove, self.Node.position.y)
        }
        
    }
    
}