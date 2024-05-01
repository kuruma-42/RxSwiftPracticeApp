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
        let movieResult: Observable<MovieResult>
    }
    
    func transform(input: Input) -> Output {
        
        let tvList = input.tvTrigger.flatMapLatest { [unowned self] _ -> Observable<[TV]> in
            // Observable<TVListModel> -> Observable<[TV]>
            return self.tvNetwork.getTopRatedList().map { $0.results }
        }
        
        let movieResult = input.movieTrigger.flatMapLatest { [unowned self] _ -> Observable<MovieResult>in
            // combine Latest
            // Observable, 1,2,3 합쳐서 하나의 Observable로 바꾸고싶다면?
            // combine latest를 넣어주면 된다.
            // 셋 중 하나라도 결과 값이 안 오면 해당 클로져는 작동하지 않는다.
            // combine에서 zip이랑 비슷한 기능 
            Observable.combineLatest(self.movieNetwork.getUpcomingList(), self.movieNetwork.getPopularList(), self.movieNetwork.getNowPlayingList()) { upcoming, popular, nowPlaying -> MovieResult in
                return MovieResult(upcoming: upcoming, popular: popular, nowPlaying: nowPlaying)
                
            }
        }
        return Output(tvList: tvList, movieResult: movieResult)
    }
}
