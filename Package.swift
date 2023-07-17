// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "TMFloatingButton",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "TMFloatingButton",
            targets: ["TMFloatingButton"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "TMFloatingButton",
            dependencies: [],
            path:"TMFloatingButton",
            resources: [
                .copy("Resources/buttonImages.xcassets"),
            ],
            publicHeadersPath:"Public",
            cSettings: [
                .headerSearchPath("Private")
            ]
        )
    ]
)
