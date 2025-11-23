#!/bin/bash

# Next.js Template CLI
# Usage: ./create-next-app-template.sh [config_file] [app_name] [target_directory]
# Example: ./create-next-app-template.sh my-config.json my-app /path/to/projects

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Function to show usage
show_usage() {
    echo "Next.js Template CLI"
    echo ""
    echo "Usage: $0 [config_file] [target_directory]"
    echo ""
    echo "Arguments:"
    echo "  config_file     Path to your config.json file"
    echo "  target_directory Directory where to create the app (optional, defaults to current directory)"
    echo ""
    echo "Examples:"
    echo "  $0 my-config.json"
    echo "  $0 my-config.json /path/to/projects"
    echo "  $0 /absolute/path/to/config.json /absolute/path/to/projects"
    echo ""
    echo "Config file should contain:"
    echo "  - appName, appDescription, nodeVersion"
    echo "  - dependencies array"
    echo "  - environments object"
    echo "  - manifest object (optional)"
    echo "  - useAuth, useSentry flags (optional)"
}

# Check if help is requested
if [ "$1" = "-h" ] || [ "$1" = "--help" ] || [ "$1" = "help" ]; then
    show_usage
    exit 0
fi

# Validate arguments
if [ $# -lt 1 ]; then
    print_error "Missing required arguments"
    echo ""
    show_usage
    exit 1
fi

CONFIG_FILE="$1"
TARGET_DIR="${2:-.}"

# Validate config file
if [ ! -f "$CONFIG_FILE" ]; then
    print_error "Config file not found: $CONFIG_FILE"
    exit 1
fi

# Validate target directory
if [ ! -d "$TARGET_DIR" ]; then
    print_error "Target directory not found: $TARGET_DIR"
    exit 1
fi

# Get the template directory (where this script is located)
TEMPLATE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_info "Next.js Template CLI"
print_info "Template directory: $TEMPLATE_DIR"
print_info "Config file: $CONFIG_FILE"
print_info "Target directory: $TARGET_DIR"

# Check if required template files exist
if [ ! -f "$TEMPLATE_DIR/setup.sh" ]; then
    print_error "Template setup.sh not found in: $TEMPLATE_DIR"
    exit 1
fi

if [ ! -f "$TEMPLATE_DIR/process-templates.sh" ]; then
    print_error "Template process-templates.sh not found in: $TEMPLATE_DIR"
    exit 1
fi

# Store the original working directory
ORIGINAL_DIR="$(pwd)"

# Copy user's config file to template directory
print_info "Copying config file..."
cp "$CONFIG_FILE" "$TEMPLATE_DIR/config.json"

# Get app name from config for final message
APP_NAME=$(jq -r '.appName' "$CONFIG_FILE")

# Change to template directory to run setup script
cd "$TEMPLATE_DIR"

# Make sure setup script is executable
chmod +x ./setup.sh

# Export target directory and original directory for setup script
export TARGET_DIR="$TARGET_DIR"
export ORIGINAL_DIR="$ORIGINAL_DIR"
export TEMPLATE_DIR="$TEMPLATE_DIR"

# Run the setup script
print_info "Starting app creation..."
./setup.sh

# Clean up config file from template directory
print_info "Cleaning up..."
rm -f "$TEMPLATE_DIR/config.json"

print_success "App creation complete!"
print_success "Your new app is ready in: $ORIGINAL_DIR/$APP_NAME"
print_info "To get started:"
echo "  cd $ORIGINAL_DIR/$APP_NAME"
echo "  yarn dev" 