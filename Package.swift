// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DuplicateGitHubProject",
    platforms: [
        .macOS(.v10_15),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/vapor/console-kit.git", from: "4.0.0"),
        .package(name: "Apollo", url: "https://github.com/apollographql/apollo-ios.git", from: "0.42.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "DuplicateGitHubProject",
            dependencies: [
                .product(name: "ConsoleKit", package: "console-kit"),
                .product(name: "Apollo", package: "Apollo"),
            ]),
        .testTarget(
            name: "DuplicateGitHubProjectTests",
            dependencies: ["DuplicateGitHubProject"]),
    ]
)
