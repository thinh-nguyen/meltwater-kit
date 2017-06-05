//
//  AuthProfile.swift
//  MeltwaterKit
//
//  Created by Thinh Nguyen on 5/23/17.
//  Copyright © 2017 Meltwater. All rights reserved.
//

import Foundation

@objc
public class AuthProfile: NSObject { //
    var userId: String?
    var email: String?
    var avatarUrl: URL?
    var companyId: String?
    
    public init(userId: String, companyId: String?, email: String?, avatarUrl: URL?) {
        self.userId = userId
        self.email = email
        self.avatarUrl = avatarUrl
        self.companyId = companyId
    }
}

@objc
public class AuthToken: NSObject {
    var idToken: String?
    var refreshToken: String?
    
    public init(idToken: String, refreshToken: String?) {
        self.idToken = idToken
        self.refreshToken = refreshToken
    }
}
