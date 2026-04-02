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
            url: "https://github.com/getsentry/sentry-cocoa/releases/download/9.8.0/Sentry.xcframework.zip",
            checksum: "17b5cdca223d333f21609c59b97afe26b964eddba3b89186033386d7ba22024d"
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
