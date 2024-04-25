//
//  ViewModel.swift
//  TVMOVIE
//
//  Created by Yong Jun Cha on 4/25/24.
//

import Foundation
import RxSwift

class ViewModel {
    let disposebag = DisposeBag()
    private let tvNetwork: TVNetwork
    private let movieNetwork: MovieNetwork
    
    init() {
        let provider = NetworkProvider(endpoint: "")
        
        self.tvNetwork = provider.makeTVNetwork()
        self.movieNetwork = provider.makeMovieNetwork()
    }
    struct Input {
        let tvTrigger: Observable<Void>
        let movieTrigger: Observable<Void>
    }
    
    struct Output {
        let tvList: Observable<[TV]>
//        let movieList: Observable<MovieResult>
    }
    
    func transform(input: Input) -> Output {
        // trigger -> 네트워크 -> Observable<T> -> VC 전달 -> VC에서 구독
        
        // tvTrigger -> Observable<Void> -> 우리가 필요한 것은 Observable<[TV]>
//        input.tvTrigger.bind { _ in
//            print("Trigger")
//        }.disposed(by: disposebag)
        
        let tvList = input.tvTrigger.flatMapLatest { [unowned self] _ -> Observable<[TV]> in
//            Observable<TVListModel> -> Observable<[TV]>
            return self.tvNetwork.getTopRatedList().map { $0.results }
            
        }
        
        input.movieTrigger.bind { _ in
            print("Movie Trigger")
        }.disposed(by: disposebag)
        
        return Output(tvList: tvList)
    }
}
