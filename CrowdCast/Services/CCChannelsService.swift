//
//  CCChannelsService.swift
//  CrowdCast
//
//  Created by Usman on 05/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum channelType {
    case individual, group
}

protocol CCChannelsService : CCNetworkEngine {}

extension CCChannelsService {
    
    func getChannels(for: channelType, UID: String) {
        let db = Firestore.firestore()
        
        //        db.collection("develop").document("data").collection("channels").getDocuments { (documents, error) in
        //            guard error == nil, let data = documents else { prints("[ERROR] \(error?.localizedDescription ?? "")"); return }
        //
        //            prints("[DATA] : \(dump(data.documents.first?.data()) ?? "")")
        //        }
        
        db.collection("develop").document("data").collection("channels").order(by: FirebaseFirestore.FieldPath.documentID()).whereField("owners", arrayContains: UID).getDocuments { (documents, error) in
            guard error == nil, let data = documents else { prints("[ERROR] \(error?.localizedDescription ?? "")"); return }
            
            prints("[DATA] : \(dump(data.documents.first?.data()))")
        }
    }
}
