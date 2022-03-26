// swift-tools-version: 5.6

import PackageDescription

let package = Package(
  name: "Storage",
  platforms: [.iOS(.v15)],
  products: [
    .library(name: "Storage", targets: ["Storage"]),
  ],
  dependencies: [
    .package(path: "Core")
  ],
  targets: [
    .target(name: "Storage", dependencies: ["Core"]),
    .testTarget(name: "StorageTests", dependencies: ["Storage"]),
  ]
)
