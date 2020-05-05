//
//  CCUserDefaults.swift
//  CrowdCast
//
//  Created by Usman on 05/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

struct CCUserDefaults {
    static let shared = CCUserDefaults()
    var users : UserDefaults?
    
    private init(){
        users = UserDefaults.init(suiteName: "users")
    }
    
    func saveCodableData <T: Codable> (key: String?, data: T, userDefaults: UserDefaults?) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            userDefaults?.set(encoded, forKey: key ?? "")
        }
    }
    
    func retrieveCodableData<T: Codable>(key: String?, userDefaults: UserDefaults?, type: T) -> T? {
        if let savedData = userDefaults?.object(forKey: key ?? "") as? Data {
            let decoder = JSONDecoder()
            if let retrievedData = try? decoder.decode(T.self, from: savedData) { return retrievedData }
        }
        return nil
    }
}
