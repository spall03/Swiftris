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
    
    @IBAction func unwindToGameController(sender: UIStoryboardSegue)
    {
        // We need to tell our destination that we have resumed game play
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func didExitGame(sender: UIStoryboardSegue)
    {
        dismissViewControllerAnimated(false, completion: nil)
    }
    


}

