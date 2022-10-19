// swift-tools-version: 5.6
import PackageDescription

let package = Package(
  name: "MediaFeature",
  platforms: [.iOS(.v15)],
  products: [
    .library(name: "MediaFeature", targets: ["MediaFeature"]),
  ],
  dependencies: [
    .package(path: "Core"),
    .package(path: "Networking"),
    .package(path: "Shared"),
    .package(path: "Storage"),
    .package(url: "https://github.com/SvenTiigi/YouTubePlayerKit.git", from: "1.1.9")
  ],
  targets: [
    .target(
      name: "MediaFeature",
      dependencies: [
      "Core",
      "Networking",
      "Storage",
      "YouTubePlayerKit",
      .product(name: "Navigation", package: "Shared"),
      .product(name: "DesignSystem", package: "Shared"),
      ]),
    .testTarget(name: "MediaFeatureTests",dependencies: ["MediaFeature"]),
  ]
)
