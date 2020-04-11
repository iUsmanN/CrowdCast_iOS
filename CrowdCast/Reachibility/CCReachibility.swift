//
//  CCReachibility.swift
//  CrowdCast
//
//  Created by Usman on 11/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import Reachability
import Whisper

class CCReachibility {
    
    var result          : ((Result<Reachability.Connection, CCError>)->())?
    let reachability    = try? Reachability()
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability?.startNotifier()
        } catch {
            print("could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        guard let reachability = note.object as? Reachability else { return }
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
            result?(.success(.wifi))
        case .cellular:
            print("Reachable via Cellular")
            result?(.success(.wifi))
        case .unavailable:
            print("Network not reachable")
            result?(.failure(.internetError))
        default:
            print("default")
        }
    }
}
