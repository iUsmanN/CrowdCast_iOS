//
//  CCPaginatedData.swift
//  CrowdCast
//
//  Created by Usman on 05/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import FirebaseFirestore

struct paginatedData<T>{
    var data = [T]()
    var next : CollectionReference?
    
    mutating func updateData(input: paginatedData<T>){
        self.data.append(contentsOf: input.data)
    }
}
