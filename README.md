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

## 🎯 Conditional Features

### Auth System
Set `"useAuth": true` in your config to include:
- Login/register pages
- Auth components
- Authentication utilities

### Sentry Integration
Set `"useSentry": true` in your config to include:
- Error tracking setup
- Performance monitoring
- Release tracking

## Getting Started

See [QUICKSTART.md](./QUICKSTART.md) for installation, usage, and configuration details.

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

## Template Development

1. **Modify templates** - Update files in `fixtures/`, `templates/`, or `auth/`
2. **Test locally** - Run `./setup.sh` to test changes
3. **Update config** - Add new variables to `config.json`
4. **Document** - Update this README with new features

## Contributing

Pull requests welcome. Make sure to test your changes.

## License

MIT
