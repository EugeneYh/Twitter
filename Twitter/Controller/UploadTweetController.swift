//
//  UploadTweetController.swift
//  Twitter
//
//  Created by Eugene Yehanovskiy on 10/16/20.
//

import UIKit
import SnapKit
import SDWebImage

class UploadTweetController: UIViewController {
    
    //MARK: - Properties
    
    let user: User
    
    private lazy var uploadTweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tweet", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .mainBlue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
        return button
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .mainBlue
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 64 / 2
        return iv
    }()
    
    private let captionTextField = CaptionTextView()
    
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    // MARK: - Selectors
    @objc fileprivate func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func handleUploadTweet() {
        guard let caption = captionTextField.text else { return }
        TweetService.shared.uploadTweet(caption: caption) { (error, ref) in
            if let error = error {
                print("Failed to upload the tweet with error: \(error.localizedDescription)")
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    // MARK: - Setup UI
    
    fileprivate func setupView() {
        view.backgroundColor = .white
        setupNavigationController()
        
        let stackView = UIStackView(arrangedSubviews: [profileImageView, captionTextField])
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        view.addSubview(stackView)
        
        uploadTweetButton.snp.makeConstraints { (make) in
            make.height.equalTo(32)
            make.width.equalTo(64)
        }
        
        profileImageView.snp.makeConstraints { (make) in
            make.size.equalTo(64)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        profileImageView.sd_setImage(with: user.profileImageURL)
    }
    
    fileprivate func setupNavigationController() {
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: uploadTweetButton)
    }
}
