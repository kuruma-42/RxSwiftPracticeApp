//
//  ReviewViewController.swift
//  TVMOVIE
//
//  Created by Yong Jun Cha on 5/2/24.
//

import UIKit
import RxSwift
import SnapKit

fileprivate enum Section {
    case list
}

fileprivate enum Item: Hashable {
    case header(ReviewHeader)
    case content(String)
}

fileprivate struct ReviewHeader: Hashable {
    let id: String
    let name: String
    let url: String
}

class ReviewViewController: UIViewController {
    let viewModel: ReviewViewModel
    private let disposeBag = DisposeBag()
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    lazy var collectionView = {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ReviewHeaderCollectionViewCell.self, forCellWithReuseIdentifier: ReviewHeaderCollectionViewCell.id)
        collectionView.register(ReviewCollectionViewCell.self, forCellWithReuseIdentifier: ReviewCollectionViewCell.id)
        return collectionView
    }()
    
    init(id: Int, contentType: ContentType) {
        self.viewModel = ReviewViewModel(id: id, contentType: contentType)
        super.init(nibName: nil, bundle: nil)
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        bindView()
        setDataSource()
        // Do any additional setup after loading the view.
    }
    
    private func setUI() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.rx.itemSelected.bind { [weak self] indexPath in
            guard let item = self?.dataSource?.itemIdentifier(for: indexPath),
                  var sectionSnapshot = self?.dataSource?.snapshot(for: .list) else { return }
            
            if case .header = item {
                if sectionSnapshot.isExpanded(item) {
                    sectionSnapshot.collapse([item])
                } else {
                    sectionSnapshot.expand([item])
                }
                
                self?.dataSource?.apply(sectionSnapshot, to: .list)
            }
            //sectionSnapshot.expand(headeritem)
        }.disposed(by: disposeBag)
    }
    
    private func bindView() {
        let output = viewModel.transform(input: ReviewViewModel.Input())
        output.reviewResult.map { [weak self] result -> [ReviewModel] in
            switch result {
            case .success(let reviewList):
                return reviewList
            case .failure(let error):
                print(error)
                return []
            }
        }.bind(onNext: { [weak self] reviewList in
            guard !reviewList.isEmpty else { return }
            var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<Item>()
            reviewList.forEach { review in
                let header = ReviewHeader(id: review.id,
                                          name: review.author.name.isEmpty ? review.author.username : review.author.name,
                                          url: review.author.imageURL)
                let headerItem = Item.header(header)
                let contentItem = Item.content(review.content)
                sectionSnapshot.append([headerItem])
                sectionSnapshot.append([contentItem], to: headerItem)
            }
            self?.dataSource?.apply(sectionSnapshot, to: .list)
        }).disposed(by: disposeBag)
    }
    
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            
            switch item {
            case .header(let reviewHeader):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewHeaderCollectionViewCell.id, for: indexPath) as? ReviewHeaderCollectionViewCell
                cell?.configure(title: reviewHeader.name, url: reviewHeader.url)
                return cell
            case .content(let content):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCell.id, for: indexPath) as? ReviewCollectionViewCell
                cell?.configure(content: content)
                return cell
            }
        })
        var dataSourceSnapshot = NSDiffableDataSourceSnapshot<Section,Item>()
        dataSourceSnapshot.appendSections([.list])
        dataSource?.apply(dataSourceSnapshot)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
