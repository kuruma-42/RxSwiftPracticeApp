//
//  NormalCollectionViewCell.swift
//  TVMOVIE
//
//  Created by Yong Jun Cha on 4/27/24.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class NormalCollectionViewCell: UICollectionViewCell {
    
    static let id = "NormalCollectionViewCell"
    
    let image: UIImageView = {
        let image = UIImageView()
        // 하부 레이어가 바운드를 넘어가면 그리지 않는다.
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    let reviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    
    private func setUI() {
        addSubview(image)
        addSubview(titleLabel)
        addSubview(reviewLabel)
        addSubview(descLabel)
        
        image.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(8)
            make.top.equalTo(image.snp.bottom).offset(8)
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(8)
        }
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(reviewLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(8)
        }
    }
    
    public func configuration(title: String, review: String, desc: String, imageURL: String) {
        image.kf.setImage(with: URL(string: imageURL))
        titleLabel.text = title
        reviewLabel.text = review
        descLabel.text = desc
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
