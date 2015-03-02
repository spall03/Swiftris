//
//  TimedGameViewController.swift
//  Swiftris
//
//  Created by Stephen Palley on 2/27/15.
//  Copyright (c) 2015 SJP. All rights reserved.
//

import UIKit
import SpriteKit

class TimedGameViewController: GameViewController
{
    
    var gameTimer: NSTimer!
    var secondTimer: NSTimer!
    var secondsLeft = 120
    @IBOutlet weak var timeLabel: UILabel!
    
    override func gameDidBegin(swiftris: Swiftris)
    {
        gameTimer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(secondsLeft), target: self, selector: "gameExpires", userInfo: nil, repeats: false)
        secondTimer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1), target: self, selector: "secondPasses", userInfo: nil, repeats: true)
            
        timeLabel.text = "\(self.secondsLeft)"
        super.gameDidBegin(swiftris)
    }
    
    func gameExpires()
    {
        print("the game has ended!")
        self.gameDidEnd(swiftris)
    }
    
    func secondPasses()
    {
        secondsLeft -= 1
        timeLabel.text = "\(self.secondsLeft)"
        
        //turn off the second timer when time is fully elapsed
        if secondsLeft == 0
        {
            secondTimer.invalidate()
        }
        
    }
    
    
    
}
