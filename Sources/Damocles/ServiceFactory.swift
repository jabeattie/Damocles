//
//  ServiceFactory.swift
//  Damocles
//
//  Created by James Beattie on 19/09/2019.
//  Copyright © 2021 James Beattie. All rights reserved.
//

import Foundation

public protocol ServiceFactory {
    associatedtype ServiceType

    func resolve(_ resolver: Resolver) -> ServiceType
}

public extension ServiceFactory {
    func supports<T>(_ type: T.Type) -> Bool {
        return type == ServiceType.self
    }
}
