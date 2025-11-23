#!/bin/bash

# Cross-platform template processor
# Usage: ./process-templates.sh [source_dir] [target_dir] [conflict_mode]
# conflict_mode: overwrite (default), skip, or merge

set -e

# Default directories and conflict mode
SOURCE_DIR="${1:-./resources}"
TARGET_DIR="${2:-./app}"
CONFLICT_MODE="${3:-overwrite}"

# Get the directory where this script is located (template directory)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory '$SOURCE_DIR' not found"
    exit 1
fi

echo "Processing templates from '$SOURCE_DIR' to '$TARGET_DIR' (conflict mode: $CONFLICT_MODE)..."

# Function to process a single file
process_file() {
    local source_file="$1"
    local target_file="$2"
    
    # Check if target file already exists
    if [ -f "$target_file" ] && [ "$CONFLICT_MODE" = "skip" ]; then
        echo "Skipping existing file: $target_file"
        return
    fi
    
    echo "Processing: $source_file -> $target_file"
    
    # Create target directory if needed
    mkdir -p "$(dirname "$target_file")"
    
    # Start with the original file content
    local content=$(cat "$source_file")
    
    # Process top-level variables (strings and numbers only)
    local top_level_vars=$(jq -r 'to_entries[] | select(.value | type == "string" or type == "number") | .key' "$SCRIPT_DIR/config.json")
    
    # Apply each top-level variable substitution
    while IFS= read -r var_name; do
        if [ -n "$var_name" ]; then
            # Get the variable value
            local var_value=$(jq -r ".$var_name" "$SCRIPT_DIR/config.json")
            # Escape special characters in the value for sed
            var_value=$(echo "$var_value" | sed 's/[\/&]/\\&/g')
            # Apply the substitution
            content=$(echo "$content" | sed "s/\${$var_name}/$var_value/g")
        fi
    done <<< "$top_level_vars"
    
    # Process nested variables (like manifest.name, manifest.themeColor, etc.)
    local nested_vars=$(jq -r 'to_entries[] | select(.value | type == "object") | .key as $parent | .value | to_entries[] | select(.value | type == "string" or type == "number") | "\($parent).\(.key)"' "$SCRIPT_DIR/config.json")
    
    # Apply each nested variable substitution
    while IFS= read -r var_path; do
        if [ -n "$var_path" ]; then
            # Get the variable value
            local var_value=$(jq -r ".$var_path" "$SCRIPT_DIR/config.json")
            # Escape special characters in the value for sed
            var_value=$(echo "$var_value" | sed 's/[\/&]/\\&/g')
            # Apply the substitution
            content=$(echo "$content" | sed "s/\${$var_path}/$var_value/g")
        fi
    done <<< "$nested_vars"
    
    # Process array variables (like dependencies)
    # For arrays, we need to handle them more carefully due to newlines and special characters
    local array_vars=$(jq -r 'to_entries[] | select(.value | type == "array") | .key' "$SCRIPT_DIR/config.json")
    
    # Apply each array variable substitution
    while IFS= read -r array_name; do
        if [ -n "$array_name" ]; then
            # Get the array as JSON string and convert to single line
            local array_value=$(jq -c ".$array_name" "$SCRIPT_DIR/config.json")
            # Escape special characters in the value for sed
            array_value=$(echo "$array_value" | sed 's/[\/&]/\\&/g')
            # Apply the substitution
            content=$(echo "$content" | sed "s/\${$array_name}/$array_value/g")
        fi
    done <<< "$array_vars"
    
    # Handle conflict mode
    if [ -f "$target_file" ] && [ "$CONFLICT_MODE" = "merge" ]; then
        echo "Merging with existing file: $target_file"
        # For now, just append the new content (you might want more sophisticated merging)
        echo "$content" >> "$target_file"
    else
        # Write the processed content to the target file (overwrite or new file)
        echo "$content" > "$target_file"
    fi
}

# Function to copy binary files without processing
copy_binary_file() {
    local source_file="$1"
    local target_file="$2"
    
    # Check if target file already exists
    if [ -f "$target_file" ] && [ "$CONFLICT_MODE" = "skip" ]; then
        echo "Skipping existing file: $target_file"
        return
    fi
    
    echo "Copying binary file: $source_file -> $target_file"
    
    # Create target directory if needed
    mkdir -p "$(dirname "$target_file")"
    
    # Copy the file directly without processing
    cp "$source_file" "$target_file"
}

# Process text files with template processing
find "$SOURCE_DIR" -type f \( -name "*.tsx" -o -name "*.ts" -o -name "*.js" -o -name "*.jsx" -o -name "*.json" -o -name "*.txt" -o -name "*.md" -o -name "*.css" -o -name "*.html" \) | while read -r source_file; do
    # Calculate relative path from source directory
    rel_path="${source_file#$SOURCE_DIR/}"
    target_file="$TARGET_DIR/$rel_path"
    
    process_file "$source_file" "$target_file"
done

# Copy binary files without processing
find "$SOURCE_DIR" -type f \( -name "*.ico" -o -name "*.png" -o -name "*.jpg" -o -name "*.jpeg" -o -name "*.svg" -o -name "*.woff" -o -name "*.woff2" -o -name "*.ttf" -o -name "*.eot" -o -name "*.gif" -o -name "*.webp" -o -name "*.pdf" \) | while read -r source_file; do
    # Calculate relative path from source directory
    rel_path="${source_file#$SOURCE_DIR/}"
    target_file="$TARGET_DIR/$rel_path"
    
    copy_binary_file "$source_file" "$target_file"
done

echo "Template processing complete!"
echo "Files processed: $(find "$TARGET_DIR" -type f | wc -l | tr -d ' ')" 