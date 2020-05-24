//
//  CCCrowdChannelsVM.swift
//  CrowdCast
//
//  Created by Usman on 24/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

struct CCCrowdChannelsVM {
    
    var sectionHeaderData : [CCSectionHeaderData] = [CCSectionHeaderData(title: "Channels", rightButtonTitle: nil, rightButtonAction: nil)]
    
    var crowdData : CCCrowd?
    
    init(crowdDataInput: CCCrowd?) {
        crowdData = crowdDataInput
    }
}
