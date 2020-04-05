//
//  CCChannelsService.swift
//  CrowdCast
//
//  Created by Usman on 05/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol CCChannelsService : CCNetworkEngine, CCQueryEngine {}

extension CCChannelsService {
    
    func getChannels(UID: String, completion: @escaping (Result<paginatedData<CCChannel>, Error>) -> ()) {
        let query = makeQuery(.getChannels, in: "owners", contains: UID)
        fetchData(query: query, completion: completion)
    }
}
