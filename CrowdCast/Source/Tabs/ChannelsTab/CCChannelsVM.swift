//
//  CCChannelsVM.swift
//  CrowdCast
//
//  Created by Usman on 04/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

struct CCChannelsVM {
    
    var sectionHeaderData : [CCSectionHeaderData] = [
        CCSectionHeaderData(title: "Your Channels", rightButtonTitle: "Create New", rightButtonAction: .newChannel),
        CCSectionHeaderData(title: "Joined Channels", rightButtonTitle: "Join Channel", rightButtonAction: .joinChannel)
    ]

}

extension CCChannelsVM {
    
    func sectionHeader(section: Int) -> CCSectionHeaderData {
        return sectionHeaderData[section]
    }
    
    func numberOfSections() -> Int {
        return sectionHeaderData.count
    }
}
