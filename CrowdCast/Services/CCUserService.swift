//
//  CCUserService.swift
//  CrowdCast
//
//  Created by Usman on 06/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol CCUserService : CCNetworkEngine, CCQueryEngine {}

extension CCUserService {
    
    func fetchUserProfile(email: String, completion: @escaping (Result<paginatedData<CCChannel>, Error>) -> ()) {
        let query = makeQuery(.getUserProfile, in: "email", equals: "usman@usman.com")
        //fetchPaginatedData(query: query, completion: completion)
    }
}
