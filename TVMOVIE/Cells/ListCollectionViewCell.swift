//
//  ListCollectionViewCell.swift
//  TVMOVIE
//
//  Created by Yong Jun Cha on 4/30/24.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

final class ListCollectionViewCell: UICollectionViewCell {
    static let id: String = "ListCollectionViewCell"
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    private func setUI() {
        addSubview(image)
        addSubview(titleLabel)
        addSubview(releaseDateLabel)

        image.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(120)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(image.snp.trailing).offset(8)
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(image.snp.trailing).offset(8)
        }
    }
    
    public func configure(title: String, releaseDate: String, URLImage: String) {
        image.kf.setImage(with: URL(string: URLImage))
        titleLabel.text = title
        releaseDateLabel.text = releaseDate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
