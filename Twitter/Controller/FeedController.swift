//
//  FeedController.swift
//  Twitter
//
//  Created by Eugene on 02.10.2020.
//

import UIKit
import SnapKit
import SDWebImage

class FeedController: UICollectionViewController {
    
    // Mark: - Properties
    
    var user: User? {
        didSet{
            if let user = user {
                guard let url = user.profileImageURL else {return}
                profileImageView.sd_setImage(with: url)
            }
        }
    }
    
    private var tweets = [Tweet]()
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 32 / 2
        iv.layer.masksToBounds = true
        return iv
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchTweets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barStyle = .default
    }
    
    // MARK: - API
    
    private func fetchTweets() {
        TweetService.shared.fetchTweets { (tweets) in
            self.tweets = tweets
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Selectors
    
    
    
    // MARK: - Helpers
    
    fileprivate func setupView() {
        collectionView.backgroundColor = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.cellID)
    
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { (make) in
            make.size.equalTo(44)
        }
        navigationItem.titleView = imageView
        
        profileImageView.snp.makeConstraints { (make) in
            make.size.equalTo(32)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
}

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.cellID, for: indexPath) as! FeedCell
        cell.delegate = self
        cell.tweet = tweets[indexPath.item]
        return cell
    }
}

extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 120)
    }
}

extension FeedController: FeedCellDelegate {
    func handleProfileImageTapped(_ cell: FeedCell) {
        guard let user = cell.tweet?.user else {return}
        let profileVC = ProfileViewController(user: user)
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    
}
