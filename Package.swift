// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "BiometricKit",     // MUST MATCH REPO NAME
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "BiometricKit",  // Library users will import BiometricKit
            targets: ["BiometricKit"]
        )
    ],
    targets: [
        .target(
            name: "BiometricKit",
            dependencies: [],
            path: "Sources/BiometricKit"
        ),
        .testTarget(
            name: "BiometricKitTests",
            dependencies: ["BiometricKit"],
            path: "Tests"
        )
    ]
)
