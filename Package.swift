// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NormanDSKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "NormanDSKit",
            targets: ["NormanDSKit"]
        )
    ],
    dependencies: [
        // Lottie (Airbnb)
        .package(
            url: "https://github.com/airbnb/lottie-spm.git",
            from: "4.5.2"
        ),
        
        // LoremSwiftum (faker generator)
        .package(
            url: "https://github.com/lukaskubanek/LoremSwiftum.git",
            from: "2.3.0"
        ),
    ],
    targets: [
        .target(
            name: "NormanDSKit",
            dependencies: [
                .product(name: "Lottie", package: "lottie-spm"),
                .product(name: "LoremSwiftum", package: "loremswiftum")
            ],
            path: "Sources/NormanDSKit",
            resources: [
                // Añadir assets si los tienes
                // .process("Resources")
            ]
        ),
        .testTarget(
            name: "DNormanDSKitTests",
            dependencies: ["NormanDSKit"],
            path: "Tests/NormanDSKitTests"
        )
    ]
)
