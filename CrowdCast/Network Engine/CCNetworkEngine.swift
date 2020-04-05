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
    
    func fetchData<T: Codable>(query: Query, completion: @escaping (Result<T, Error>) -> ()){
//        query.getDocuments { (response, error) in
//            guard error == nil, let data = response else {
//                guard let error = error else { return }
//                completion(.failure(error)); return }
//            completion(.success(data))
//        }
    }
    
}
