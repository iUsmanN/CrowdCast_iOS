//
//  CCChannelsService.swift
//  CrowdCast
//
//  Created by Usman on 05/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct paginatedData<T>{
    var data : [T]?
    var next : CollectionReference?
}

protocol CCChannelsService : CCNetworkEngine {}

extension CCChannelsService {
    
    func getChannels(UID: String, completion: @escaping (Result<paginatedData<CCChannel>, Error>) -> ()) {
        let db = Firestore.firestore()
        var output : [CCChannel]?
        
        let query = db.collection("develop/data/channels")
            .order(by: FirebaseFirestore.FieldPath.documentID())
            .whereField("owners", arrayContains: UID) //query till here
            .getDocuments { (documents, error) in
                guard error == nil, let data = documents else { prints("[ERROR]"); return }

                do {
                    output = try data.documents.compactMap({
                        try $0.data(as: CCChannel.self)
                    })
                    completion(.success(paginatedData<CCChannel>(data: output, next: nil)))
                } catch {
                    completion(.failure(CCError.channelFetchFailure))
                }
        }
    }
}
