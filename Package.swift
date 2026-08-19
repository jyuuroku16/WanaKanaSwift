// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WanaKanaSwift",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "WanaKanaSwift",
            targets: ["WanaKanaSwift"]),
    ],
    targets: [
        .target(
            name: "WanaKanaSwift"),
        .testTarget(
            name: "WanaKanaSwiftTests",
            dependencies: ["WanaKanaSwift"]
        ),
    ]
)
