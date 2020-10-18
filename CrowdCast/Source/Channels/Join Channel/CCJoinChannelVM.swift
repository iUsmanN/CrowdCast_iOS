//
//  CCJoinChannelVM.swift
//  CrowdCast
//
//  Created by Usman on 09/05/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation

struct CCJoinChannelVM {
    var data                        : CCChannel?
    var bulletin                    = CCBulletinManager()
    
    var containsForeignLink         : Bool? {
        return (data?.foreignLink != nil && data?.foreignLink != "")
    }
    
    init(channel: CCChannel?) {
        data = channel
    }
}

extension CCJoinChannelVM {
    
    func channelName() -> String {
        return data?.name ?? ""
    }
    
    func getData() -> CCChannel? {
        return data
    }
}

extension CCJoinChannelVM {
    
    private func foreignLinkComponents() -> URLComponents? {
        guard containsForeignLink == true else { return nil }
        guard let components = URLComponents(string: data?.foreignLink ?? "") else { return nil }
        return components
    }
    
    func foreignURL() -> URL? {
        guard containsForeignLink == true else { return nil }
        return URL(string: data?.foreignLink ?? "")
    }
    
    func foreignLinkText() -> String {
        if((data?.foreignLink?.contains("meet.google.com")) == true){
            return "JOIN IN GOOGLE MEET"
        } else if ((data?.foreignLink?.contains("zoom.us")) == true){
            return "JOIN IN ZOOM"
        } else {
            return "JOIN USING FOREIGN LINK"
        }
    }
}

extension CCJoinChannelVM : CCDynamicLinkEngine {
    
    func generateDeeplink(){
        generateShareLink(input: data) { (result) in
            switch result {
            case .success(let string):
                prints(string)
                
            case .failure(let error):
                prints(error)
            }
        }
    }
}
