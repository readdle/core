// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Core",
    products: [
        .library(name: "Async", targets: ["Async"]),
        .library(name: "Bits", targets: ["Bits"]),
        .library(name: "Core", targets: ["Core"]),
        .library(name: "COperatingSystem", targets: ["COperatingSystem"]),
        .library(name: "Debugging", targets: ["Debugging"]),
    ],
    dependencies: [
        /// Event-driven network application framework for high performance protocol servers & clients, non-blocking.
        .package(url: "https://github.com/readdle/swift-nio.git", .branch("1.14.1-android.2")),
    ],
    targets: [
        .target(name: "Async", dependencies: ["NIO"]),
        .testTarget(name: "AsyncTests", dependencies: ["Async"]),
        .target(name: "Bits", dependencies: ["Debugging", "NIO"]),
        .testTarget(name: "BitsTests", dependencies: ["Bits", "NIO"]),
        .target(name: "Core", dependencies: ["Async", "Bits", "COperatingSystem", "Debugging", "NIOFoundationCompat"]),
        .testTarget(name: "CoreTests", dependencies: ["Core"]),
        .target(name: "COperatingSystem"),
        .target(name: "Debugging"),
        .testTarget(name: "DebuggingTests", dependencies: ["Debugging"]),
    ],
    swiftLanguageVersions: [.v5],
    cLanguageStandard: .c11,
    cxxLanguageStandard: .cxx11
)
