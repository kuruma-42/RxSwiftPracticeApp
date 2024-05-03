//
//  ReviewViewController.swift
//  TVMOVIE
//
//  Created by Yong Jun Cha on 5/2/24.
//

import UIKit
import RxSwift

class ReviewViewController: UIViewController {
    let viewModel: ReviewViewModel
    private let disposeBag = DisposeBag()
    init(id: Int, contentType: ContentType) {
        self.viewModel = ReviewViewModel(id: id, contentType: contentType)
        super.init(nibName: nil, bundle: nil)
            
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        bindView()
        // Do any additional setup after loading the view.
    }
    
    private func bindView() {
        let output = viewModel.transform(input: ReviewViewModel.Input())
        output.reviewResult.bind { result in
            switch result {
            case .success(let reviewList):
                print("review ::: \(reviewList)")
            case .failure(let error):
                print(error)
            }
        }.disposed(by: disposeBag)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
