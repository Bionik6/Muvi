// swift-tools-version: 5.6
import PackageDescription

let package = Package(
  name: "MovieFeature",
  platforms: [.iOS(.v15)],
  products: [
    .library(name: "MovieFeature", targets: ["MovieFeature"]),
  ],
  dependencies: [
    .package(path: "Core"),
    .package(path: "Shared"),
    .package(path: "Networking"),
    .package(path: "MediaFeature"),
  ],
  targets: [
    .target(
      name: "MovieFeature",
      dependencies: [
        "Core",
        "Networking",
        "MediaFeature",
        .product(name: "Navigation", package: "Shared"),
        .product(name: "DesignSystem", package: "Shared"),
      ]),
    .testTarget(
      name: "MovieFeatureTests",
      dependencies: ["MovieFeature"]
    ),
  ]
)
