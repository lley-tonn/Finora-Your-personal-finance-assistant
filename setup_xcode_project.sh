#!/bin/bash

# Script to set up Xcode project for Finora
# This script will install XcodeGen if needed and generate the project

set -e

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_NAME="Finora"

echo "🚀 Setting up Xcode project for $PROJECT_NAME..."

# Check if XcodeGen is installed
if ! command -v xcodegen &> /dev/null; then
    echo "📦 XcodeGen not found. Installing via Homebrew..."
    
    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
        echo "❌ Homebrew is not installed. Please install it first:"
        echo "   /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
        exit 1
    fi
    
    brew install xcodegen
    echo "✅ XcodeGen installed successfully"
else
    echo "✅ XcodeGen is already installed"
fi

# Check if project.yml exists
if [ ! -f "$PROJECT_DIR/project.yml" ]; then
    echo "❌ project.yml not found!"
    exit 1
fi

# Generate Xcode project
echo "🔨 Generating Xcode project..."
cd "$PROJECT_DIR"
xcodegen generate

if [ $? -eq 0 ]; then
    echo "✅ Xcode project generated successfully!"
    echo "📂 Project location: $PROJECT_DIR/$PROJECT_NAME.xcodeproj"
    echo ""
    echo "🎉 You can now open the project in Xcode:"
    echo "   open $PROJECT_NAME.xcodeproj"
else
    echo "❌ Failed to generate Xcode project"
    exit 1
fi

