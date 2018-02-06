//
//  Post.swift
//  Post
//
//  Created by Taylor Bills on 2/5/18.
//  Copyright © 2018 Taylor Bills. All rights reserved.
//

import Foundation

struct Post: Codable {
    
    // MARK: -  Properties
    
    let userName: String
    let text: String
    let timestamp: TimeInterval
    
    init(userName: String, text: String, timestamp: TimeInterval = Date.timeIntervalBetween1970AndReferenceDate) {
        self.userName = userName
        self.text = text
        self.timestamp = timestamp
    }
}
