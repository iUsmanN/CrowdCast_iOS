//
//  CCDeeplinkService.swift
//  CrowdCast
//
//  Created by Usman on 06/06/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import FirebaseDynamicLinks

protocol CCSharelinkService {}

extension CCSharelinkService {
    
    func generateSharelink(id: String, type: CCJoinableType, completion: @escaping (Result<String, CCError>)->()){
        
        guard let link = URL(string: "https://crowdcast.page.link") else { return }
        let dynamicLinksDomainURIPrefix = "https://crowdcast.page.link/link"
        let linkBuilder = DynamicLinkComponents(link: link, domainURIPrefix: dynamicLinksDomainURIPrefix)
        linkBuilder?.iOSParameters = DynamicLinkIOSParameters(bundleID: "com.example.ios")
        linkBuilder?.androidParameters = DynamicLinkAndroidParameters(packageName: "com.example.android")

        guard let longDynamicLink = linkBuilder?.url else { return }
        print("The long URL is: \(longDynamicLink)")
        
    }
}
