//
//  AppDelegate.swift
//  CrowdCast
//
//  Created by Usman on 22/03/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import UIKit
import Branch
import Firebase
import FirebaseDynamicLinks
import Kingfisher
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CCUniversalCallToggle {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 120
        ImageCache.default.diskStorage.config.expiration = .never
        setInitialCallToggles()
        
        Branch.getInstance().resetUserSession()
        Branch.getInstance().initSession(launchOptions: launchOptions) { (params, error) in
            print(params as? [String: AnyObject] ?? {})
        }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        print("A")
        return true
//        if let incomingURL = userActivity.webpageURL {
//            let handled = DynamicLinks.dynamicLinks().handleUniversalLink(incomingURL) { dynamicLink, error in
//                if let error = error {
//                    print("Error", error.localizedDescription)
//                    return
//                }
//                if let dynamicLink = dynamicLink {
//                    DynamicLinksHandler.shared.handleDynamicLink(link: dynamicLink)
//                }
//            }
//            if handled {
//                return true
//            } else {
//                return false
//            }
//        } else {
//            return false
//        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        return application(app, open: url,
                           sourceApplication: options[UIApplication.OpenURLOptionsKey
                                                        .sourceApplication] as? String,
                           annotation: "")
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?,
                     annotation: Any) -> Bool {
        if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url) {
                handleDynamicLink(link: dynamicLink)
            return true
        }
        return false
    }
}

extension AppDelegate : CCDynamicLinkEngine {}
