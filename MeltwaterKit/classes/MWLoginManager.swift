//
//  MWLoginManager.swift
//  MeltwaterKit
//
//  Created by Thinh Nguyen on 5/25/17.
//  Copyright © 2017 Meltwater. All rights reserved.
//

import UIKit
import Lock

public class MWLoginManager: NSObject {

    static var sharedManager = MWLoginManager()
    
    let magicLinkViewModel = MagicLinkViewModel()
    
    override init () {
        
    }
    
    func startMagicLinkWith(email: String, magicLinkDelegate: MagicLinkProtocol? ) {
        if let delegate = magicLinkDelegate {
            magicLinkViewModel.magicLinkDelegate = delegate
        }
        magicLinkViewModel.startMagicLinkWith(email: email)
    }
    
    /**
     *  
     */
    func openMagicLink(url: URL, sourceApplication: String?, loginDelegate: LoginProtocol?) -> Bool {
        if let delegate = loginDelegate {
            magicLinkViewModel.loginDelegate = delegate
        }
        return A0Lock.shared().handle(url, sourceApplication: sourceApplication)
    }
    
    /** 
     * continue Activity support HandsOff feature. We may not need it
     */
    func continueActivity(userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        let valid = A0Lock.shared().continue(userActivity, restorationHandler:restorationHandler)
        if( !valid ) {
            print("Error validating the magic link: \(String(describing: userActivity.webpageURL))")
        }
        return valid
    }
    
    func setLoginDelagate(delegate: LoginProtocol) {
        magicLinkViewModel.loginDelegate = delegate
    }
    
    func setMagicLinkDelagate(delegate: MagicLinkProtocol) {
        magicLinkViewModel.magicLinkDelegate = delegate
    }
}
