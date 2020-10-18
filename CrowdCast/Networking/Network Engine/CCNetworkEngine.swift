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
    
    func request<T: Codable>(endpoint: Endpoint, result: @escaping (Result<T, CCError>)->()){
        var components      = URLComponents()
        components.scheme   = endpoint.scheme
        components.host     = endpoint.host
        components.path     = endpoint.path
        
        guard let url           = components.url else { return }
        var urlRequest          = URLRequest(url: url)
        urlRequest.httpMethod   = endpoint.httpMethod.rawValue
        
        let session     = URLSession(configuration: .default)
        let dataTask    = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else { return }
            guard response != nil else { return }
            guard let data      = data else { return }
            let responseObject  = try! JSONDecoder().decode(T.self, from: data)
            result(.success(responseObject))
        }
        dataTask.resume()
    }
}
