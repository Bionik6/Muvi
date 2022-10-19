// swift-tools-version: 5.6
import PackageDescription

let package = Package(
  name: "SerieFeature",
  platforms: [.iOS(.v15)],
  products: [
    .library(name: "SerieFeature", targets: ["SerieFeature"]),
  ],
  dependencies: [
    .package(path: "Core"),
    .package(path: "Shared"),
    .package(path: "Networking"),
    .package(path: "MediaFeature")
  ],
  targets: [
    .target(
      name: "SerieFeature",
      dependencies: [
        "Core",
        "Networking",
        "MediaFeature",
        .product(name: "Navigation", package: "Shared"),
        .product(name: "DesignSystem", package: "Shared"),
      ]),
    .testTarget(name: "SerieFeatureTests", dependencies: ["SerieFeature"]),
  ]
)
