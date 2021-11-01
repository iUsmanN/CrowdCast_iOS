//
//  CCDynamicLinkEngine.swift
//  CrowdCast
//
//  Created by Usman on 14/06/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
//import Branch

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
    }
}

extension CCDynamicLinkEngine {
    
//    private func universalObject() -> BranchUniversalObject {
//        let buo = BranchUniversalObject(title: "CrowdCast Dynamic Link")
//        return buo
//    }
//    
//    private func linkProperties() -> BranchLinkProperties {
//        let lp = BranchLinkProperties()
//        lp.addControlParam("$ios_url", withValue: "http://apple.com")
//        return lp
//    }
}
