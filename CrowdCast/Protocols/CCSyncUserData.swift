//
//  CCSyncUserData.swift
//  CrowdCast
//
//  Created by Usman on 27/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import UIKit

protocol CCSyncUserData : CCGetsViewController {}

extension CCSyncUserData {
    
    /// Syncs User Data
    /// - Parameters:
    ///   - uid: User ID
    ///   - result: completion handler
    /// - Returns: nil
    func syncUserData(uid: String, result: @escaping (Result<Any?, CCError>) -> ()){
        CCProfileManager.sharedInstance.syncData(uid: uid, result: result)
    }
    
    /// Opens Home Screen
    func moveToHome(){
        UIApplication.shared.windows.first?.rootViewController =
        instantiateViewController(storyboard: .Home, viewController: .CCTabBar, as: CCTabBarController())
    }
    
    /// Opens Login Screen
    func moveToLogin(){
        UIApplication.shared.windows.first?.rootViewController =
            instantiateViewController(storyboard: .Main, viewController: .CCLoginVC, as: CCLoginVC())
    }
}
