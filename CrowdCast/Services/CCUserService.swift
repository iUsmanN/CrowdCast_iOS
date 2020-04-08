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
    
    func fetchUserProfile(email: String, completion: @escaping (Result<CCUser, Error>) -> ()) {
        let query = make(.userProfileData, in: "email", equals: email)
        fetchData(query: query) { (result: Result<[CCUser], Error>) in
            switch result {
            case .success(let users): completion(.success(users.first!))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
    func addNewUser(uid: String?, email: String?, firstName: String?, lastName: String?, completion: @escaping (Result<Bool, Error>) -> ()) {
        
        do{
            let user = CCUser(id: uid, firstName: firstName, lastName: lastName, email: email)
            let _ = try addUser().addDocument(from: user, encoder: .init()) { (error) in
                guard error == nil else { completion(.failure(CCError.firebaseFailure)); return }
                completion(.success(true))
            }
        } catch {
            completion(.failure(CCError.firebaseFailure))
        }
        
    }
}
