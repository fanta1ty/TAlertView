// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TAlertView",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "TAlertView",
            targets: ["TAlertView"]),
    ],
    targets: [
        .target(
            name: "TAlertView",
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "TAlertViewTests",
            dependencies: ["TAlertView"]),
    ],
    swiftLanguageVersions: [.v5]
)
