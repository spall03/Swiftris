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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showAuthenticationViewController", name: "present_authentication_view_controller", object: nil)
        
    }
    
    @IBAction func unwindToTitleViewController(segue: UIStoryboardSegue)
    {
        
    }
    
    
}
