//
//  CCCrowdsVM.swift
//  CrowdCast
//
//  Created by Usman on 13/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import Combine
import FirebaseFirestore

class CCCrowdsVM {
    
    var sectionHeaderData : [CCSectionHeaderData] = [
        CCSectionHeaderData(title: "Your Crowds"  , rightButtonTitle: "Create New"      , rightButtonAction: .newGroup),
        CCSectionHeaderData(title: "Joined Crowds", rightButtonTitle: "Join Crowd"      , rightButtonAction: .joinGroup)
    ]
    
    let crowdsPublisher = PassthroughSubject<(dataAction, [IndexPath]), Never>()
    var myCrowds        = paginatedData<CCCrowd>()
    var joinedCrowds    = paginatedData<CCCrowd>()
    
    init() {
        setupDataListeners()
    }
}

extension CCCrowdsVM {
    
    func titleForSection(section: Int) -> CCSectionHeaderData {
        return sectionHeaderData[section]
    }
    
    func numberOfRows(section: Int) -> Int {
        switch section {
        case 0:
            return myCrowds.data.count
        case 1:
            return joinedCrowds.data.count
        default:
            prints("Unhandled Section Row Count")
            return 0
        }
    }
    
    func dataForItem(indexPath: IndexPath) -> CCCrowd {
        switch indexPath.section {
        case 0:
            return myCrowds.data[indexPath.row]
        case 1:
            return joinedCrowds.data[indexPath.row]
        default:
            prints("Unhandled Sectionn Data")
            return CCCrowd()
        }
    }
}

extension CCCrowdsVM : CCGroupsService, CCDispatchQueue {
    
    func fetchFreshData() {
        
        let dg = DispatchGroup()
        var newMyCrowds      = 0
        var newJoinedCrowds  = 0
        
        myCrowds.clearData()
        joinedCrowds.clearData()
        
        dg.enter()
        dispatchPriorityItem(.concurrent) {[weak self] in
            self?.getGroups(type: .owned) { [weak self](result) in
                switch result {
                case .success(let groupData):
                    self?.myCrowds.updateData(input: groupData)
                    newMyCrowds = groupData.data.count
                    dg.leave()
                case .failure(let error):
                    prints(error)
                    dg.leave()
                }
            }
        }
        
        dg.enter()
        dispatchPriorityItem(.concurrent) {[weak self] in
            self?.getGroups(type: .member) { [weak self](result) in
                switch result {
                case .success(let groupData):
                    self?.joinedCrowds.updateData(input: groupData)
                    newJoinedCrowds = groupData.data.count
                    dg.leave()
                case .failure(let error):
                    prints(error)
                    dg.leave()
                }
            }
        }
        
        dg.notify(queue: .global()) { [weak self] in
            self?.publishCrowdsUpdates(action: .insert, newCreatedCrowds: newMyCrowds, newJoinedCrowds: newJoinedCrowds)
        }
    }
}


extension CCCrowdsVM : CCGetIndexPaths, CCCrowdActionDelegate {
    
    func crowdAdded(data: CCCrowd) {
        myCrowds.insertData(input: data)
        publishCrowdsUpdates(action: .insert, newCreatedCrowds: 1, newJoinedCrowds: 0)
    }
    
    func crowdRemoved(data: CCCrowd) {
        guard let removalIndex = myCrowds.removeData(input: data) else { return }
        crowdsPublisher.send((dataAction.remove, myRemovalIndexPath(index: removalIndex)))
    }
    
    
    func publishCrowdsUpdates(action: dataAction, newCreatedCrowds: Int, newJoinedCrowds: Int){
        crowdsPublisher.send((action, getDualIndexPaths(oldMyChannelCount: myCrowds.data.count,
                                                        newMyChannelCount: newCreatedCrowds,
                                                        oldJoinedChannelCount: joinedCrowds.data.count,
                                                        newJoinedChannelCount: newJoinedCrowds,
                                                        countTuple: (newCreatedCrowds, newJoinedCrowds)) ))
    }
}

extension CCCrowdsVM {
    
    func setupDataListeners(){
        userGroupsDocReferrence().addSnapshotListener { [weak self](snapshot, error) in
            self?.fetchFreshData()
        }
    }
}
