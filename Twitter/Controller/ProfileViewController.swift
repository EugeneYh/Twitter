//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Eugene Yehanovskiy on 10/28/20.
//

import UIKit
import SnapKit

class ProfileViewController: UICollectionViewController {
    
    // MARK: - Instance properties
    private let user: User
    
    private var tweets = [Tweet]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.contentInsetAdjustmentBehavior = .never
        setupCollectionView()
        fetchTweets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    // MARK: - Helpers
    
    fileprivate func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(ProfileHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileHeaderView.headerId)
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: FeedCell.cellID)
    }
    
    // MARK: - API
    
    fileprivate func fetchTweets() {
        TweetService.shared.fetchTweets(for: user) { (tweets) in
            self.tweets = tweets
        }
    }
}

// MARK: - UICollectionViewDataSource

extension ProfileViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tweets.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ProfileHeaderView.headerId, for: indexPath) as! ProfileHeaderView
        header.user = user
        header.delegate = self
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCell.cellID, for: indexPath) as! FeedCell
        cell.tweet = tweets[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
}

extension ProfileViewController: ProfileHeaderDelegate {
    func handleDismissal() {
        navigationController?.popViewController(animated: true)
    }
    
    
}
