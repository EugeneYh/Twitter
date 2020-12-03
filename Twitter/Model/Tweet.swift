 //
//  Tweet.swift
//  Twitter
//
//  Created by Eugene Yehanovskiy on 10/17/20.
//

import Foundation

struct Tweet {
    let tweetId: String
    let caption: String
    let likes: Int
    let retweets: Int
    var timestamp: Date!
    let uid: String
    let user: User
    
    init(user: User, tweetId: String, dictionary: [String: Any]) {
        self.tweetId = tweetId
        self.user = user
        self.caption = dictionary["caption"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.retweets = dictionary["retweets"] as? Int ?? 0
        self.uid = dictionary["uid"] as? String ?? ""
        
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
    }
}
