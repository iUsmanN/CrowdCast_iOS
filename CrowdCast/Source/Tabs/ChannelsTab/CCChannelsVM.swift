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
    
    var tableViewUpdate : (([IndexPath]) -> ())?
    
    var sectionHeaderData : [CCSectionHeaderData] = [
        CCSectionHeaderData(title: "Your Channels"  , rightButtonTitle: "Create New"    , rightButtonAction: .newChannel),
        CCSectionHeaderData(title: "Joined Channels", rightButtonTitle: "Join Channel"  , rightButtonAction: .joinChannel)
    ]
    
    var myChannels      : paginatedData<CCChannel>?{
        didSet{
            tableViewUpdate?([IndexPath(row: 0, section: 0)])
        }
    }
    var joinedChannels  : paginatedData<CCChannel>?{
        didSet{
            tableViewUpdate?([IndexPath(row: 0, section: 1)])
        }
    }
    
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
            return myChannels?.data.count ?? 0
        case 1:
            return joinedChannels?.data.count ?? 0
        default:
            return 0
        }
    }
    
    func dataForCellAt(indexPath: IndexPath) -> CCChannel {
        switch indexPath.section {
        case 0:
            return myChannels?.data[indexPath.row] ?? CCChannel()
        case 1:
            return joinedChannels?.data[indexPath.row] ?? CCChannel()
        default:
            return CCChannel()
        }
    }
}

extension CCChannelsVM : CCChannelsService, CCDispatch {
    
    func getData() {
        
        myChannels = paginatedData<CCChannel>()
        joinedChannels = paginatedData<CCChannel>()
        
        dispatchPriorityItem(.concurrent) {[weak self] in
            self?.getChannels(type: .owned) { [weak self] (result) in
                switch result {
                case .success(let fetchedData):
                    self?.myChannels?.updateData(input: fetchedData)
                case .failure(let error):
                    prints("[Error] \(error)")
                }
            }
        }
        dispatchPriorityItem(.concurrent) {[weak self] in
            self?.getChannels(type: .joined) { [weak self] (result) in
                switch result {
                case .success(let fetchedData):
                    self?.myChannels?.updateData(input: fetchedData)
                case .failure(let error):
                    prints("[Error] \(error)")
                }
            }
        }
    }
}
