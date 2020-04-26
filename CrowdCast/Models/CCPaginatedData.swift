//
//  CCPaginatedData.swift
//  CrowdCast
//
//  Created by Usman on 05/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct paginatedData<T:CCContainsID>{
    var data = [T]()
    var next : CollectionReference?
    
    mutating func updateData(input: paginatedData<T>){
        self.data.append(contentsOf: input.data)
    }
    
    mutating func insertData(input: T){
        self.data.insert(input, at: 0)
    }
    
    mutating func removeData(input: T) -> Int? {
        guard let index = data.firstIndex(where: { (object) -> Bool in
            object.id == input.id
        }) else { return nil }
        data.remove(at: index)
        return index
    }
}
