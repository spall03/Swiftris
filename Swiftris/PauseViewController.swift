//
//  PauseViewController.swift
//  Swiftris
//
//  Created by Stephen Palley on 2/25/15.
//  Copyright (c) 2015 SJP. All rights reserved.
//

import UIKit
import SpriteKit

class PauseViewController: UIViewController
{
    
    //var gameScore: Int!
    
    @IBAction func unwindToGameController(sender: UIStoryboardSegue)
    {
        // We need to tell our destination that we have resumed game play
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func didExitGame(sender: UIStoryboardSegue)
    {
    
        
//        print("game score is \(gameScore)")
//        //need to send score to leaderboard when game ends
//        GameKitHelper.sharedInstance.saveToLeaderboard(gameScore)
        
        dismissViewControllerAnimated(false, completion: nil)
    }
    


}

