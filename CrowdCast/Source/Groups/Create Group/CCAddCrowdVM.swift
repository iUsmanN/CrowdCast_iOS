//
//  CCAddGroupVM.swift
//  CrowdCast
//
//  Created by Usman on 21/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import UIKit

struct CCAddCrowdVM : CCGroupsService, CCImageStorage {
    
    func addGroup(groupName: String?, groupDescription: String?, image: UIImage?, completion: @escaping (Result<CCCrowd, CCError>)->()){
        let group = CCCrowd(id: nil,
                            name: groupName,
                            description: groupDescription,
                            owners: [CCProfileManager.sharedInstance.getUID()],
                            members: nil,
                            channels: nil)
        createGroup(groupInput: group) { (result) in
            switch result{
            case .success(let crowd):
                if let image = image {
                    self.uploadGroupImage(groupID: crowd.id ?? "", image: image, result: { (_) in
                        completion(.success(crowd))
                    })
                } else { completion(.success(crowd)) }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
