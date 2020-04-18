//
//  CCAddsRowsToTable.swift
//  CrowdCast
//
//  Created by Usman on 10/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

protocol CCGetIndexPaths {}

extension CCGetIndexPaths {
    
    func getDualIndexPaths(oldMyChannelCount: Int?,
                       newMyChannelCount: Int?,
                       oldJoinedChannelCount: Int?,
                       newJoinedChannelCount: Int?,
                       countTuple: (Int, Int)) -> [IndexPath] {
        
        var indexPaths = [IndexPath]()
        
        if (newMyChannelCount ?? 0 > 0){
            guard let newMyChannelCount = newMyChannelCount else { return indexPaths }
            for index in 1...newMyChannelCount {
                indexPaths.append(IndexPath(row: (oldMyChannelCount ?? 1) - index, section: 0))
            }
        }
        
        if (newJoinedChannelCount ?? 0 > 0){
            guard let newJoinedChannelCount = newJoinedChannelCount else { return indexPaths }
            for index in 1...newJoinedChannelCount {
                indexPaths.append(IndexPath(row: (oldJoinedChannelCount ?? 1) - index, section: 1))
            }
        }
        
        return indexPaths
    }
    
    func getIndexPaths(array: [Int]) -> [IndexPath] {
        var indexPaths : [IndexPath]?
        indexPaths = array.compactMap { (index) -> IndexPath in
            return IndexPath(row: index, section: 0)
        }
        return indexPaths ?? [IndexPath]()
    }
}
