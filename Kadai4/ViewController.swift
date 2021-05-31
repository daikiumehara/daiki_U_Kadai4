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
    
    private var labelValue: Int = 0 {
        didSet {
            self.label.text = String(describing: self.labelValue)
        }
    }
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rxSetup()
    }
    private func rxSetup() {
        didTapIncrementButton()
        didTapClearButton()
    }
    
    private func didTapIncrementButton() {
        incrementButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.labelValue += 1
            })
            .disposed(by: disposeBag)
    }
    private func didTapClearButton() {
        clearButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.labelValue = 0
            })
            .disposed(by: disposeBag)
    }
}
