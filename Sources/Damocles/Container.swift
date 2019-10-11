//
//  Container.swift
//  Damocles
//
//  Created by James Beattie on 19/09/2019.
//  Copyright © 2019 James Beattie. All rights reserved.
//

import Foundation

/// Container to hold service factories that can resolve any types that have been registered
public struct Container: Resolver {

    let factories: [AnyServiceFactory]
    
    public init() {
        self.factories = []
    }

    private init(factories: [AnyServiceFactory]) {
        self.factories = factories
    }

    // MARK: Register
    /// Register any global instances of objects that you need in your application
    public func register<ServiceType>(instance: ServiceType) -> Container {
        return register { _ in instance }
    }
    
    /// Register any global instances of objects that you need in your application
    public func register<ServiceType>(_ type: ServiceType.Type, instance: ServiceType) -> Container {
        return register(type) { _ in instance }
    }

    /// Register a factory to generate a new instance of the provided class on each invocation
    /// - Parameter factory: A closure that has access to all previously registered types that returns the generic ServiceType
    public func register<ServiceType>(_ factory: @escaping (Resolver) -> ServiceType) -> Container {
        guard !factories.contains(where: { $0.supports(ServiceType.self) }) else { return self }

        let newFactory = BasicServiceFactory<ServiceType>(factory: { resolver in
            factory(resolver)
        })
        return .init(factories: factories + [AnyServiceFactory(newFactory)])
    }

    /// Register a factory to generate a new instance of the provided class on each invocation
    /// - Parameter factory: A closure that has access to all previously registered types that returns the generic ServiceType
    public func register<ServiceType>(_ type: ServiceType.Type, _ factory: @escaping (Resolver) -> ServiceType) -> Container {
        guard !factories.contains(where: { $0.supports(type) }) else { return self }

        let newFactory = BasicServiceFactory<ServiceType>(factory: { resolver in
            factory(resolver)
        })
        return .init(factories: factories + [AnyServiceFactory(newFactory)])
    }

    // MARK: Resolver
    /// Generic resolver that will return the type using either an instance or factory. Will crash if the type has not been registered
    public func resolve<ServiceType>() -> ServiceType {
        guard let factory = factories.first(where: { $0.supports(ServiceType.self) }) else {
            fatalError("No suitable factory found for \(ServiceType.self)")
        }
        return factory.resolve(self)
    }

    /// Returns a closure that can be call to return the generic type.
    public func factory<ServiceType>() -> () -> ServiceType {
        guard let factory = factories.first(where: { $0.supports(ServiceType.self) }) else {
            fatalError("No suitable factory found for \(ServiceType.self)")
        }

        return { factory.resolve(self) }
    }
}
