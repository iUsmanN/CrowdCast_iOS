//
//  CCChannelDetailsVM.swift
//  CrowdCast
//
//  Created by Usman on 11/04/2020.
//  Copyright © 2020 Usman Nazir. All rights reserved.
//

import Foundation
import Combine



extension Notification.Name {
    static let newBlogPost = Notification.Name("new_blog_post")
}



struct CCChannelDetailsVM {
    
    
    
    var data = CCChannel()
    
    var titlePublisher = PassthroughSubject<String?, Never>()
//    var titlePublisher = NotificationCenter.Publisher(center: .default, name: Notification.Name("title"), object: nil).map { (notification) -> String in
//        return (notification.object as? String ?? "")
//    }
    
    init(channelData: CCChannel) {
        data = channelData
        //NotificationCenter.default.post(name: Notification.Name("title"), object: data.name)
        titlePublisher.send(data.name)
        //notifica
    }
    
    func publishData(){
        
    }
}
