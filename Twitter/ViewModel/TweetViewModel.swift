//
//  TweetViewModel.swift
//  Twitter
//
//  Created by Eugene Yehanovskiy on 10/20/20.
//

import UIKit

class TweetViewModel {
    let tweet: Tweet  // Nahuya? 
    let user: User
    
    var profileImageURL: URL? {
        return user.profileImageURL
    }
    
    var timestamp: String {
        let dateFormatter = DateComponentsFormatter()
        dateFormatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        dateFormatter.maximumUnitCount = 2
        dateFormatter.unitsStyle = .abbreviated
        let now = Date()
        //guard let dateString =
        return dateFormatter.string(from: tweet.timestamp, to: now) ?? ""
    }
    
    var userInfoLabel: NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: "\(user.fullName)", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)])
        attributedTitle.append(NSAttributedString(string: " @\(user.userName) ・ ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.lightGray]))
        
        attributedTitle.append(NSAttributedString(string: timestamp, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.lightGray]))
        
        return attributedTitle
    }
    
    
    init(tweet: Tweet) {
        self.tweet = tweet
        self.user = tweet.user
    }

}
