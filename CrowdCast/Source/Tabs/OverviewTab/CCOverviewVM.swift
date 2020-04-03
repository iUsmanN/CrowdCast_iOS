//
//  CCOverviewVM.swift
//  CrowdCast
//
//  Created by Usman on 03/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

struct CCOverviewVM {
    
    var sectionHeaderData : [CCSectionHeaderData] = [
        CCSectionHeaderData(title: "Upcoming", rightButtonTitle: "View all", rightButtonAction: .viewAll),
        CCSectionHeaderData(title: "Hot Right Now", rightButtonTitle: nil, rightButtonAction: nil)
    ]

}

extension CCOverviewVM {
    
    func sectionHeader(section: Int) -> CCSectionHeaderData {
        return sectionHeaderData[section]
    }
}
