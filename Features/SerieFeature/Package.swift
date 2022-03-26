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
    .package(path: "Networking"),
    .package(path: "DesignSystem"),
  ],
  targets: [
    .target(
      name: "SerieFeature",
      dependencies: ["Core", "Networking", "DesignSystem"]),
    .testTarget(name: "SerieFeatureTests", dependencies: ["SerieFeature"]),
  ]
)
