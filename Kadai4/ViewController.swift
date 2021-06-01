//
//  ViewController.swift
//  Kadai4
//
//  Created by daiki umehara on 2021/05/30.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet private var incrementButton: UIButton!
    @IBOutlet private var clearButton: UIButton!
    @IBOutlet private var label: UILabel!

    private let countRelay = BehaviorRelay<Int>(value: 0)

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    private func setupBindings() {
        countRelay
            .map { String($0) }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)

        Observable
            .merge([
                clearButton.rx.tap
                    .map { _ in 0 },
                incrementButton.rx.tap
                    .withLatestFrom(countRelay)
                    .map { $0 + 1 }
            ])
            .bind(to: countRelay)
            .disposed(by: disposeBag)
    }
}
