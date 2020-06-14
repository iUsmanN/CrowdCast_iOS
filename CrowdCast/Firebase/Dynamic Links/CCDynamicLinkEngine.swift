//
//  CCDynamicLinkEngine.swift
//  CrowdCast
//
//  Created by Usman on 14/06/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

protocol CCDynamicLinkEngine {}

extension CCDynamicLinkEngine {
    
    func generateShareLink<T: CCSharable>(input: T, completion: @escaping (Result<URL, CCError>)->()){
        
    }
}
