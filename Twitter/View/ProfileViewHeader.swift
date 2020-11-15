//
//  ProfileViewHeader.swift
//  Twitter
//
//  Created by Eugene Yehanovskiy on 11/5/20.
//

import UIKit
import SnapKit

class ProfileViewHeader: UICollectionReusableView {
    
    static let headerId = String(describing: self)
    
    private let filterView = ProfileFilterView()
    
    private lazy var topHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainBlue
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(42)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(30)
        }
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "baseline_arrow_back_white_24dp").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        return button
    }()
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .gray
        iv.layer.cornerRadius = 100 / 2
        iv.clipsToBounds = true
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 4
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private lazy var editProfileImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Follow", for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.mainBlue.cgColor
        button.setTitleColor(.mainBlue, for: .normal)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(handleEditButton), for: .touchUpInside)
        return button
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Eddie Brock"
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.text = "@venom"
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 3
        label.text = "This is a user bio that will span more then one line for test purposes"
        return label
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .mainBlue
        return view
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        filterView.delegate = self
        setupView()
    }
    
    // MARK: - Selector
    @objc fileprivate func handleBackButton() {
        print("Back button pressed")
    }
    
    @objc fileprivate func handleEditButton() {
        print("Edit profile button pressed")
    }
    
    
    
    // MARK: - Helpers
    fileprivate func setupView() {
        let stackView = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel, bioLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 2
        
        addSubview(topHeaderView)
        addSubview(profileImageView)
        addSubview(editProfileImageButton)
        addSubview(stackView)
        addSubview(filterView)
        
        topHeaderView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(100)
            make.top.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints { (make) in
            make.top.equalTo(topHeaderView.snp.bottom).offset(-24)
            make.leading.equalToSuperview().offset(8)
            make.size.equalTo(100)
        }
        
        editProfileImageButton.snp.makeConstraints { (make) in
            make.top.equalTo(topHeaderView.snp.bottom).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(80)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        filterView.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        addSubview(bottomView)
        bottomView.snp.makeConstraints { (make) in
            make.leading.bottom.equalToSuperview()
            make.height.equalTo(2)
            make.width.equalTo(self.frame.width / 3)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - ProfileFilterViewDelegate

extension ProfileViewHeader: ProfileFilterViewDelegate {
    func filterViewAnimate(_ view: ProfileFilterView, didSelect indexPath: IndexPath) {
        guard let cell = view.collectionView.cellForItem(at: indexPath) as? ProfileFilterViewCell else { return }
        
        let xPosition = cell.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.bottomView.frame.origin.x = xPosition
        }
    }
    
    
}
