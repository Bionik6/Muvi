// swift-tools-version: 5.7
import PackageDescription

let package = Package(
  name: "Features",
  platforms: [.iOS(.v16)],
  products: [
    .library(name: "MediaFeature", targets: ["MediaFeature"]),
    .library(name: "MovieFeature", targets: ["MovieFeature"]),
    .library(name: "SerieFeature", targets: ["SerieFeature"]),
  ],
  dependencies: [
    .package(path: "Core"),
    .package(path: "Shared"),
    // .package(url: "https://github.com/evgenyneu/keychain-swift", from: "20.0.0"),
    .package(url: "https://github.com/SvenTiigi/YouTubePlayerKit.git", from: "1.1.9"),
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
        .product(name: "MediaDetails", package: "Shared"),
        "YouTubePlayerKit",
      ]
    ),
    .target(
      name: "MovieFeature",
      dependencies: [
        .product(name: "Domain", package: "Core"),
        .product(name: "Storage", package: "Core"),
        .product(name: "Networking", package: "Core"),
        .product(name: "Navigation", package: "Shared"),
        .product(name: "MediaDetails", package: "Shared"),
        .product(name: "DesignSystem", package: "Shared"),
      ]
    ),
    .target(
      name: "SerieFeature",
      dependencies: [
        .product(name: "Domain", package: "Core"),
        .product(name: "Storage", package: "Core"),
        .product(name: "Networking", package: "Core"),
        .product(name: "Navigation", package: "Shared"),
        .product(name: "MediaDetails", package: "Shared"),
        .product(name: "DesignSystem", package: "Shared"),
      ]
    ),
  ]
)
