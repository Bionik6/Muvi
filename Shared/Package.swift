// swift-tools-version: 5.7
import PackageDescription

let package = Package(
  name: "Shared",
  platforms: [.iOS(.v15)],
  products: [
    .library(name: "Navigation", targets: ["Navigation"]),
    .library(name: "DesignSystem", targets: ["DesignSystem"]),
  ],
  dependencies: [
    .package(path: "Core"),
  ],
  targets: [
    .target(name: "Navigation", dependencies: []),
    .target(name: "DesignSystem", dependencies: [.product(name: "Domain", package: "Core")])
  ]
)
