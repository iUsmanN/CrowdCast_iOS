//
//  CCDispatch.swift
//  CrowdCast
//
//  Created by Usman on 09/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

protocol CCDispatch {}

extension CCDispatch {
    
    func dispatchPriorityItem(_ type: DispatchQueue.Attributes, code: @escaping ()->()){
        let queue = DispatchQueue(label: "com.CrowdCast.HighPriority", qos: .utility, attributes: type)
        queue.async(execute: DispatchWorkItem(block: code))
    }
    
}
