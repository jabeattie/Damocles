//
//  BasicServiceFactory.swift
//  DependencyInjection
//
//  Created by James Beattie on 19/09/2019.
//  Copyright © 2021 James Beattie. All rights reserved.
//

import Foundation

struct BasicServiceFactory<ServiceType>: ServiceFactory {
    private let factory: (Resolver) -> ServiceType

    init(factory: @escaping (Resolver) -> ServiceType) {
        self.factory = factory
    }

    func resolve(_ resolver: Resolver) -> ServiceType {
        return factory(resolver)
    }
}
