//
//  CCNetworkEngine.swift
//  CrowdCast
//
//  Created by Usman on 05/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol CCNetworkEngine {}

extension CCNetworkEngine {
    
    func fetchData<T: Codable>(query: Query, completion: @escaping (Result<[T], Error>) -> ()){
        query.getDocuments { (documents, error) in
            guard error == nil, let data = documents else {
                completion(.failure(CCError.firebaseFailure))
                return
            }
            do {
                let output = try data.documents.compactMap({ try $0.data(as: T.self) })
                completion(.success(output))
            } catch {
                completion(.failure(CCError.networkEngineFailure))
            }
        }
    }
}
