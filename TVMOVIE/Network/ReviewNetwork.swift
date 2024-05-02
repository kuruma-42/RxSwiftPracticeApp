//
//  ReviewNetwork.swift
//  TVMOVIE
//
//  Created by Yong Jun Cha on 5/2/24.
//

import Foundation
import RxSwift

final class ReviewNetwork {
    private let network: Network<ReviewListModel>
    init(network: Network<ReviewListModel>) {
        self.network = network
    }
    
    func getReviewList(id: Int, contentType: ContentType) -> Observable<ReviewListModel> {
        network.getItemList(path: "\(contentType.rawValue)/\(id)", language: "en")
    }
}
