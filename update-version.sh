#!/bin/bash

# Check if a version type is provided (patch, minor, major)
if [ -z "$1" ]; then
  echo "Usage: $0 <patch|minor|major>"
  exit 1
fi

# Bump the version in package.json using yarn
yarn version --$1

# Get the new version from package.json
NEW_VERSION=$(node -p "require('./package.json').version")

# Commit the version bump
git add package.json yarn.lock
git commit -m "chore(release): bump version to $NEW_VERSION"

# Tag the new version
git tag "$NEW_VERSION"

# Push changes and tags
git push origin main
git push origin "$NEW_VERSION"

echo "Version bumped to $NEW_VERSION, committed, and tagged successfully!"
