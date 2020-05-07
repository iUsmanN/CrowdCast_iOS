//
//  CCMiscellaneousExtensions.swift
//  CrowdCast
//
//  Created by Usman on 13/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    var redValue: CGFloat{ return CIColor(color: self).red }
    var greenValue: CGFloat{ return CIColor(color: self).green }
    var blueValue: CGFloat{ return CIColor(color: self).blue }
    var alphaValue: CGFloat{ return CIColor(color: self).alpha }
}

extension Array {
    
    func addedRows() -> [Int] {
        var arr = [Int]()
        for i in 0..<count {
            arr.append(i)
        }
        return arr
    }
}

extension URL {
    func getQueryLessURL() -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: false)
        components?.queryItems = nil
        return components?.url
    }
}
