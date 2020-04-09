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
    
    func numberOfRows(section: Int) -> Int {
        switch section {
        case 0:
            return myChannels.data.count
        case 1:
            return joinedChannels.data.count
        default:
            return 0
        }
    }
    
    func dataForCellAt(indexPath: IndexPath) -> CCChannel {
        switch indexPath.section {
        case 0:
            return myChannels.data[indexPath.row]
        case 1:
            return joinedChannels.data[indexPath.row]
        default:
            return CCChannel()
        }
    }
}

extension CCChannelsVM : CCChannelsService, CCDispatch {
    
    func getData() {
        dispatchPriorityItem(.concurrent) {[weak self] in
            self?.getChannels(type: .owned) { [weak self] (result) in
                switch result {
                case .success(let fetchedData):
                    self?.myChannels.updateData(input: fetchedData)
                case .failure(let error):
                    prints("[Error] \(error)")
                }
            }
        }
        dispatchPriorityItem(.concurrent) {[weak self] in
            self?.getChannels(type: .joined) { [weak self] (result) in
                switch result {
                case .success(let fetchedData):
                    self?.myChannels.updateData(input: fetchedData)
                case .failure(let error):
                    prints("[Error] \(error)")
                }
            }
        }
    }
}
