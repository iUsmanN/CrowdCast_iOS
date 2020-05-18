//
//  CCEndpoint.swift
//  CrowdCast
//
//  Created by Usman on 18/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

protocol Endpoint {
    var scheme      : String { get }
    var host        : String { get }
    var path        : String { get }
    var httpMethod  : HTTPMethod { get }
    var parameters  : [String:String]? { get set }
}

enum HTTPMethod     : String {
    case get        = "GET"
    case post       = "POST"
}
