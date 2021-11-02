//
//  CCDynamicLinkEngine.swift
//  CrowdCast
//
//  Created by Usman on 14/06/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import FirebaseDynamicLinks
import Branch

protocol CCDynamicLinkEngine {}

extension CCDynamicLinkEngine {
    
    func generateShareLink<T: CCContainsID>(input: T?, completion: @escaping (Result<String?, CCError>)->()){
        //        let lp = linkProperties()
        //        lp.addControlParam("id", withValue: input?.id ?? "")
        //        lp.addControlParam("isGroup", withValue: input is CCChannel ? "false" : "true")
        //        universalObject().getShortUrl(with: lp) { (string, error) in
        //            guard error == nil else { completion(.failure(.branchLinkError)); return }
        //            completion(.success(string))
        //        }
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "crowdcast.page.link"
        
        let productIdQueryItem = URLQueryItem(name: "id", value: input?.id ?? "")
        let userIdQueryItem = URLQueryItem(name: "isGroup", value: input is CCChannel ? "false" : "true")
        
        components.queryItems = [productIdQueryItem, userIdQueryItem]
        
        guard let linkParameter = components.url else { return }
        
        let dynamicLinksDomainURIPrefix = "https://crowdcast.page.link"
        
        let linkBuilder = DynamicLinkComponents(link: linkParameter, domainURIPrefix: dynamicLinksDomainURIPrefix)
        
        if let bundleId = Bundle.main.bundleIdentifier {
            linkBuilder?.iOSParameters = DynamicLinkIOSParameters(bundleID: bundleId)
        }
        linkBuilder?.iOSParameters?.appStoreID = "1592823307"
        
        //        linkBuilder?.androidParameters = DynamicLinkAndroidParameters(packageName: SSConstants.androidBundleID)
        
        linkBuilder?.options = DynamicLinkComponentsOptions()
        linkBuilder?.options?.pathLength = .short
        
        linkBuilder?.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
        linkBuilder?.socialMetaTagParameters?.title = "Crowd Cast Link"
        
        linkBuilder?.socialMetaTagParameters?.descriptionText = "Open the link in app to join!"
        
        
        linkBuilder?.socialMetaTagParameters?.imageURL = URL(string: "https://i.ibb.co/s3Vs5Zq/Logo-Makr-1.png")
        
        
        guard let _ = (linkBuilder?.url) else { return }
        linkBuilder?.shorten(completion: { url, warnings, error in
            if let url = url {
                completion(.success(url.absoluteString))
            } else if let error = error {
                completion(.failure(.firebaseFailure))
            }
        })
    }
    
    func handleDynamicLink(link: DynamicLink) {
        guard let url = link.url else { return }
        guard (link.matchType == .unique) || (link.matchType == .default) else { return }
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else { return }
        
        print(queryItems.first(where: {$0.name == "id"})?.value)
        print(queryItems.first(where: {$0.name == "isGroup"})?.value)
    }
}

extension CCDynamicLinkEngine {
    
    private func universalObject() -> BranchUniversalObject {
        let buo = BranchUniversalObject(title: "CrowdCast Dynamic Link")
        return buo
    }
    
    private func linkProperties() -> BranchLinkProperties {
        let lp = BranchLinkProperties()
        lp.addControlParam("$ios_url", withValue: "http://apple.com")
        return lp
    }
}
