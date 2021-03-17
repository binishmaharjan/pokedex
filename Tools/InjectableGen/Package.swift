// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "InjectableGen",
    platforms: [
        .macOS(.v10_11)
    ],
    products: [
        .executable(
            name: "InjectableGenerator",
            targets: ["InjectableGenerator"]),
        .library(
            name: "InjectableGen",
            targets: ["InjectableGen"]),
    ],
    dependencies: [
        .package(url: "https://github.com/jpsim/SourceKitten.git", from: "0.29.0"),
        .package(url: "https://github.com/stencilproject/Stencil.git", from: "0.13.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.1.0"),
    ],
    targets: [
        .target(
            name: "InjectableGenerator",
            dependencies: ["InjectableGen"]),
        .target(
            name: "InjectableGen",
            dependencies: ["SourceKittenFramework", "Stencil", "ArgumentParser"]),
        .testTarget(
            name: "InjectableGenTests",
            dependencies: ["InjectableGen"]),
    ],
    swiftLanguageVersions: [.v5]
)
