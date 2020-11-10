//
//  FeedCell.swift
//  Twitter
//
//  Created by Eugene Yehanovskiy on 10/18/20.
//

import UIKit
import SnapKit

protocol FeedCellDelegate: class {
    func handleProfileImageTapped(_ cell: FeedCell)
}

class FeedCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let cellID = String(describing: self)
    
    var tweet: Tweet? {
        didSet{
            configureTweet()
        }
    }
    
    weak var delegate: FeedCellDelegate?
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .mainBlue
        iv.layer.cornerRadius = 64 / 2
        iv.layer.masksToBounds = true
        
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped)))
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let userInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Eddie Brock @venom - 0s"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        return label
    }()
    
    let captionLabel: UILabel = {
        let label = UILabel()
        label.text = "Some new tweet with some random text"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()
    
    lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var retweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "retweet"), for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "like"), for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "share"), for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        return button
    }()
    
    let deviderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        return view
    }()
    
    
    
    // MARK: Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc private func handleProfileImageTapped() {
        delegate?.handleProfileImageTapped(self)
    }
    
    @objc private func handleCommentTapped() {
        print("Comment tapped")
    }
    
    @objc private func handleRetweetTapped() {
        print("Comment tapped")
    }
    
    @objc private func handleLikeTapped() {
        print("Comment tapped")
    }
    
    @objc private func handleShareTapped() {
        print("Comment tapped")
    }
    
    // MARK: - Helpers
    
    fileprivate func setupView() {
        let labelsStackView = UIStackView(arrangedSubviews: [userInfoLabel, captionLabel])
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 8
        
        let feedBottomButtonsStackView = UIStackView(arrangedSubviews: [commentButton, retweetButton, likeButton, shareButton])
        feedBottomButtonsStackView.axis = .horizontal
        feedBottomButtonsStackView.distribution = .equalSpacing
        
        addSubview(profileImageView)
        addSubview(labelsStackView)
        addSubview(feedBottomButtonsStackView)
        addSubview(deviderView)
        
        profileImageView.snp.makeConstraints { (make) in
            make.size.equalTo(64)
            make.leading.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(12)
        }
        
        labelsStackView.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView.snp.top)
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        commentButton.snp.makeConstraints { (make) in
            make.size.equalTo(20)
        }
        
        retweetButton.snp.makeConstraints { (make) in
            make.size.equalTo(20)
        }
        
        likeButton.snp.makeConstraints { (make) in
            make.size.equalTo(20)
        }
        
        shareButton.snp.makeConstraints { (make) in
            make.size.equalTo(20)
        }
        
        feedBottomButtonsStackView.snp.makeConstraints { (make) in
            make.leading.equalTo(profileImageView.snp.trailing)
            make.bottom.equalToSuperview().offset(-8)
            make.trailing.equalToSuperview().offset(-56)
        }
        
        deviderView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    fileprivate func configureTweet() {
        guard let tweet = tweet else {return}
        let tweetViewModel = TweetViewModel(tweet: tweet)
        
        self.userInfoLabel.attributedText = tweetViewModel.userInfoLabel
        self.captionLabel.text = tweet.caption
        self.profileImageView.sd_setImage(with: tweetViewModel.profileImageURL)
    }
    
}
