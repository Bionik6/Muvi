// swift-tools-version: 5.6
import PackageDescription

let package = Package(
  name: "DesignSystem",
  platforms: [.iOS(.v15)],
  products: [
    .library(name: "DesignSystem", targets: ["DesignSystem"]),
  ],
  dependencies: [
    .package(path: "Core")
  ],
  targets: [
    .target(name: "DesignSystem", dependencies: ["Core"]),
    .testTarget(name: "DesignSystemTests", dependencies: ["DesignSystem"]),
  ]
)
