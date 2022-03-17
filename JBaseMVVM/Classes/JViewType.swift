//
//  JViewType.swift
//  JBaseMVVM
//
//  Created by jingxuelong on 03/16/2022.
//  Copyright (c) 2022 jingxuelong. All rights reserved.
//

import Foundation
import RxSwift

private enum MapTables{
    static let viewModels: JWeakMapTable<AnyObject, Any> = .init()
    static let bag: JWeakMapTable<AnyObject, Any> = .init()

}
public protocol ViewType: AnyObject {
    
    associatedtype ViewModel: ViewModelType
    
    var viewModel: ViewModel? {set get}
    
    var disposeBag: DisposeBag {set get}
    
    func bind(viewModel: ViewModel)
}

public extension ViewType {
    
    var viewModel: ViewModel? {
        get{MapTables.viewModels.value(forKey: self) as? ViewModel}
        set{
            MapTables.viewModels.setValue(newValue, forKey: self)
            guard let unwaValue = newValue else { return }
            bind(viewModel: unwaValue)
        }
    }
    
    var disposeBag: DisposeBag {
        get{MapTables.bag.forceCastedValue(forKey: self, default: .init())}
        set{MapTables.bag.setValue(newValue, forKey: self)}
    }

}

public extension ViewType where Self: ResponderChainRouter {
    typealias Event = ViewModel.Input
}

