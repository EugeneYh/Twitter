//
//  FeedController.swift
//  Twitter
//
//  Created by Eugene on 02.10.2020.
//

import UIKit

class FeedController: UIViewController {
    
    // Mark: - Properties
    
    
    
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
        navigationItem.titleView = imageView
    }
}
