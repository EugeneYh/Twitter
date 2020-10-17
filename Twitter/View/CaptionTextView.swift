//
//  CaptionTextView.swift
//  Twitter
//
//  Created by Eugene Yehanovskiy on 10/16/20.
//

import UIKit
import SnapKit

class CaptionTextView: UITextView {
    // MARK: - Properties
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "What is happening?"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        backgroundColor = .white
        heightAnchor.constraint(equalToConstant: 300).isActive = true
        isScrollEnabled = false
        textColor = .darkGray
        font = UIFont.systemFont(ofSize: 16)
        
        
        addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(4)
            make.top.equalToSuperview().offset(8)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Selectors
    
    @objc private func handleTextInputChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
    
    
    
    
}
