//
//  GameViewController.swift
//  Swiftris
//
//  Created by Stephen Palley on 2/23/15.
//  Copyright (c) 2015 SJP. All rights reserved.
//

import UIKit
import SpriteKit



class GameViewController: UIViewController
{
    //non-optional, will be assigned later.
    var scene: GameScene!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Configure the view.
        let skView = view as SKView
        skView.multipleTouchEnabled = false
        
        //Create and configure the scene.
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        //Present the scene.
        skView.presentScene(scene)
        


    }


    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
