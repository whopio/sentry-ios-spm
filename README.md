# sentry-ios-spm

Lightweight SPM wrapper for Sentry iOS. Downloads only the static xcframework (286 MB) instead of all 5 variants from the official repo (2.2 GB).

## Usage

```swift
.package(url: "https://github.com/whopio/sentry-ios-spm.git", .upToNextMajor(from: "9.8.0"))
```

```swift
.product(name: "Sentry", package: "sentry-ios-spm")
```

## Updating to a new Sentry version

```bash
git clone git@github.com:whopio/sentry-ios-spm.git
cd sentry-ios-spm
./update.sh 9.9.0
# Review the diff, then:
git push origin main --tags
```

The script downloads the xcframework, computes the checksum, updates `Package.swift`, commits, and tags. After pushing, update `packagebot.yml` in the monorepo to the new version and run `make layers`.

## Why?

The official `getsentry/sentry-cocoa` Package.swift defines 5 binary targets (static, dynamic, ARM64e variants). SPM downloads **all** of them regardless of which product you depend on. This wrapper exposes only the static `Sentry` xcframework.
