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
        let env = Constants.environment
        return db.collection("\(env)\(type.rawValue)")
    }
    
    func documentRef(_ type : CCQueryPath) -> DocumentReference {
        let db = Firestore.firestore()
        let env = Constants.environment
        return db.collection("\(env)\(type.rawValue)").document()
    }
    
    func documentRef(_ type : CCQueryPath, id: String) -> DocumentReference {
        let db = Firestore.firestore()
        let env = Constants.environment
        return db.collection("\(env)\(type.rawValue)").document("\(id)")
    }
    
    func make(_ type : CCQueryPath, in which : String?, contains: String) -> Query {
        let db = Firestore.firestore()
        let env = Constants.environment
        return db.collection("\(env)\(type.rawValue)")
                 .order(by: FirebaseFirestore.FieldPath.documentID())
                 .whereField(which ?? "", arrayContains: contains)
        
    }
    
    func make(_ type : CCQueryPath, in which : String?, equals: String?) -> Query {
        let db = Firestore.firestore()
        let env = Constants.environment
        return db.collection("\(env)\(type.rawValue)")
            .whereField(which ?? "", isEqualTo: equals as Any)
    }
}


//MARK: USERS
extension CCQueryEngine {
    
    func userProfile(uid: String?) -> Query {
        let db = Firestore.firestore()
        let env = Constants.environment
        return db.collection("\(env)\(CCQueryPath.userProfileData.rawValue)").whereField("id", isEqualTo: uid ?? "")
    }
}

//MARK: GROUPS
extension CCQueryEngine {
    
    func userGroups() -> Query {
        let db = Firestore.firestore()
        let env = Constants.environment
        return db.collection("\(env)\(CCQueryPath.userCrowds.rawValue)").whereField("id", isEqualTo: CCProfileManager.sharedInstance.getUID())
    }
    
    func groupData(ids: [String]?) -> Query {
        let db = Firestore.firestore()
        let env = Constants.environment
        return db.collection("\(env)\(CCQueryPath.crowdData.rawValue)").whereField("id", in: ids ?? [String]())
    }
    
    func userGroupsDocReferrence() -> DocumentReference {
        let db = Firestore.firestore()
        let env = Constants.environment
        return db.document("\(env)\(CCQueryPath.userCrowds.rawValue)/\(CCProfileManager.sharedInstance.getUID())")
    }
    
    func groupChannels(id: String) -> Query {
        let db = Firestore.firestore()
        let env = Constants.environment
        return db.collection("\(env)\(CCQueryPath.groupChannels.rawValue)").whereField("id", isEqualTo: id)
    }
    
    func groupChannelsDocReferrence(groupID: String) -> DocumentReference {
        let db = Firestore.firestore()
        let env = Constants.environment
        return db.document("\(env)\(CCQueryPath.groupChannels.rawValue)/\(groupID)")
    }
}

//MARK: CHANNELS
extension CCQueryEngine {
    
    func userChannels() -> Query {
        let db = Firestore.firestore()
        let env = Constants.environment
        return db.collection("\(env)\(CCQueryPath.userChannels.rawValue)").whereField("id", isEqualTo: CCProfileManager.sharedInstance.getUID())
    }
    
    func channelData(ids: [String]?) -> Query {
        let db = Firestore.firestore()
        let env = Constants.environment
        return db.collection("\(env)\(CCQueryPath.channelsData.rawValue)").whereField("id", in: ids ?? [String]())
    }
    
    func userChannelsDocReferrence() -> DocumentReference {
        let db = Firestore.firestore()
        let env = Constants.environment
        return db.document("\(env)\(CCQueryPath.userChannels.rawValue)/\(CCProfileManager.sharedInstance.getUID())")
    }
    
    func channelUsersDocReferrence(id: String?) -> DocumentReference {
        let db = Firestore.firestore()
        let env = Constants.environment
        return db.document("\(env)\(CCQueryPath.channelUsers.rawValue)/\(id ?? "")")
    }
    
    func userChannel(id: String?) -> DocumentReference {
        let db = Firestore.firestore()
        let env = Constants.environment
        return db.document("\(env)\(CCQueryPath.channelsData.rawValue)/\(id ?? "")")
    }
    
//    func channelUsers(id: String?) -> CollectionReference {
//        let db = Firestore.firestore()
//        let env = Constants.environment
//        return db.collection("\(env)\(CCQueryPath.userChannels.rawValue)")
//    }
}
