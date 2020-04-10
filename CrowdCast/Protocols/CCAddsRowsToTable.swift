//
//  CCAddsRowsToTable.swift
//  CrowdCast
//
//  Created by Usman on 10/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

protocol CCAddsRowsToTable {}

extension CCAddsRowsToTable {
    
    func getIndexPaths(oldMyChannelCount: Int?,
                       newMyChannelCount: Int?,
                       oldJoinedChannelCount: Int?,
                       newJoinedChannelCount: Int?) -> [IndexPath] {
        
        var indexPaths = [IndexPath]()
        
        if (newMyChannelCount ?? 0 > 0){
            guard let newMyChannelCount = newMyChannelCount else { return indexPaths }
            for index in 1...newMyChannelCount {
                indexPaths.append(IndexPath(row: (oldMyChannelCount ?? 1) - index, section: 0))
            }
        }
        
        if (newMyChannelCount ?? 0 > 0){
            guard let newJoinedChannelCount = newJoinedChannelCount else { return indexPaths }
            for index in 1...newJoinedChannelCount {
                indexPaths.append(IndexPath(row: (oldJoinedChannelCount ?? 1) - index, section: 0))
            }
        }
        
//        
//        for index in 1...newDataCount{
//            indexPaths.append(IndexPath(row: (previousDataCount ?? 1) - index, section: 0))
//        }
        
        return indexPaths
        //return [IndexPath(row: (previousDataCount ?? 1) - 1, section: 0), IndexPath(row: (previousDataCount ?? 1) - 2, section: 0)]
    }
}
