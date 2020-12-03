//
//  ProfileFilterOptions.swift
//  Twitter
//
//  Created by Eugene Y on 17.11.2020.
//

import UIKit


enum ProfileFilterOptions: Int, CaseIterable {
    case tweets
    case replies
    case likes
    
    var description: String {
        switch self {
            case .tweets: return "Tweets"
            case .replies: return "Tweets & Replies"
            case .likes: return "Likes"
        }
    }
}

