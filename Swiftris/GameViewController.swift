//
//  GameViewController.swift
//  Swiftris
//
//  Created by Stephen Palley on 2/23/15.
//  Copyright (c) 2015 SJP. All rights reserved.
//

import UIKit
import SpriteKit



class GameViewController: UIViewController, SwiftrisDelegate, UIGestureRecognizerDelegate
{
    //non-optional, will be assigned later.
    var scene: GameScene!
    var swiftris: Swiftris!
    
    var panPointReference:CGPoint?
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //add listener for when game enters background or foreground
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "gameDidEnterBackground", name: swiftrisDidEnterBackground, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "gameDidResume", name: swiftrisDidEnterForeground, object: nil)
        
        
        //Configure the view.
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        
        //Create and configure the scene.
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        scene.tick = didTick
        
        swiftris = Swiftris()
        swiftris.delegate = self
        swiftris.beginGame()
        
        //Present the scene.
        skView.presentScene(scene)
        
        


    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func didTick() {
        swiftris.letShapeFall()
        swiftris.fallingShape?.lowerShapeByOneRow()
        scene.redrawShape(swiftris.fallingShape!, completion: {})
    }
    
    func nextShape() {
        let newShapes = swiftris.newShape()
        if let fallingShape = newShapes.fallingShape {
            self.scene.addPreviewShapeToScene(newShapes.nextShape!) {}
            self.scene.movePreviewShape(fallingShape) {
                // #2
                self.view.userInteractionEnabled = true
                self.scene.startTicking()
            }
        }
    }
    
    func gameDidBegin(swiftris: Swiftris) {
        levelLabel.text = "\(swiftris.level)"
        scoreLabel.text = "\(swiftris.score)"
        scene.tickLengthMillis = TickLengthLevelOne
        
        // The following is false when restarting a new game
        if swiftris.nextShape != nil && swiftris.nextShape!.blocks[0].sprite == nil {
            scene.addPreviewShapeToScene(swiftris.nextShape!) {
                self.nextShape()
            }
        } else {
            nextShape()
        }
    }
    
    @IBAction func didSwipe(sender: UISwipeGestureRecognizer) {
        
        swiftris.dropShape()
    }
    
    @IBAction func didTap(sender: UITapGestureRecognizer) {
        
        swiftris.rotateShape()
        
    }
    
    @IBAction func didPan(sender: UIPanGestureRecognizer) {
        
        let currentPoint = sender.translationInView(self.view)
        if let originalPoint = panPointReference {
            // #3
            if abs(currentPoint.x - originalPoint.x) > (BlockSize * 0.9) {
                // #4
                if sender.velocityInView(self.view).x > CGFloat(0) { //determining if it's a right swipe or a left swipe control
                    swiftris.moveShapeRight()
                    panPointReference = currentPoint
                } else {
                    swiftris.moveShapeLeft()
                    panPointReference = currentPoint
                }
            }
        } else if sender.state == .Began {
            panPointReference = currentPoint
        }
        
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // #2
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailByGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if let swipeRec = gestureRecognizer as? UISwipeGestureRecognizer {
            if let panRec = otherGestureRecognizer as? UIPanGestureRecognizer {
                return true
            }
        } else if let panRec = gestureRecognizer as? UIPanGestureRecognizer {
            if let tapRec = otherGestureRecognizer as? UITapGestureRecognizer {
                return true
            }
        }
        return false
    }
    
    func gameDidEnterBackground()
    {
        scene.stopTicking()
        scene.stopThemeMusic()
        
        print("Game entered background!")
        
//        let pauseViewController = PauseViewController()
//        self.presentViewController(pauseViewController, animated: false, completion: nil)
        
        
        
    }
    
    @IBAction func gameDidPause(sender: UIButton) {
        scene.stopTicking()
        scene.stopThemeMusic()
        
//        let pauseViewController = PauseViewController()
//        pauseViewController.gameScore = swiftris.score
//        
//        let segue = UIStoryboardSegue(identifier: "PauseGameSegue", source: self, destination: pauseViewController)
//        
//        self.performSegueWithIdentifier(, sender: self)
        
    }

    @IBAction func gameDidResume() {
        scene.startTicking()
        scene.resumeThemeMusic()
    }

    
    func gameDidEnd(swiftris: Swiftris) {
        view.userInteractionEnabled = false
        scene.stopTicking()
        scene.playSound("gameover.mp3")
        scene.animateCollapsingLines(swiftris.removeAllBlocks(), fallenBlocks: Array<Array<Block>>()) {

        }
        
        GameKitHelper.sharedInstance.saveToLeaderboard(swiftris.score)
       
        let endGameAlertViewController = UIAlertController(title: "Game Over!", message: "Congrats! You scored \(swiftris.score)", preferredStyle: UIAlertControllerStyle.Alert)
        let endGameOKButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) in
            
            self.performSegueWithIdentifier("GameOverSegue", sender: self)
            
        }
        
        endGameAlertViewController.addAction(endGameOKButton)
        
        presentViewController(endGameAlertViewController, animated: true, completion: nil)
    
    }
    
    
    func gameDidLevelUp(swiftris: Swiftris) {
        
        levelLabel.text = "\(swiftris.level)"
        if scene.tickLengthMillis >= 100 {
            scene.tickLengthMillis -= 100
        } else if scene.tickLengthMillis > 50 {
            scene.tickLengthMillis -= 50
        }
        scene.playSound("levelup.mp3")
        
    }
    
    func gameShapeDidDrop(swiftris: Swiftris) {
        
        scene.stopTicking()
        scene.redrawShape(swiftris.fallingShape!) {
            swiftris.letShapeFall()
        }
        
        scene.playSound("drop.mp3")
        
    }
    
    func gameShapeDidLand(swiftris: Swiftris) {
        scene.stopTicking()
        self.view.userInteractionEnabled = false
        // #1
        let removedLines = swiftris.removeCompletedLines()
        if removedLines.linesRemoved.count > 0 {
            self.scoreLabel.text = "\(swiftris.score)"
            scene.animateCollapsingLines(removedLines.linesRemoved, fallenBlocks:removedLines.fallenBlocks) {
                // #2
                self.gameShapeDidLand(swiftris)
            }
            scene.playSound("bomb.mp3")
        } else {
            nextShape()
        }
    }
    
    // #3
    func gameShapeDidMove(swiftris: Swiftris) {
        scene.redrawShape(swiftris.fallingShape!) {}
    }
    
    @IBAction func unwindToGameViewController(segue: UIStoryboardSegue)
    {
        if segue.identifier == "ContinueGame"
        {
            gameDidResume()
        }
        else if segue.identifier == "EndGame"
        {
            GameKitHelper.sharedInstance.saveToLeaderboard(swiftris.score)
            dismissViewControllerAnimated(false, completion: nil)
        }
        
        
    }
}

