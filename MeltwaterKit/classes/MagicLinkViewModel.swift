//
//  MagicLinkViewModel.swift
//  MeltwaterKit
//
//  Created by Thinh Nguyen on 5/23/17.
//  Copyright © 2017 Meltwater. All rights reserved.
//

import Foundation
import Auth0
import Lock

@objc
protocol LoginProtocol: class {
    @objc optional func onLoginSuccess(profile: AuthProfile, token: AuthToken)
    @objc optional func onLoginFailure(error: Error)
}

@objc
protocol MagicLinkProtocol: class {
    @objc optional func onEmailSent()
    @objc optional func onEmailFailure(error: Error)
}

public class MagicLinkViewModel {
    
    let AUTH_EMAIL_KEY = "authEmailKey"
    var loginDelegate: LoginProtocol?
    var magicLinkDelegate: MagicLinkProtocol?
   
    public init() {
        NotificationCenter.default.addObserver(self, selector: #selector(loginWithNotification), name: NSNotification.Name(rawValue: A0LockNotificationUniversalLinkReceived), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func startMagicLinkWith( email: String ) {
        let lock = A0Lock.shared()
        
        let client = lock.apiClient()
        let params = A0AuthParameters.newDefaultParams()
        params[A0ParameterProtocol] = Bundle.main.bundleIdentifier
        
        client.startPasswordlessWithMagicLink(inEmail: email,
                                              parameters: params,
                                              success: {
                                                print("Sent email to \(email)")
                                                let defaults = UserDefaults.standard
                                                defaults.set(email, forKey: self.AUTH_EMAIL_KEY)
                                                DispatchQueue.main.async {
                                                    if let del = self.magicLinkDelegate {
                                                        del.onEmailSent?()
                                                    }
                                                }
                                                
        },
                                              failure: { error in
                                                print(error)
                                                if let del = self.magicLinkDelegate {
                                                    del.onEmailFailure!(error: error)
                                                }
        })
    
    }
    
    @objc fileprivate func loginWithNotification(note: Notification) {
        if let link = note.userInfo?[A0LockNotificationUniversalLinkParameterKey]{
            let urlComponents = NSURLComponents(string: (link as! URL).absoluteString)!
            let code = (urlComponents.queryItems! as [NSURLQueryItem])
                .filter({ (item) in item.name == "code" }).first?
                .value
            let lock = A0Lock.shared()
            let client = lock.apiClient()
            let defaults = UserDefaults.standard
            
            if let email = defaults.string(forKey: AUTH_EMAIL_KEY) {
                client.login(withEmail: email,
                             passcode: code!, parameters: nil,
                             success: { profile, token in
                                if let del = self.loginDelegate {
                                    let prof = AuthProfile(userId: profile.userId, companyId: profile.extraInfo["companyId"] as? String, email:profile.email, avatarUrl: profile.picture)
                                    let tok = AuthToken(idToken: token.idToken, refreshToken: token.refreshToken)
                                    del.onLoginSuccess?(profile: prof, token: tok)
                                }
                },
                             failure: { error in
                                print( "Error login with code \(String(describing: code)): \(error)")
                                if let del = self.loginDelegate {
                                    del.onLoginFailure?( error: error )
                                }
                })
            }
            
        }
    }

}
