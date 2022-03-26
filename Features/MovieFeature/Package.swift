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
    .package(path: "Networking"),
    .package(path: "DesignSystem"),
    .package(path: "MediaFeature")
  ],
  targets: [
    .target(name: "MovieFeature", dependencies: ["Core", "Networking", "DesignSystem", "MediaFeature"]),
    .testTarget(name: "MovieFeatureTests", dependencies: ["MovieFeature"]),
  ]
)
