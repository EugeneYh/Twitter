//
//  LoginController.swift
//  Twitter
//
//  Created by Eugene on 06.10.2020.
//

import UIKit
import SnapKit

class LoginController: UIViewController {
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "TwitterLogo")
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 5
        iv.clipsToBounds = true
        return iv
        
    }()
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.isSecureTextEntry = true
        return tf
    }()
    
    lazy var emailView: UIView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let view = Helpers.shared.createContainerView(withImage: image, textField: emailTextField, placeholderString: "Email")
        return view
    }()
    
    lazy var passwordView: UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Helpers.shared.createContainerView(withImage: image, textField: passwordTextField, placeholderString: "Password")
        return view
    }()
    
    let loginButton: UIButton = {
        let button = Helpers.shared.createLoginSignUpButton(withTitle: "Login")
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    let attributedButton: UIButton = {
        let button = Helpers.shared.createAttributedButton(withQuestion: "Don't have an account?", andActionName: " Sign up!")
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    
    // MARK: - Selectors
    
    @objc fileprivate func handleLogin() {
        print("Login button pressed")
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        AuthService.shared.logUserIn(email: email, password: password) { (resutl, error) in
            if let error = error {
                print("Failed to log in a user", error.localizedDescription)
                return
            }
            print("User was successfully signed in")
            
            guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else { return }
            guard let tabBarController = window.rootViewController as? MainTabBarController else { return }
            tabBarController.authenticateUserAndConfigureUI()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc fileprivate func handleSignUp() {
        let signUpController = RegistrationController()
        navigationController?.pushViewController(signUpController, animated: true)
    }
    
    // MARK: - Helpers
    
    fileprivate func setupView() {
        // styling
        view.backgroundColor = UIColor.mainBlue
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        // setup view elements
        let stackView = UIStackView(arrangedSubviews: [emailView, passwordView, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        view.addSubview(attributedButton)
        
        
        logoImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(36)
        }
        
        emailView.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        
        passwordView.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
        }
        
        attributedButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
}
