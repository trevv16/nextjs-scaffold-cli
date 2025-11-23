#! /bin/bash

# Load configuration
source ./load-config.sh

# Check if the app directory already exists
if [ -d "$appName" ]; then
    echo "Warning: Directory '$appName' already exists!"
    echo "Options:"
    echo "  1. Use existing app and process templates only"
    echo "  2. Remove existing directory and create new app"
    echo "  3. Exit setup"
    read -p "Choose an option (1, 2, or 3): " choice
    
    case $choice in
        1)
            echo "Using existing app, processing templates only..."
            SKIP_INSTALL=true
            ;;
        2)
            echo "Removing existing directory..."
            rm -rf "$appName"
            SKIP_INSTALL=false
            ;;
        3)
            echo "Setup cancelled."
            exit 0
            ;;
        *)
            echo "Invalid option. Setup cancelled."
            exit 1
            ;;
    esac
else
    echo "Creating new Next.js app..."
    SKIP_INSTALL=false
fi

# Change to original directory before creating app
if [ -n "$ORIGINAL_DIR" ]; then
    echo "Changing to original directory: $ORIGINAL_DIR"
    cd "$ORIGINAL_DIR"
fi

# Install Next.js if needed
if [ "$SKIP_INSTALL" = "false" ]; then
    # Install nextjs with all flags to avoid prompts
    npx create-next-app@latest "$appName" \
      --typescript \
      --tailwind \
      --eslint \
      --no-src-dir \
      --app \
      --import-alias "@/*" \
      --no-turbopack \
      --use-yarn
fi

# cd into the app directory (whether new or existing)
cd "$appName"

# add .nvmrc
echo "Setting up .nvmrc..."
echo "$nodeVersion" > .nvmrc

# Create environment files with specific variables (now inside the app directory)
echo "Creating environment files..."
for env_file in "${ENV_FILES[@]}"; do
    get_env_vars "$env_file" > "$env_file"
done

echo "Installing dependencies..."
yarn add "${DEPENDENCIES[@]}"

# make new directories
mkdir -p components hooks utils "app/(index)"

# Use the template directory from environment variable
if [ -z "$TEMPLATE_DIR" ]; then
    echo "Error: TEMPLATE_DIR environment variable not set"
    exit 1
fi

# Process templates from templates folder
echo "Processing templates from templates folder..."
"$TEMPLATE_DIR/process-templates.sh" "$TEMPLATE_DIR/templates" "$ORIGINAL_DIR/$appName"

# Conditionally process auth templates if enabled
if [ "$useAuth" = "true" ]; then
    echo "Auth enabled - installing dependencies..."
    cd "$ORIGINAL_DIR/$appName"
    yarn add @sentry/nextjs

    echo "Auth enabled - processing auth templates..."
    if [ -d "$TEMPLATE_DIR/auth" ]; then
        "$TEMPLATE_DIR/process-templates.sh" "$TEMPLATE_DIR/auth" "$ORIGINAL_DIR/$appName"
    else
        echo "Warning: auth folder not found"
    fi
else
    echo "Auth disabled - skipping auth templates"
fi

# Process fixtures (non-templated files) with template processing
echo "Processing fixtures with templates..."
"$TEMPLATE_DIR/process-templates.sh" "$TEMPLATE_DIR/fixtures" "$ORIGINAL_DIR/$appName"

# Change back to app directory for final steps
cd "$ORIGINAL_DIR/$appName"

# setup sentry
if [ "$useSentry" = "true" ]; then
    echo "Sentry enabled - setting up sentry..."
    npx @sentry/wizard@latest -i nextjs
fi

echo "Setup complete!"
