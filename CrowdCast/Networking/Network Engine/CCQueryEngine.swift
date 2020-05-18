//
//  CCQueries.swift
//  CrowdCast
//
//  Created by Usman on 05/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase

protocol CCQueryEngine {}

extension CCQueryEngine {
    
    func collectionRef(_ type : CCQueryPath) -> CollectionReference {
        let db = Firestore.firestore()
        let env = "develop"
        return db.collection("\(env)\(type.rawValue)")
    }
    
    func documentRef(_ type : CCQueryPath) -> DocumentReference {
        let db = Firestore.firestore()
        let env = "develop"
        return db.collection("\(env)\(type.rawValue)").document()
    }
    
    func make(_ type : CCQueryPath, in which : String?, contains: [String?]) -> Query {
        let db = Firestore.firestore()
        let env = "develop"
        return db.collection("\(env)\(type.rawValue)")
                 .order(by: FirebaseFirestore.FieldPath.documentID())
            .whereField(which ?? "", arrayContainsAny: contains as [Any])
        
    }
    
    func make(_ type : CCQueryPath, in which : String?, contains: String) -> Query {
        let db = Firestore.firestore()
        let env = "develop"
        return db.collection("\(env)\(type.rawValue)")
                 .order(by: FirebaseFirestore.FieldPath.documentID())
                 .whereField(which ?? "", arrayContains: contains)
        
    }
    
    func make(_ type : CCQueryPath, in which : String?, equals: String?) -> Query {
        let db = Firestore.firestore()
        let env = "develop"
        return db.collection("\(env)\(type.rawValue)")
            .whereField(which ?? "", isEqualTo: equals as Any)
    }
    
    
}