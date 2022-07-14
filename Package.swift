// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "StyleLib",
    platforms: [
        .macOS(.v11),
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "StyleLib",
            targets: ["StyleLib"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "StyleLib",
            dependencies: []
        ),
        .testTarget(
            name: "StyleLibTests",
            dependencies: ["StyleLib"]),
    ]
)
