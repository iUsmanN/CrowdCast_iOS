//
//  CCChannelsVM.swift
//  CrowdCast
//
//  Created by Usman on 04/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class CCChannelsVM {
    
    var sectionHeaderData : [CCSectionHeaderData] = [
        CCSectionHeaderData(title: "Your Channels"  , rightButtonTitle: "Create New"    , rightButtonAction: .newChannel),
        CCSectionHeaderData(title: "Joined Channels", rightButtonTitle: "Join Channel"  , rightButtonAction: .joinChannel)
    ]
    
    var myChannels      = paginatedData<CCChannel>()
    var joinedChannels  = paginatedData<CCChannel>()
    
    init() {
        getData()
    }
}

extension CCChannelsVM {
    
    func sectionHeader(section: Int) -> CCSectionHeaderData {
        return sectionHeaderData[section]
    }
    
    func numberOfSections() -> Int {
        return sectionHeaderData.count
    }
}

extension CCChannelsVM : CCChannelsService {
    
    func getData() {
        
        getMyChannels() { [weak self] (result) in
            switch result {
            case .success(let fetchedData):
                self?.myChannels.updateData(input: fetchedData)
            case .failure(let error):
                prints("[Error] \(error)")
            }
        }
        
        getJoinedChannels() { [weak self] (result) in
            switch result {
            case .success(let fetchedData):
                self?.joinedChannels.updateData(input: fetchedData)
            case .failure(let error):
                prints("[Error] \(error)")
            }
        }
    }
}
