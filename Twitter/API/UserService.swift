//
//  UserService.swift
//  Twitter
//
//  Created by Eugene Yehanovskiy on 10/15/20.
//

import Firebase

struct UserService {
    static let shared = UserService()
    
    func fetchUser(complition: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            guard let userInfo  = snapshot.value as? [String: AnyObject] else { return }
            
            let user = User(uid: uid, dictionary: userInfo)
            
            complition(user)
        }
    }
}
