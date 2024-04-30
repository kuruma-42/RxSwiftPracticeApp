//
//  HeaderView.swift
//  TVMOVIE
//
//  Created by Yong Jun Cha on 4/30/24.
//

import Foundation
import UIKit
import SnapKit

final class HeaderView: UICollectionReusableView {
    static let id = "HeaderView"
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    private func setUI() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
    }
    
    public func configure(title: String) {
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
