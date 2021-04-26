//
//  Resolver.swift
//  Damocles
//
//  Created by James Beattie on 19/09/2019.
//  Copyright © 2021 James Beattie. All rights reserved.
//

import Foundation

public protocol Resolver {
    func resolve<ServiceType>() -> ServiceType
}

extension Resolver {
    func factory<ServiceType>() -> () -> ServiceType {
        return { self.resolve() }
    }
}
