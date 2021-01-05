// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NauMai",
    defaultLocalization: "en",
    platforms: [
        .macOS(.v11),
        .iOS(.v14),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "NauMai",
            targets: ["NauMai"]),
    ],
    dependencies: [
        .package(url: "https://github.com/nalexn/ViewInspector", from: "0.6.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "NauMai",
            dependencies: []),
        .testTarget(
            name: "NauMaiTests",
            dependencies: ["NauMai", "ViewInspector"]),
    ]
)
