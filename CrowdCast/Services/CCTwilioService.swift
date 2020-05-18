//
//  CCTwilioService.swift
//  CrowdCast
//
//  Created by Usman on 18/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

protocol CCTwilioService : CCNetworkEngine {}

extension CCTwilioService {
    func refreshAccessToken(result: @escaping (Result<CCTwilioTokenModel, CCError>)->()) {
        request(endpoint: TwilioEndpoint(), result: result)
    }
}
