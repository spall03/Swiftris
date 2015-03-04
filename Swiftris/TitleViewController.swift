//
//  TitleViewController.swift
//  Swiftris
//
//  Created by Stephen Palley on 2/25/15.
//  Copyright (c) 2015 SJP. All rights reserved.
//

import UIKit
import SpriteKit



class TitleViewController: UIViewController
{
    
    override func viewDidAppear(animated: Bool)
    {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showAuthenticationViewController", name: SPPresentAuthenticationViewController, object: nil)
        
        GameKitHelper.sharedInstance.authenticateLocalPlayer()
    }
    
    func showAuthenticationViewController()
    {
        
        self.presentViewController(GameKitHelper.sharedInstance.authenticationViewController, animated: true, completion: nil)
        
        
    }
    
    @IBAction func unwindToTitleViewController(segue: UIStoryboardSegue)
    {
        
    }
    
    
}
