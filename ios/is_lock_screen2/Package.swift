// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "is_lock_screen2",
    platforms: [
        .iOS("12.0")
    ],
    products: [
        .library(name: "is-lock-screen2", targets: ["is_lock_screen2"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "is_lock_screen2",
            dependencies: [],
            path: "Sources/is_lock_screen2"
        )
    ]
)
