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
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "crowdcast.page.link"
        
        let productIdQueryItem = URLQueryItem(name: "id", value: input?.id ?? "")
        let userIdQueryItem = URLQueryItem(name: "isGroup", value: input is CCChannel ? "false" : "true")

        components.queryItems = [productIdQueryItem, userIdQueryItem]
        guard let linkParameter = components.url else { return }
        let dynamicLinksDomainURIPrefix = "https://crowdcast.page.link"
        let linkBuilder = DynamicLinkComponents(link: linkParameter, domainURIPrefix: dynamicLinksDomainURIPrefix)
        if let bundleId = Bundle.main.bundleIdentifier { linkBuilder?.iOSParameters = DynamicLinkIOSParameters(bundleID: bundleId) }
        linkBuilder?.iOSParameters?.appStoreID = "1592823307"
        linkBuilder?.options = DynamicLinkComponentsOptions()
        linkBuilder?.options?.pathLength = .short
        linkBuilder?.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
        linkBuilder?.socialMetaTagParameters?.title = "Crowd Cast Link"
        linkBuilder?.socialMetaTagParameters?.descriptionText = "Open the link in app to join!"
        linkBuilder?.socialMetaTagParameters?.imageURL = URL(string: "https://i.ibb.co/8sHv6ks/Logo-Makr-729-Gct.png")
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
        
        CCDynamicLinkManager.id = queryItems.first(where: {$0.name == "id"})?.value
        CCDynamicLinkManager.isGroup = (queryItems.first(where: {$0.name == "isGroup"})?.value ?? "false") == "true" ? true : false
    }
}
