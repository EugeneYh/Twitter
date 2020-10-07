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
        iv.layer.cornerRadius = 5
        iv.clipsToBounds = true
        return iv
        
    }()
    
    let emalView: UIView = {
        let view = UIView()
        
        let iconView: UIImageView = {
            let iv = UIImageView()
            iv.image = UIImage(named: "mail")
            iv.tintColor = .white
            return iv
        }()
        
        let inputTextField: UITextField = {
            let tf = UITextField()
            tf.placeholder = "Email"
            tf.font = UIFont.systemFont(ofSize: 16)
            let attributedText = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
            tf.attributedPlaceholder = attributedText
            tf.textColor = .white
            //tf.textColor = .white
            return tf
        }()
        
        view.addSubview(iconView)
        view.addSubview(inputTextField)
        
        iconView.snp.makeConstraints { (make) in
            make.width.height.equalTo(26)
        }
        iconView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        inputTextField.snp.makeConstraints { (make) in
            make.leading.equalTo(iconView.snp.trailing).offset(8)
            make.bottom.equalToSuperview()
        }
        
        return view
    }()
    
    let passwordView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    fileprivate func setupView() {
        // styling
        view.backgroundColor = UIColor.mainBlue
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
        // setup view elements
        let stackView = UIStackView(arrangedSubviews: [emalView, passwordView])
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(logoImageView)
        view.addSubview(stackView)
        
        logoImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(36)
        }
        
        emalView.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        
        passwordView.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom).offset(36)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
    }
}
