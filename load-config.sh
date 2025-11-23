#!/bin/bash

# Load configuration from config.json
# Usage: source ./load-config.sh

# Store the template directory path when this script is first loaded
export TEMPLATE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ ! -f "config.json" ]; then
    echo "Error: config.json not found"
    exit 1
fi

# Read JSON using jq (install with: brew install jq)
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required. Install with: brew install jq"
    exit 1
fi

# Dynamically export all top-level variables (strings, numbers, and booleans)
# Use eval to avoid subshell issues
eval "$(jq -r 'to_entries[] | select(.value | type == "string" or type == "number" or type == "boolean") | "export \(.key)=\"\(.value)\""' config.json)"

# Export dependencies as array
export DEPENDENCIES=($(jq -r '.dependencies[]' config.json))

# Export environment files
export ENV_FILES=($(jq -r '.environments | keys[]' config.json))

# Function to get environment variables for a specific file
# This function can be called from any directory, so it needs to find config.json
get_env_vars() {
    local env_file="$1"
    # Use the stored template directory path
    local config_file="$TEMPLATE_DIR/config.json"
    jq -r ".environments[\"$env_file\"] | to_entries[] | \"\(.key)=\(.value)\"" "$config_file"
}

# Export the function so scripts can use it
export -f get_env_vars

echo "Configuration loaded:"
echo "  Variables exported: $(jq -r 'to_entries[] | select(.value | type == "string" or type == "number" or type == "boolean") | .key' config.json | tr '\n' ' ')"
echo "  Dependencies: ${DEPENDENCIES[*]}"
echo "  Environment files: ${ENV_FILES[*]}" 