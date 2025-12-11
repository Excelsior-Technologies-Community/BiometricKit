// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "BiometricAuthenticationLayer",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "BiometricAuthenticationLayer",
            targets: ["BiometricKit"]
        )
    ],
    targets: [
        .target(
            name: "BiometricKit",
            dependencies: [],
            path: "Sources/BiometricKit",
            swiftSettings: [
                .interoperabilityMode(.C)
            ]
        ),
        .testTarget(
            name: "BiometricAuthenticationLayerTests",
            dependencies: ["BiometricKit"],
            path: "Te
