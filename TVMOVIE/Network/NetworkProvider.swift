//
//  NetworkProvider.swift
//  TVMOVIE
//
//  Created by Yong Jun Cha on 4/25/24.
//

import Foundation
import RxSwift
// 어떤 네트워크를 생성할 수 있는 클래스

final class NetworkProvider {
    private let endpoint: String
    
    init(endpoint: String) {
        self.endpoint = endpoint
    }
    
    func makeTVNetwork() -> TVNetwork {
        let network = Network<TVListModel>(endpoint: endpoint,
                                           queue: ConcurrentDispatchQueueScheduler(qos: .background))
        return TVNetwork(network: network)
    }
    
    func makeMovieNetwork() -> MovieNetwork {
        let network = Network<MovieListModel>(endpoint: endpoint,
                                              queue: ConcurrentDispatchQueueScheduler(qos: .background))
        return MovieNetwork(network: network)
    }
}
