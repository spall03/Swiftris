//
//  GameKitHelper.swift
//  Swiftris
//
//  Created by Stephen Palley on 3/2/15.
//  Copyright (c) 2015 SJP. All rights reserved.
//

import Foundation
import GameKit

class GameKitHelper: NSObject
{
    
    let PresentAuthenticationViewController = "present_authentication_view_controller"
    
    var authenticationViewController: UIViewController!
    var lastError: NSError?
    var enableGameCenter: Bool = true
    
//    func sharedGameKitHelper() -> GameKitHelper
//    {
//        let sharedInstance = GameKitHelper()
//        
//        return sharedInstance
//    }
    
    func authenticateLocalPlayer()
    {
        
        let localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(vc:UIViewController!, error:NSError?) -> Void in
            
            self.lastError = error
            
            if (vc? != nil)
            {
                self.authenticationViewController = vc
                NSNotificationCenter.defaultCenter().postNotificationName(self.PresentAuthenticationViewController, object: self)
                
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