//
//  CCDispatch.swift
//  CrowdCast
//
//  Created by Usman on 09/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

protocol CCDispatchQueue {}

extension CCDispatchQueue {
    
    /// Dispatch Priority Item
    /// - Parameters:
    ///   - type: Async/Sync
    ///   - code: Code Block to run
    /// - Returns: nil
    func dispatchPriorityItem(_ type: DispatchQueue.Attributes, code: @escaping ()->()){
        let queue = DispatchQueue(label: "com.CrowdCast.HighPriority", qos: .utility, attributes: type)
        queue.async(execute: DispatchWorkItem(block: code))
    }
    
}
