//
//  ProfileFilterViewCell.swift
//  Twitter
//
//  Created by Eugene Yehanovskiy on 11/12/20.
//

import UIKit
import SnapKit

class ProfileFilterViewCell: UICollectionViewCell {
    //MARK: - Properties
    
    static let cellId = String(describing: self)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "Filter"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? UIColor.mainBlue : UIColor.lightGray
            titleLabel.font = isSelected ? UIFont.boldSystemFont(ofSize: 16) : UIFont.systemFont(ofSize: 14)
        }
        
    }
    
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
