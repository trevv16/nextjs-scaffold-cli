# Next.js Scaffold CLI

⚡ Solves what create-next-app and templates don't: create-next-app makes you set up everything manually, templates go stale fast. This is the perfect blend - always-fresh dependencies with common features pre-configured.

## 🚀 Features

- **Always Fresh Dependencies** - Never go stale. Always installs the latest package versions, unlike static templates
- **Pre-Configured Common Features** - Auth, Sentry, and other integrations you'd normally set up manually
- **Like create-next-app, But Better** - All the freshness of create-next-app, plus the convenience of pre-configured features
- **Dynamic Templating** - Variable substitution in all template files
- **Conditional Features** - Enable/disable auth, Sentry, and other features via config
- **Cross-Platform** - Works on macOS, Linux, and WSL
- **Global CLI** - Create apps from anywhere with custom configs
- **Flexible Configuration** - JSON-based configuration with nested objects and arrays

## 📋 Prerequisites

- **Node.js** (v18 or higher)
- **Yarn** package manager
- **jq** (for JSON processing)
  ```bash
  # macOS
  brew install jq
  
  # Ubuntu/Debian
  sudo apt-get install jq
  
  # CentOS/RHEL
  sudo yum install jq
  ```

## 🛠️ Installation

### Option 1: Install Global CLI (Recommended)

```bash
# Clone the template repository
git clone <your-repo-url>
cd next-template

# Install the global CLI
./install-cli.sh

# Restart your terminal or run:
source ~/.zshrc
```

### Option 2: Use Locally

```bash
# Clone the template repository
git clone <your-repo-url>
cd next-template

# Make scripts executable
chmod +x setup.sh process-templates.sh load-config.sh
```

## 📖 Usage

### Using the Global CLI

```bash
# Create app with custom config
create-next-app-template my-config.json my-app

# Create app in specific directory
create-next-app-template my-config.json my-app /path/to/projects

# Get help
create-next-app-template --help
```

### Using Locally

```bash
# Run the setup script
./setup.sh
```

## ⚙️ Configuration

Create a `config.json` file with your app settings:

```json
{
  "appName": "my-awesome-app",
  "appDescription": "Your app description",
  "nodeVersion": "v20.11.0",
  "twitterHandle": "@myhandle",
  "googleAnalyticsId": "G-XXXXXXXXXX",
  "copyright": "Your Company",
  "useAuth": true,
  "useSentry": false,
  "manifest": {
    "name": "My Awesome App",
    "shortName": "AwesomeApp",
    "themeColor": "#3B82F6",
    "backgroundColor": "#F9FAFB"
  },
  "dependencies": [
    "@headlessui/react",
    "@heroicons/react",
    "@next/third-parties",
    "@tanstack/react-query",
    "react-hook-form",
    "@hookform/resolvers",
    "react-hot-toast",
    "zod"
  ],
  "environments": {
    ".env.local": {
      "NEXT_PUBLIC_SITE_URL": "http://localhost:3000",
      "NEXT_PUBLIC_API_URL": "http://localhost:8080",
      "NODE_ENV": "development"
    },
    ".env.staging": {
      "NEXT_PUBLIC_SITE_URL": "https://stg.myapp.com",
      "NEXT_PUBLIC_API_URL": "https://stg.api.myapp.com",
      "NODE_ENV": "staging"
    },
    ".env.production": {
      "NEXT_PUBLIC_SITE_URL": "https://myapp.com",
      "NEXT_PUBLIC_API_URL": "https://api.myapp.com",
      "NODE_ENV": "production"
    },
    ".env.example": {
      "NEXT_PUBLIC_SITE_URL": "http://localhost:3000",
      "NEXT_PUBLIC_API_URL": "http://localhost:8080",
      "NODE_ENV": "development"
    }
  }
}
```

### Configuration Options

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

## 📁 Project Structure

```
next-template/
├── config.json              # Template configuration
├── setup.sh                 # Main setup script
├── process-templates.sh     # Template processor
├── load-config.sh          # Configuration loader
├── create-next-app-template.sh  # CLI script
├── install-cli.sh          # CLI installer
├── fixtures/               # Static files (processed with templates)
│   ├── components/
│   │   ├── Navbar.tsx
│   │   └── Footer.tsx
│   ├── app/
│   └── public/
├── templates/              # Template files (processed with templates)
│   ├── app/
│   │   ├── layout.tsx
│   │   └── providers.tsx
│   ├── manifest.json
│   ├── robots.ts
│   └── sitemap.ts
├── auth/                   # Auth templates (conditional)
│   ├── app/
│   │   └── auth/
│   ├── components/
│   └── lib/
└── README.md
```

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

## 🎯 Conditional Features

### Auth System
Set `"useAuth": true` in your config to include auth templates:
- Login/register pages
- Auth components
- Authentication utilities

### Sentry Integration
Set `"useSentry": true` in your config to include Sentry:
- Error tracking setup
- Performance monitoring
- Release tracking

## 🔄 Workflow

### Development Workflow

1. **Create config** - Define your app configuration
2. **Run CLI** - Create new app with your config
3. **Customize** - Modify templates as needed
4. **Test** - Verify everything works
5. **Deploy** - Deploy your app

### Template Development

1. **Modify templates** - Update files in `fixtures/`, `templates/`, or `auth/`
2. **Test locally** - Run `./setup.sh` to test changes
3. **Update config** - Add new variables to `config.json`
4. **Document** - Update this README with new features

## 🐛 Troubleshooting

### Common Issues

**"jq: command not found"**
```bash
# Install jq
brew install jq  # macOS
sudo apt-get install jq  # Ubuntu
```

**"Permission denied"**
```bash
# Make scripts executable
chmod +x *.sh
```

**"config.json not found"**
- Ensure your config file exists and has the correct path
- Check that the CLI is pointing to the right config file

**"sed: RE error: illegal byte sequence"**
- Binary files are handled separately from text files

### Debug Mode

Add `set -x` to any script to see detailed execution:
```bash
#!/bin/bash
set -x  # Add this line for debugging
# ... rest of script
```

## Contributing

Pull requests welcome. Make sure to test your changes.

## License

MIT
