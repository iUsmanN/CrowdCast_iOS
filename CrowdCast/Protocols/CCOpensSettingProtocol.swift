//
//  CCOpensSettingProtocol.swift
//  CrowdCast
//
//  Created by Usman on 02/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import UIKit

protocol CCOpensSettings : UIViewController {}

extension CCOpensSettings {
    
    func opensSettings(){
        navigationController?.pushViewController(Constants.Storyboards.Others.instantiateViewController(withIdentifier: "CCSettingsVC"), animated: true)
    }
    
}
