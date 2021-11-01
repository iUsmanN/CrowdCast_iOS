//
//  CCDynamicLinkEngine.swift
//  CrowdCast
//
//  Created by Usman on 14/06/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import Branch
import FirebaseDynamicLinks

protocol CCDynamicLinkEngine {}

extension CCDynamicLinkEngine {
    
    func generateShareLink<T: CCContainsID>(input: T?, completion: @escaping (Result<String?, CCError>)->()){
        let lp = linkProperties()
        lp.addControlParam("id", withValue: input?.id ?? "")
        lp.addControlParam("isGroup", withValue: input is CCChannel ? "false" : "true")
        universalObject().getShortUrl(with: lp) { (string, error) in
            guard error == nil else { completion(.failure(.branchLinkError)); return }
            completion(.success(string))
        }
        
//        guard let link = URL(string: "https://crowdcast.link") else { return }
//        let dynamicLinksDomainURIPrefix = "https://crowdcast.link"
//        let linkBuilder = DynamicLinkComponents(link: link, domainURIPrefix: dynamicLinksDomainURIPrefix)
//        linkBuilder?.iOSParameters = DynamicLinkIOSParameters(bundleID: "com.usmannazir.crowdcast")
//        completion(.success(linkBuilder?.url?.absoluteString))
//
//        guard let longDynamicLink = linkBuilder?.url else { return }
//        completion(.success(longDynamicLink.absoluteString))
//        linkBuilder?.shorten(completion: { shortLink, warnings, error in
//            completion(.success(shortLink?.absoluteString))
//        })
    }
}

extension CCDynamicLinkEngine {
    
    private func universalObject() -> BranchUniversalObject {
        let buo = BranchUniversalObject(title: "CrowdCast Dynamic Link")
        return buo
    }
    
    private func linkProperties() -> BranchLinkProperties {
        let lp = BranchLinkProperties()
        lp.addControlParam("$ios_url", withValue: "www.google.com")
        return lp
    }
}
