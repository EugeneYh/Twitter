//
//  MainTabBarController.swift
//  Twitter
//
//  Created by Eugene on 02.10.2020.
//

import UIKit

class MainTabBarController: UITabBarController {
    // MARK: - Properties
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViewControllers()
    }
    
    // MARK: - Helpers
    
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
