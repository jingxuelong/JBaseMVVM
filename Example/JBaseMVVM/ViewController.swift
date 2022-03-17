//
//  ViewController.swift
//  JBaseMVVM
//
//  Created by jingxuelong on 03/16/2022.
//  Copyright (c) 2022 jingxuelong. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import JBaseMVVM

class ViewController: UIViewController, ViewType, ResponderChainRouter{
    
    let leftButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("-", for: .normal)
        btn.backgroundColor = .lightGray
        return btn
    }()
    
    let rightButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("+", for: .normal)
        btn.backgroundColor = .lightGray
        return btn
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel = TestVM()
        setUpUI()
    }
    
    func setUpUI() {
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        view.addSubview(label)
        leftButton.rx.tap.asObservable()
            .map{ViewModel.Input.left(va: 3)}
            .bind(to: leftButton.rx.routerEvents)
            .disposed(by: disposeBag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        leftButton.frame = .init(x: 50, y: 200, width: 100, height: 50)
        rightButton.frame = .init(x: 230, y: 200, width: 100, height: 50)
    }
    
    func bind(viewModel: TestVM) {
        Observable
            .merge(leftButton.rx.tap.asObservable(),
                   rightButton.rx.tap.asObservable())
            .map{TestVM.Input.left(va: 10)}
            .bind(to: viewModel.input)
            .disposed(by: disposeBag)
        viewModel.output.backEvent
            .subscribe(onNext: { valu in
                print(valu)
            })
            .disposed(by: disposeBag)
        events.bind(to: viewModel.input).disposed(by: disposeBag)
    }
}


