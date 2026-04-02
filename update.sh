#!/bin/bash
set -euo pipefail

# Updates the wrapper to a new Sentry version.
# Usage: ./update.sh 9.9.0

VERSION="${1:-}"
if [ -z "$VERSION" ]; then
  echo "Usage: ./update.sh <version>"
  echo "Example: ./update.sh 9.9.0"
  echo ""
  echo "Latest release:"
  gh api repos/getsentry/sentry-cocoa/releases/latest --jq '  .tag_name'
  exit 1
fi

URL="https://github.com/getsentry/sentry-cocoa/releases/download/${VERSION}/Sentry.xcframework.zip"

echo "Downloading Sentry.xcframework.zip for ${VERSION}..."
TMPFILE=$(mktemp)
if ! curl -fSL "$URL" -o "$TMPFILE" 2>/dev/null; then
  echo "Error: Failed to download ${URL}"
  echo "Check that version ${VERSION} exists at https://github.com/getsentry/sentry-cocoa/releases"
  rm -f "$TMPFILE"
  exit 1
fi

echo "Computing checksum..."
CHECKSUM=$(swift package compute-checksum "$TMPFILE")
rm -f "$TMPFILE"

echo "Updating Package.swift..."
sed -i '' "s|/download/[^/]*/Sentry.xcframework.zip|/download/${VERSION}/Sentry.xcframework.zip|" Package.swift
sed -i '' "s|checksum: \"[a-f0-9]*\"|checksum: \"${CHECKSUM}\"|" Package.swift

echo "Creating commit and tag..."
git add Package.swift
git commit -m "Update to Sentry ${VERSION}"
git tag "${VERSION}"

echo ""
echo "Done! Review the changes, then push:"
echo "  git push origin main --tags"
