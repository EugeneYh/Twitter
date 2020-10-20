//
//  TweetService.swift
//  Twitter
//
//  Created by Eugene Yehanovskiy on 10/16/20.
//

import Firebase

struct TweetService {
    static let shared = TweetService()
    
    func uploadTweet(caption: String, complition: @escaping (Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let values = ["uid": uid,
                      "timestamp": Int(NSDate().timeIntervalSince1970),
                      "likes": 0,
                      "retweets": 0, "caption": caption] as [String: AnyObject]
        
        REF_TWEETS.childByAutoId().updateChildValues(values, withCompletionBlock: complition)
    } // end uploadTweets()
    
    
    func fetchTweets(completion: @escaping([Tweet]) -> Void) {
        var tweets = [Tweet]()

        REF_TWEETS.observe(.childAdded) { (snapshot) in
            let tweetId = snapshot.key
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            guard let uid = dictionary["uid"] as? String else { return }
            
            UserService.shared.fetchUser(uid: uid) { (user) in
                let tweet = Tweet(user: user, tweetId: tweetId, dictionary: dictionary)
                tweets.append(tweet)
                completion(tweets)
            }
        }
    } // end fetchTweets()
}
