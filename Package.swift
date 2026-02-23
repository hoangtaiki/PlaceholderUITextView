
// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PlaceholderUITextView",
    platforms: [
        .iOS(.v12),
        .macCatalyst(.v13)
    ],
    products: [
        .library(
            name: "PlaceholderUITextView",
            targets: ["PlaceholderUITextView"]
        )
    ],
    dependencies: [
        // No external dependencies required for core functionality
    ],
    targets: [
        .target(
            name: "PlaceholderUITextView",
            path: "Source",
            resources: []
        ),
        .testTarget(
            name: "PlaceholderUITextViewTests",
            dependencies: ["PlaceholderUITextView"],
            path: "Tests"
        )
    ],
    swiftLanguageVersions: [.v5]
)
