// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyLibrary",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v15)
    ],
    products: [
        .library(name: "Networking", targets: ["Networking"]),
        .library(name: "RemoteImage", targets: ["RemoteImage"]),
    ],
    targets: [
        .target(name: "Networking"),
        .target(name: "RemoteImage"),
        .testTarget(name: "NetworkingTests", dependencies: ["Networking"]),
    ]
)
