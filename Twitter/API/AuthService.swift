//
//  AuthService.swift
//  Twitter
//
//  Created by Eugene Yehanovskiy on 10/15/20.
//

import UIKit
import Firebase
import FirebaseStorage

struct AuthCredentials {
    let email: String
    let password: String
    let fullName: String
    let userName: String
    let profileImage: UIImage?
}

struct AuthService {
    static let shared = AuthService()
    
    func logUserIn(email: String, password: String, complition: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: complition)
    }
    
    func registerUser(credentials: AuthCredentials, completion: @escaping(Error?, DatabaseReference) -> Void) {
        let email = credentials.email
        let password = credentials.password
        let userName = credentials.userName
        let fullName = credentials.fullName
        
        guard let imageData = credentials.profileImage?.jpegData(compressionQuality: 0.3) else {return}
        let fileName = UUID().uuidString
        let storageRef = STORAGE_RPOFILE_IMAGES.child(fileName)
        
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            if let error = error {
                print("Failed to upload the image to Storage", error.localizedDescription)
                return
            }
            storageRef.downloadURL { (url, error) in
                if let error = error {
                    print("Failed to generate download URL", error.localizedDescription)
                }
                
                guard let profileImageUrl = url?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let error = error {
                        print("Failed to register new user", error.localizedDescription)
                        return
                    }
                    
                    guard let userId = result?.user.uid else { return }
                    
                    let userInfo = ["email": email, "password": password,
                                    "fullName": fullName, "userName": userName,
                                    "profileImageURL": profileImageUrl]
                    
                    REF_USERS.child(userId).updateChildValues(userInfo, withCompletionBlock: completion)
                }
            }
        }
    }
}
