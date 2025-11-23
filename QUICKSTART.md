# Quick Start Guide

## 🚀 Quick Setup

### 1. Install the CLI
```bash
# Clone the template
git clone <your-repo-url>
cd next-template

# Install globally
./install-cli.sh

# Restart terminal or run:
source ~/.zshrc
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
```bash
# Create app in current directory
create-next-app-template my-app-config.json

# Or specify a directory
create-next-app-template my-app-config.json /path/to/projects
```

### 4. Start Developing
```bash
cd my-app
yarn dev
```

## 🎯 What You Get

✅ **Next.js 14** with App Router  
✅ **TypeScript** configured  
✅ **Tailwind CSS** for styling  
✅ **Headless UI** components  
✅ **Heroicons** for icons  
✅ **React Query** for data fetching  
✅ **Form handling** with react-hook-form  
✅ **Toast notifications**  
✅ **PWA manifest**  
✅ **SEO optimized** (robots.txt, sitemap)  
✅ **Environment files** for all stages  
✅ **Google Analytics** setup  
✅ **Sentry** integration (optional)  
✅ **Auth system** (optional)  

## 🔧 Customization

### Add Template Variables
Use `${variableName}` in any template file:
```typescript
// In your template files
export const metadata = {
  title: "${appName}",
  description: "${appDescription}"
}
```

### Enable Features
```json
{
  "useAuth": true,    // Adds auth pages and components
  "useSentry": true   // Adds error tracking
}
```

### Add Dependencies
```json
{
  "dependencies": [
    "@headlessui/react",
    "your-custom-package"
  ]
}
```

## 📁 Template Structure

```
fixtures/          # Static files (Navbar, Footer, etc.)
templates/         # Core templates (layout, manifest, etc.)
auth/             # Auth templates (conditional)
```

## 🚨 Common Issues

**"jq not found"**
```bash
brew install jq  # macOS
```

**"Permission denied"**
```bash
chmod +x *.sh
```

**Need help?**
```bash
create-next-app-template --help
```

## Next Steps

Your app is ready. Start building your features. 🚀