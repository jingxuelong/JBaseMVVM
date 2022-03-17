//
//  TestVM.swift
//  JBaseMVVM_Example
//
//  Created by jingxuelong on 03/16/2022.
//  Copyright (c) 2022 jingxuelong. All rights reserved.
//

import Foundation
import JBaseMVVM
import RxRelay


class TestVM: ViewModelType {
    
    enum Input: ResponderChainEvent{
        case left(va: Int)
        case right(va: Int)
    }
    struct Output: CreatAble{
        var backEvent: PublishRelay<Int> = .init()
        init() {}
    }
    func mutate(input: Input, output: Output) {
        switch input {
        case .left(let int):
            output.backEvent.accept(int)
        case .right(let int):
            output.backEvent.accept(int)
        }
    }
}
