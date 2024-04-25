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
    struct Input {
        let tvTrigger: Observable<Void>
        let movieTrigger: Observable<Void>
    }
    
    struct Output {
        let tvList: Observable<[TV]>
//        let movieList: Observable<MovieResult>
    }
    
    func transform(input: Input) -> Output {
        input.tvTrigger.bind { _ in
            print("Trigger")
        }.disposed(by: disposebag)
        return Output(tvList: Observable<[TV]>.just([]))
    }
}
