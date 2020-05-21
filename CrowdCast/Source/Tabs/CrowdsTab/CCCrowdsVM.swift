//
//  CCCrowdsVM.swift
//  CrowdCast
//
//  Created by Usman on 13/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

struct CCCrowdsVM {
    
    var sectionHeaderData : [CCSectionHeaderData] = [
        CCSectionHeaderData(title: "Your Crowds"  , rightButtonTitle: "Create New"      , rightButtonAction: .newGroup),
        CCSectionHeaderData(title: "Joined Crowds", rightButtonTitle: "Join Crowd"      , rightButtonAction: .joinGroup)
    ]

    
}

extension CCCrowdsVM {
    
    func titleForSection(section: Int) -> CCSectionHeaderData {
        return sectionHeaderData[section]
    }
}
