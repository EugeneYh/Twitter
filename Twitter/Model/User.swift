//
//  User.swift
//  Twitter
//
//  Created by Eugene Yehanovskiy on 10/15/20.
//

import Foundation

struct User {
    let fullName: String
    let userName: String
    let email: String
    var profileImageURL: URL?
    let uid: String
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        
        self.fullName = dictionary["fullName"] as? String ?? ""
        self.userName = dictionary["userName"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        if let profileImageURL = dictionary["profileImageURL"] as? String {
            guard let url = URL(string: profileImageURL) else { return }
            self.profileImageURL = url
        }
    }
}
