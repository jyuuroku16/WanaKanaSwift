// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WanaKanaSwift",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "WanaKanaSwift",
            targets: ["WanaKanaSwift"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "WanaKanaSwift"),
        .testTarget(
            name: "WanaKanaSwiftTests",
            dependencies: ["WanaKanaSwift"]
        ),
    ]
)
