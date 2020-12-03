//
//  ProfileHeaderView.swift
//  Twitter
//
//  Created by Eugene Yehanovskiy on 11/5/20.
//

import UIKit
import SnapKit


protocol ProfileHeaderDelegate: class {
    func handleDismissal()
}

class ProfileHeaderView: UICollectionReusableView {
    
    static let headerId = String(describing: self)
    weak var delegate: ProfileHeaderDelegate?
    
    var user: User? {
        didSet{configureFollow()}
    }
    
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
    
    private let followingLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapFollowing)))
        return label
    }()
    
    private let followersLabel: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapFollowers)))
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
        delegate?.handleDismissal()
    }
    
    @objc fileprivate func handleEditButton() {
        print("Edit profile button pressed")
    }
    
    @objc fileprivate func handleTapFollowing() {
        print("Follwing button preesed")
    }
    
    @objc fileprivate func handleTapFollowers() {
        print("Follwing button preesed")
    }
    
    
    
    // MARK: - Helpers
    fileprivate func setupView() {
        let userInfoStackView = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel, bioLabel])
        userInfoStackView.axis = .vertical
        userInfoStackView.distribution = .fillProportionally
        userInfoStackView.spacing = 2
        
        let followLabelsStackView = UIStackView(arrangedSubviews: [followingLabel, followersLabel])
        followLabelsStackView.spacing = 12
        
        
        addSubview(topHeaderView)
        addSubview(profileImageView)
        addSubview(editProfileImageButton)
        addSubview(userInfoStackView)
        addSubview(followLabelsStackView)
        addSubview(filterView)
        addSubview(bottomView)
        
        
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
            make.width.equalTo(100)
        }
        
        userInfoStackView.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        followLabelsStackView.snp.makeConstraints { (make) in
            make.top.equalTo(userInfoStackView.snp.bottom).offset(4)
            make.left.equalToSuperview().offset(12)
        }
        
        filterView.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.leading.bottom.equalToSuperview()
            make.height.equalTo(2)
            make.width.equalTo(self.frame.width / CGFloat(ProfileFilterOptions.allCases.count))
        }
    }
    
    private func configureFollow() {
        guard let user = user else {return}
        let profileHeaderModel = ProfileHeaderViewModel(user: user)
        
        profileImageView.sd_setImage(with: user.profileImageURL)
        editProfileImageButton.setTitle(profileHeaderModel.actionButtonTitle, for: .normal)
        followingLabel.attributedText = profileHeaderModel.followingString
        followersLabel.attributedText = profileHeaderModel.followersString
        fullnameLabel.text = user.fullName
        usernameLabel.text = profileHeaderModel.userNameText
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
 
//MARK: - ProfileFilterViewDelegate

extension ProfileHeaderView: ProfileFilterViewDelegate {
    func filterViewAnimate(_ view: ProfileFilterView, didSelect indexPath: IndexPath) {
        guard let cell = view.collectionView.cellForItem(at: indexPath) as? ProfileFilterViewCell else { return }
        
        let xPosition = cell.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.bottomView.frame.origin.x = xPosition
        }
    }
    
    
}
