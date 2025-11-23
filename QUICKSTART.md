# Quick Start Guide

## 🚀 Quick Setup

### 1. Install the CLI

**Option 1: Global CLI (Recommended)**
```bash
# Clone the template
git clone <your-repo-url>
cd next-template

# Install globally
./install-cli.sh

# Restart terminal or run:
source ~/.zshrc
```

**Option 2: Use Locally**
```bash
# Clone the template
git clone <your-repo-url>
cd next-template

# Make scripts executable
chmod +x setup.sh process-templates.sh load-config.sh
```

### 2. Create Your Config
Create `my-app-config.json`:
```json
{
  "appName": "my-app",
  "appDescription": "My awesome Next.js app",
  "nodeVersion": "v20.11.0",
  "twitterHandle": "@myhandle",
  "googleAnalyticsId": "G-XXXXXXXXXX",
  "copyright": "Your Company",
  "useAuth": true,
  "useSentry": false,
  "manifest": {
    "name": "My App",
    "shortName": "MyApp",
    "themeColor": "#3B82F6",
    "backgroundColor": "#F9FAFB"
  },
  "dependencies": [
    "@headlessui/react",
    "@heroicons/react",
    "@next/third-parties",
    "@tanstack/react-query"
  ],
  "environments": {
    ".env.local": {
      "NEXT_PUBLIC_SITE_URL": "http://localhost:3000",
      "NEXT_PUBLIC_API_URL": "http://localhost:8080",
      "NODE_ENV": "development"
    },
    ".env.production": {
      "NEXT_PUBLIC_SITE_URL": "https://myapp.com",
      "NEXT_PUBLIC_API_URL": "https://api.myapp.com",
      "NODE_ENV": "production"
    }
  }
}
```

### 3. Create Your App

**Using Global CLI:**
```bash
# Create app in current directory
create-next-app-template my-app-config.json

# Or specify a directory
create-next-app-template my-app-config.json /path/to/projects

# Get help
create-next-app-template --help
```

**Using Locally:**
```bash
# Run the setup script
./setup.sh
```

### 4. Start Developing
```bash
cd my-app
yarn dev
```

## ⚙️ Configuration Options

| Option | Type | Description | Required |
|--------|------|-------------|----------|
| `appName` | string | Name of your Next.js app | ✅ |
| `appDescription` | string | App description for metadata | ✅ |
| `nodeVersion` | string | Node.js version for .nvmrc | ✅ |
| `twitterHandle` | string | Twitter handle for social metadata | ✅ |
| `googleAnalyticsId` | string | Google Analytics tracking ID | ✅ |
| `copyright` | string | Copyright information | ✅ |
| `useAuth` | boolean | Enable auth features | ❌ |
| `useSentry` | boolean | Enable Sentry error tracking | ❌ |
| `manifest` | object | PWA manifest configuration | ❌ |
| `dependencies` | array | Additional npm packages to install | ✅ |
| `environments` | object | Environment-specific variables | ✅ |

## 🔧 Template Variables

Use these variables in your template files:

### Top-level Variables
- `${appName}` - App name from config
- `${appDescription}` - App description
- `${nodeVersion}` - Node.js version
- `${twitterHandle}` - Twitter handle
- `${googleAnalyticsId}` - Google Analytics ID
- `${copyright}` - Copyright information

### Nested Variables
- `${manifest.name}` - PWA manifest name
- `${manifest.shortName}` - PWA manifest short name
- `${manifest.themeColor}` - PWA theme color
- `${manifest.backgroundColor}` - PWA background color

### Array Variables
- `${dependencies}` - Dependencies array

### Environment Variables
- `${NEXT_PUBLIC_SITE_URL}` - Site URL from environment config
- `${NEXT_PUBLIC_API_URL}` - API URL from environment config

Example usage:
```typescript
export const metadata = {
  title: "${appName}",
  description: "${appDescription}"
}
```

## 📁 Template Structure

```
fixtures/          # Static files (Navbar, Footer, etc.)
templates/         # Core templates (layout, manifest, etc.)
auth/             # Auth templates (conditional)
```

## 📋 Prerequisites

- **Node.js** (v18 or higher)
- **Yarn** package manager
- **jq** (for JSON processing)

Install jq:
```bash
# macOS
brew install jq

# Ubuntu/Debian
sudo apt-get install jq

# CentOS/RHEL
sudo yum install jq
```

## 🚨 Common Issues

**"jq not found"**
```bash
brew install jq  # macOS
sudo apt-get install jq  # Ubuntu
```

**"Permission denied"**
```bash
chmod +x *.sh
```

**"config.json not found"**
- Ensure your config file exists and has the correct path
- Check that the CLI is pointing to the right config file

**Need help?**
```bash
create-next-app-template --help
```

## Next Steps

Your app is ready. Start building your features. 🚀