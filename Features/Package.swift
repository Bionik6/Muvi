// swift-tools-version: 5.7
import PackageDescription

let package = Package(
  name: "Features",
  platforms: [.iOS(.v15)],
  products: [
    .library(name: "MediaFeature", targets: ["MediaFeature"]),
    .library(name: "MovieFeature", targets: ["MovieFeature"]),
    .library(name: "SerieFeature", targets: ["SerieFeature"]),
  ],
  dependencies: [
    .package(path: "Core"),
    .package(path: "Shared"),
    .package(url: "https://github.com/SvenTiigi/YouTubePlayerKit.git", from: "1.1.9")
  ],
  targets: [
    .target(
      name: "MediaFeature",
      dependencies: [
        .product(name: "Domain", package: "Core"),
        .product(name: "Storage", package: "Core"),
        .product(name: "Networking", package: "Core"),
        .product(name: "Navigation", package: "Shared"),
        .product(name: "DesignSystem", package: "Shared"),
        "YouTubePlayerKit"
      ]
    ),
    .target(
      name: "MovieFeature",
      dependencies: [
        .product(name: "Domain", package: "Core"),
        .product(name: "Storage", package: "Core"),
        .product(name: "Networking", package: "Core"),
        .product(name: "Navigation", package: "Shared"),
        .product(name: "DesignSystem", package: "Shared"),
        "MediaFeature"
      ]
    ),
    .target(
      name: "SerieFeature",
      dependencies: [
        .product(name: "Domain", package: "Core"),
        .product(name: "Storage", package: "Core"),
        .product(name: "Networking", package: "Core"),
        .product(name: "Navigation", package: "Shared"),
        .product(name: "DesignSystem", package: "Shared"),
        "MediaFeature"
      ]
    ),
  ]
)
