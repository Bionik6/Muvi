// swift-tools-version: 5.7
import PackageDescription

let package = Package(
  name: "Core",
  platforms: [.iOS(.v16)],
  products: [
    .library(name: "Utils", targets: ["Utils"]),
    .library(name: "Domain", targets: ["Domain"]),
    .library(name: "Storage", targets: ["Storage"]),
    .library(name: "Networking", targets: ["Networking"] ),
  ],
  dependencies: [
  ],
  targets: [
    .target(name: "Utils"),
    .target(name: "Domain"),
    .target(name: "Storage"),
    .target(name: "Networking", dependencies: ["Domain"]),
  ]
)
