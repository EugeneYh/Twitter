//
//  ProfileHeaderViewModel.swift
//  Twitter
//
//  Created by Eugene Y on 21.11.2020.
//

import UIKit

struct ProfileHeaderViewModel {
    
    private let user: User
    
    let userNameText: String
    
    var followersString: NSAttributedString? {
        return createAttributedText(withValue: 0, text: " followers")
    }
    var followingString: NSAttributedString? {
        return createAttributedText(withValue: 2, text: " following")
    }
    var actionButtonTitle: String {
        if user.currentUser {
            return "Edit profile"
        } else {
            return "Follow"
        }
    }
    
    init(user: User) {
        self.user = user
        self.userNameText = "@\(user.userName)"
    }
    
    fileprivate func createAttributedText(withValue value: Int, text: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "\(value)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedString.append(NSAttributedString(string: text, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.lightGray]))
        return attributedString
    }
}
