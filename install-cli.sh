#!/bin/bash

# Install Next.js Template CLI globally

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Installing Next.js Template CLI...${NC}"

# Get the current directory (template directory)
TEMPLATE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Create global bin directory if it doesn't exist
GLOBAL_BIN="$HOME/.local/bin"
mkdir -p "$GLOBAL_BIN"

# Create the global CLI script
CLI_SCRIPT="$GLOBAL_BIN/create-next-app-template"

cat > "$CLI_SCRIPT" << EOF
#!/bin/bash

# Global Next.js Template CLI

TEMPLATE_DIR="$TEMPLATE_DIR"

# Call the template CLI with the template directory
"\$TEMPLATE_DIR/create-next-app-template.sh" "\$@"
EOF

# Make it executable
chmod +x "$CLI_SCRIPT"

# Add to PATH if not already there
if [[ ":\$PATH:" != *":$GLOBAL_BIN:"* ]]; then
    echo "export PATH=\"\$PATH:$GLOBAL_BIN\"" >> "$HOME/.zshrc"
    echo "export PATH=\"\$PATH:$GLOBAL_BIN\"" >> "$HOME/.bashrc"
    echo -e "${BLUE}Added $GLOBAL_BIN to your PATH${NC}"
fi

echo -e "${GREEN}✅ Next.js Template CLI installed successfully!${NC}"
echo ""
echo "You can now use the CLI from anywhere:"
echo "  create-next-app-template my-config.json my-app"
echo "  create-next-app-template my-config.json my-app /path/to/projects"
echo ""
echo "To see all options:"
echo "  create-next-app-template --help"
echo ""
echo "Note: You may need to restart your terminal or run 'source ~/.zshrc' for the PATH changes to take effect." 