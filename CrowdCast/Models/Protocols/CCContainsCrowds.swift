//
//  CCContainsCrowds.swift
//  CrowdCast
//
//  Created by Usman on 05/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

protocol CCContainsCrowds : Codable {
    var crowds : [CCCrowd?]? { get set }
}