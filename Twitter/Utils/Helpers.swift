//
//  Helpers.swift
//  Twitter
//
//  Created by Eugene Yehanovskiy on 10/7/20.
//

import UIKit

class Helpers {
    
    static let shared = Helpers()
    
    func createContainerView(withImage image: UIImage, textField: UITextField, placeholderString: String) -> UIView {
        let view = UIView()
        let iconView = UIImageView()
        iconView.image = image
        iconView.tintColor = .white

        let inputTextField = textField
        inputTextField.placeholder = placeholderString
        inputTextField.font = UIFont.systemFont(ofSize: 16)
        let attributedText = NSAttributedString(string: placeholderString, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        inputTextField.attributedPlaceholder = attributedText
        inputTextField.textColor = .white
        
        let deviderView: UIView = {
            let view = UIView()
            view.backgroundColor = .white
            return view
        }()
        
        view.addSubview(iconView)
        view.addSubview(inputTextField)
        view.addSubview(deviderView)

        iconView.snp.makeConstraints { (make) in
            make.width.height.equalTo(26)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-4)
        }
        
        inputTextField.snp.makeConstraints { (make) in
            make.leading.equalTo(iconView.snp.trailing).offset(8)
            make.bottom.equalToSuperview().offset(-4)
        }
        
        deviderView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.leading.equalTo(iconView.snp.leading)
            make.trailing.bottom.equalToSuperview()
        }
        
        return view
    }
    
    func createLoginSignUpButton(withTitle title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.mainBlue, for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .white
        return button
    }
    
    func createAttributedButton(withQuestion question: String, andActionName actionName: String) -> UIButton {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: question, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: actionName, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }
}
