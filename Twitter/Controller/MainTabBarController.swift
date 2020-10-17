//
//  MainTabBarController.swift
//  Twitter
//
//  Created by Eugene on 02.10.2020.
//

import UIKit
import SnapKit
import Firebase

class MainTabBarController: UITabBarController {
    
    // MARK: - Properties
    
    var user: User? {
        didSet {
            guard let navigationController = viewControllers?.first as? UINavigationController else { return }
            guard let feedController = navigationController.viewControllers.first as? FeedController else { return }
            feedController.user = self.user
        }
    }
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.mainBlue
        button.layer.cornerRadius = 50 / 2
        button.addTarget(self, action: #selector(handleActionButtonClick), for: .touchUpInside)
        return button
    }()
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBlue
        
        //singOutUser()
        authenticateUserAndConfigureUI()
    }
    
    // MARK: - API
    
    func fetchUser() {
        UserService.shared.fetchUser { (user) in
            self.user = user
        }
    }
    
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            print("DEBUG: User is NOT signed in")
            DispatchQueue.main.async {
                let navController = UINavigationController(rootViewController: LoginController())
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
            }
        } else {
            print("DEBUG: User is signed in")
            setupView()
            setupViewControllers()
            fetchUser()
        }
    }
    
    func singOutUser() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("DEBUG: Filed to sign out", error.localizedDescription)
        }
        
    }
    
    
    // MARK: - Selectors
    
    @objc fileprivate func handleActionButtonClick() {
        guard let user = user else { return }
        let uploadTweetNavController = UINavigationController(rootViewController: UploadTweetController(user: user))
        uploadTweetNavController.modalPresentationStyle = .fullScreen
        present(uploadTweetNavController, animated: true, completion: nil)
    }
    
    
    
    // MARK: - Helpers
    
    fileprivate func setupView() {
        view.backgroundColor = .white
        view.addSubview(actionButton)
        actionButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-64)
        }
    }
    
    fileprivate func setupViewControllers() {
        
        let feedVC = createNavigationController(rootViewController: FeedController(), imageName: "home_unselected", title: nil)
        let exploreVC = createNavigationController(rootViewController: ExploreController(), imageName: "search_unselected", title: "Explore")
        let notificationsVC = createNavigationController(rootViewController: NotificationsController(), imageName: "like_unselected", title: "Notifications")
        let conversationsVC = createNavigationController(rootViewController: ConversationsController(), imageName: "ic_mail_outline_white_2x-1", title: "Messages")
        
        viewControllers = [feedVC, exploreVC, notificationsVC, conversationsVC]
        
    }
    
    fileprivate func createNavigationController(rootViewController: UIViewController, imageName: String, title: String?) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.image = UIImage(named: imageName)
        
        if let title = title {
            rootViewController.navigationItem.title = title
        }
        
        navigationController.navigationBar.barTintColor = .white
        
        return navigationController
    }
}
