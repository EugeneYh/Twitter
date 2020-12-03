//
//  ProfileFilterView.swift
//  Twitter
//
//  Created by Eugene Yehanovskiy on 11/12/20.
//

import UIKit
import SnapKit

protocol ProfileFilterViewDelegate: class {
    func  filterViewAnimate (_ view: ProfileFilterView, didSelect indexPath: IndexPath)
}

class ProfileFilterView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: ProfileFilterViewDelegate?
    private let cellLineSpacing: CGFloat = 2
    private let numberOfCells = CGFloat(ProfileFilterOptions.allCases.count)
    
    lazy var collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.register(ProfileFilterViewCell.self, forCellWithReuseIdentifier: ProfileFilterViewCell.cellId)
        return  cv
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.trailing.bottom.leading.equalToSuperview()
        }
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileFilterView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProfileFilterOptions.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileFilterViewCell.cellId, for: indexPath) as! ProfileFilterViewCell
        let option = ProfileFilterOptions(rawValue: indexPath.item)
        cell.option = option
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.filterViewAnimate(self, didSelect: indexPath)
    }
    
}

extension ProfileFilterView: UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.collectionView.frame.width
        return .init(width: (width / numberOfCells) - (numberOfCells * cellLineSpacing), height: frame.height)
    }
}
