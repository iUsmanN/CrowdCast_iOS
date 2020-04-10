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
    
    func getIndexPaths(previousDataCount: Int?, newDataCount: Int, section: Int) -> [IndexPath] {
        
        var indexPaths = [IndexPath]()
        for index in 1...newDataCount{
            indexPaths.append(IndexPath(row: (previousDataCount ?? 1) - index, section: 0))
        }
        
        return [IndexPath(row: (previousDataCount ?? 1) - 1, section: 0), IndexPath(row: (previousDataCount ?? 1) - 2, section: 0)]
    }
}
