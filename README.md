# sentry-ios-spm

Lightweight SPM wrapper for Sentry iOS. Downloads only the static xcframework (286 MB) instead of all 5 variants from the official repo (2.2 GB).

## Usage

```swift
.package(url: "https://github.com/mthole/sentry-ios-spm.git", exact: "9.8.0")
```

```swift
.product(name: "Sentry", package: "sentry-ios-spm")
```

## Why?

The official `getsentry/sentry-cocoa` Package.swift defines 5 binary targets. SPM downloads all of them regardless of which product you depend on. This wrapper exposes only the static `Sentry` xcframework.
