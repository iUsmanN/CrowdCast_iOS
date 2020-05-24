//
//  CCCrowdsVM.swift
//  CrowdCast
//
//  Created by Usman on 13/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import Combine

class CCCrowdsVM {
    
    var sectionHeaderData : [CCSectionHeaderData] = [
        CCSectionHeaderData(title: "Your Crowds"  , rightButtonTitle: "Create New"      , rightButtonAction: .newGroup),
        CCSectionHeaderData(title: "Joined Crowds", rightButtonTitle: "Join Crowd"      , rightButtonAction: .joinGroup)
    ]
    
    let crowdsPublisher = PassthroughSubject<(dataAction, [IndexPath]), Never>()
    var myCrowds        = paginatedData<CCCrowd>()
    var joinedCrowds    = paginatedData<CCCrowd>()
    
    init() {
        fetchFreshData()
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
            return myCrowds.data[indexPath.section]
        case 1:
            return joinedCrowds.data[indexPath.section]
        default:
            prints("Unhandled Sectionn Data")
            return CCCrowd()
        }
    }
}

extension CCCrowdsVM : CCGroupsService {
    
    func fetchFreshData(){
        getGroups(type: .owned) { [weak self](result) in
            switch result {
            case .success(let groupData):
                self?.myCrowds.updateData(input: groupData)
                self?.publishCrowdsUpdates(action: .insert, newCreatedCrowds: groupData.data.count, newJoinedCrowds: 0)
            case .failure(let error):
                prints(error)
            }
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
