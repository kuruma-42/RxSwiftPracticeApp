//
//  Network.swift
//  TVMOVIE
//
//  Created by Yong Jun Cha on 4/25/24.
//

import Foundation
import RxSwift
import RxAlamofire

class Network<T:Decodable> {
    private let endpoint: String
    private let queue: ConcurrentDispatchQueueScheduler
    
    init(endpoint: String, queue: ConcurrentDispatchQueueScheduler) {
        self.endpoint = endpoint
        self.queue = ConcurrentDispatchQueueScheduler(qos: .background)
    }
    
    func getItemList(path: String, language: String = "ko") -> Observable<T> {
        let fullPath = "\(endpoint)\(path)?api_key=\(APIKEY)&language=\(language)"
        return RxAlamofire.data(.get, fullPath)
            .observeOn(queue)
            .debug()
            .map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }
    }
}

//endpoint = "https://api.themoviedb.org/3"
