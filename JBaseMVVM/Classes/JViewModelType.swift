//
//  JViewModelType.swift
//  JBaseMVVM
//
//  Created by jingxuelong on 03/16/2022.
//  Copyright (c) 2022 jingxuelong. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

private enum MapTables {
    static let input = JWeakMapTable<AnyObject, Any>()
    static let output = JWeakMapTable<AnyObject, Any>()
    static let bag = JWeakMapTable<AnyObject, Any>()

}

public protocol CreatAble {
    init()
}

public protocol ViewModelType: AnyObject {
    associatedtype Input: ResponderChainEvent
    associatedtype Output: CreatAble
    func mutate(input: Input, output: Output)
}

public extension ViewModelType{
    
    var input: ActionSubject<Input>{MapTables.input.forceCastedValue(forKey: self, default: .init())}
    
    var disposeBag: DisposeBag {MapTables.bag.forceCastedValue(forKey: self, default: .init())}

    var output: Output{
        get {
            if let out = MapTables.output.value(forKey: self) as? Output {
                return out
            }else{
                let newOut = Output()
                MapTables.output.setValue(newOut, forKey: self)
                input
                    .subscribe(onNext: {[weak self] val in
                        guard let `self` = self else { return }
                        self.mutate(input: val, output: self.output)
                    })
                    .disposed(by: disposeBag)
                return newOut
            }
        }
    }
}
