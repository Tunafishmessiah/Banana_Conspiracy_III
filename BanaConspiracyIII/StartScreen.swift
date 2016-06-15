//
//  StartScreen.swift
//  BananaConspiracyIII
//
//  Created by a9632 - Pedro Carvalho on 15/06/16.
//  Copyright © 2016 a9632 - Pedro Carvalho. All rights reserved.
//


import Foundation
import SpriteKit
import AVFoundation


class StartScreen{
    
    var Image = Actor()
    var backgroundMusicPlayer = AVAudioPlayer()
    
    func StartScreen(childAdder : GameScene, start : Bool, points : Int?)
    {
        if(start)
        {
            Image.Actor("MainScreen", CGPointMake(0.5,0.5))
            Image.Node.position = CGPointMake(childAdder.size.width/2,childAdder.size.height/2)
            childAdder.addChild(Image.Node)
            
            
            SoundsUp("True Survivor - Kung Fury - 8 bit Remix [Menu].mp3")
        }
        else
        {
            Image.Actor("DeathScreen", CGPointMake(0.5,0.5))
            Image.Node.position = CGPointMake(childAdder.size.width/2,childAdder.size.height/2)
            childAdder.addChild(Image.Node)
            
            var label = SKLabelNode(fontNamed:"Chalkduster")
            label.fontColor = SKColor.yellowColor()
            label.position =  CGPointMake(childAdder.size.height/2,childAdder.size.width/2)
            label.fontSize = 30
            label.text = "You got \(points!) points! Try Again"
            
            childAdder.addChild(label)
            SoundsUp("True Survivor - Kung Fury - 8 bit Remix [Menu].mp3")
            
        }
    }
    
    func SoundsUp(filename : String)
    {
        let url = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
        guard let newURL = url else {
            print("Could not find file: \(filename)")
            return
        }
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: newURL)
            backgroundMusicPlayer.numberOfLoops = -1
            backgroundMusicPlayer.prepareToPlay()
            backgroundMusicPlayer.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func Delete (childAdder: GameScene)
    {
        backgroundMusicPlayer.stop()
        childAdder.removeAllChildren()
    }
}
