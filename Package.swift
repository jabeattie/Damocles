// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Damocles",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "Damocles", targets: ["Damocles"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "Damocles", dependencies: []),
        .testTarget(name: "DamoclesTests", dependencies: ["Damocles"]),
    ]
)
