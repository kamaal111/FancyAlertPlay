// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PopperUp",
    products: [
        .library(
            name: "PopperUp",
            targets: ["PopperUp"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "PopperUp",
            dependencies: []),
        .testTarget(
            name: "PopperUpTests",
            dependencies: ["PopperUp"]),
    ]
)
