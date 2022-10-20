// swift-tools-version: 5.7
import PackageDescription

let package = Package(
  name: "Shared",
  platforms: [.iOS(.v16)],
  products: [
    .library(name: "Navigation", targets: ["Navigation"]),
    .library(name: "MediaDetails", targets: ["MediaDetails"]),
    .library(name: "DesignSystem", targets: ["DesignSystem"]),
  ],
  dependencies: [
    .package(path: "Core"),
  ],
  targets: [
    .target(name: "Navigation", dependencies: []),
    .target(
      name: "DesignSystem",
      dependencies: [
        .product(name: "Domain", package: "Core")
      ],
      resources: [.process("Resources")]
    ),
    .target(
      name: "MediaDetails",
      dependencies: [
        .product(name: "Domain", package: "Core"),
        .product(name: "Networking", package: "Core")
      ]
    )
  ]
)
