//
//  CCTwilioTokenEP.swift
//  CrowdCast
//
//  Created by Usman on 18/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

struct TwilioEndpoint : Endpoint {
    
    var parameters: [String : String]?
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "us-central1-crowdcast-31303.cloudfunctions.net"
    }
    
    var path: String {
        return "/app/token/\(params())"
    }
    
    func params() -> String {
        return CCProfileManager.sharedInstance.getUID()
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
}
