//
//  GameKitHelper.swift
//  Swiftris
//
//  Created by Stephen Palley on 3/2/15.
//  Copyright (c) 2015 SJP. All rights reserved.
//

import Foundation
import GameKit

let SPPresentAuthenticationViewController = "present_authentication_view_controller"

private let singletonInstance = GameKitHelper()

class GameKitHelper: NSObject
{
    
    
    var authenticationViewController: UIViewController!
    var lastError: NSError?
    var enableGameCenter: Bool = true

    class var sharedInstance: GameKitHelper
    {
            return singletonInstance
    }
    
    
    func authenticateLocalPlayer()
    {
        
        let localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(vc:UIViewController!, error:NSError?) -> Void in
            
            self.lastError = error
            
            if (vc != nil)
            {
                self.authenticationViewController = vc
                NSNotificationCenter.defaultCenter().postNotificationName(SPPresentAuthenticationViewController, object: self)
                
            }
            else if (localPlayer.authenticated)
            {
                self.enableGameCenter = true
            
            
            }
            else
            {
                self.enableGameCenter = false
                
            }
        
        
        
        }
    }

}