//
//  FeedController.swift
//  Twitter
//
//  Created by Eugene on 02.10.2020.
//

import UIKit
import SnapKit
import SDWebImage

class FeedController: UIViewController {
    
    // Mark: - Properties
    
    var user: User? {
        didSet{
            if let user = user {
                guard let url = user.profileImageURL else {return}
                profileImageView.sd_setImage(with: url)
            }
        }
    }
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 32 / 2
        iv.layer.masksToBounds = true
        return iv
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    
    }
    
    // MARK: - Helpers
    
    fileprivate func setupView() {
        view.backgroundColor = .white
    
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
