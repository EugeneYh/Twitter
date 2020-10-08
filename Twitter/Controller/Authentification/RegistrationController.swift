//
//  RegistrationController.swift
//  Twitter
//
//  Created by Eugene on 06.10.2020.
//

import UIKit
import SnapKit

class RegistrationController: UIViewController {
    
    //MARK: - Properties
    
    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let emailTextField = UITextField()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let fullNameTextField = UITextField()
    
    let usernameTextField = UITextField()
    
    lazy var emailContainerView = Helpers.shared.createContainerView(withImage: #imageLiteral(resourceName: "mail"), textField: emailTextField, placeholderString: "Email")
    
    lazy var passwordContainerView = Helpers.shared.createContainerView(withImage: #imageLiteral(resourceName: "ic_lock_outline_white_2x"), textField: passwordTextField, placeholderString: "Password")
    
    lazy var fullNameContainerView = Helpers.shared.createContainerView(withImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: fullNameTextField, placeholderString: "Full Name")
    
    lazy var usernameContainerView = Helpers.shared.createContainerView(withImage: #imageLiteral(resourceName: "ic_person_outline_white_2x"), textField: usernameTextField, placeholderString: "Username")
       
    let signUpButton = Helpers.shared.createLoginSignUpButton(withTitle: "Sign Up")
    
    let attributedLoginButton: UIButton = {
        let button = Helpers.shared.createAttributedButton(withQuestion: "Already have an account?", andActionName: " Log in")
        button.addTarget(self, action: #selector(handleLoginButtonPressed), for: .touchUpInside)
        return button
    }()
        
    
        
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: - Selectors
    @objc fileprivate func handleLoginButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Heplers
    
    fileprivate func setupView() {
        view.backgroundColor = .mainBlue
        let stackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, fullNameContainerView, usernameContainerView, signUpButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        
        view.addSubview(plusPhotoButton)
        view.addSubview(stackView)
        view.addSubview(attributedLoginButton)
        
        
        plusPhotoButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(120)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(24)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.height.equalTo(350)
            make.top.equalTo(plusPhotoButton.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
        }
        
        attributedLoginButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
        }
        
        
    }
}
