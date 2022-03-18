//
//  JResponderChain.swift
//  JBaseMVVM
//
//  Created by jingxuelong on 03/10/2022.
//  Copyright (c) 2022 jingxuelong. All rights reserved.
//

import Foundation
import class UIKit.UIResponder
import class UIKit.UIViewController
import RxSwift
import RxCocoa

private var rcp_events_key: UInt8 = 0

private enum MapTables{
    static let event: JWeakMapTable<AnyObject, Any> = .init()
}

public typealias ResponderChainRouter = ResponderChainWrapper & ResponderChainStorage

public protocol ResponderChainEvent {}


public protocol ResponderChainWrapper {
    associatedtype Event: ResponderChainEvent
    var events: Observable<Event> { get }
}


public protocol ResponderChainEmiter {}

public extension ResponderChainEmiter where Self: UIResponder {
    func emitRouterEvent(_ event: ResponderChainEvent) {
        var responder = next

        while responder != nil {
            if responder!.isKind(of: UIViewController.self), let rcp = responder as? ResponderChainStorage {
                rcp._events.onNext(event)
                return
            }

            responder = responder?.next
        }
    }
}

extension UIResponder: ResponderChainEmiter {}


public protocol ResponderChainStorage: AnyObject{}

public extension ResponderChainStorage {
    var _events: PublishSubject<ResponderChainEvent> {
        MapTables.event.forceCastedValue(forKey: self, default: .init())
    }
}

public extension ResponderChainWrapper where Self: ResponderChainStorage {
    var events: Observable<Event> {
        return _events.compactMap { $0 as? Event }.share()
    }
}

///Rx扩展
public extension Reactive where Base: UIResponder {
    var routerEvents: Binder<ResponderChainEvent> {
        return Binder(self.base) { responder, event in
            responder.emitRouterEvent(event)
        }
    }
}
