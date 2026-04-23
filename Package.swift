// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "sentry-ios-spm",
    platforms: [.iOS(.v13), .macOS(.v10_15), .tvOS(.v13), .watchOS(.v6)],
    products: [
        .library(name: "Sentry", targets: ["Sentry", "SentryCppHelper"])
    ],
    targets: [
        .binaryTarget(
            name: "Sentry",
            url: "https://github.com/getsentry/sentry-cocoa/releases/download/9.11.0/Sentry.xcframework.zip",
            checksum: "438de2c5afb7dde20b640af35dd841961aa2aa4d2719e40c92d48bd2aa5dca56"
        ),
        .target(
            name: "SentryCppHelper",
            path: "Sources/SentryCppHelper",
            linkerSettings: [
                .linkedLibrary("c++")
            ]
        )
    ]
)
