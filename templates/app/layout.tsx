import Footer from "@/components/Footer";
import Navbar from "@/components/Navbar";
import { GoogleAnalytics } from '@next/third-parties/google';
import type { Metadata } from "next";
import { Geist, Geist_Mono } from "next/font/google";
import "./globals.css";
import Providers from "./providers";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

export const metadata: Metadata = {
  metadataBase: new URL(process.env.NEXT_PUBLIC_SITE_URL || 'http://localhost:3000'),
  title: {
    default: "${manifest.name}",
    template: "%s | ${manifest.name}"
  },
  description: "${appDescription}",
  alternates: {
    canonical: "/",
  },
  openGraph: {
    title: "${manifest.name}",
    description: "${appDescription}",
    url: "/",
    siteName: "${manifest.name}",
    images: [
      {
        url: "/opengraph-image.jpg",
        width: 1200,
        height: 630,
        alt: "${manifest.name}"
      }
    ],
    locale: "en_US",
    type: "website"
  },
  twitter: {
    card: "summary_large_image",
    title: "${manifest.name}",
    description: "${appDescription}",
    creator: "${twitterHandle}",
    site: "${twitterHandle}",
    images: ["/opengraph-image.jpg"]
  },
  icons: {
    icon: "/favicon.ico"
  }
}

const GOOGLE_ANALYTICS_ID = "${googleAnalyticsId}"

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body
        className={`${geistSans.variable} ${geistMono.variable} antialiased`}
      >
        <Providers>
          <Navbar />
          {children}
          <Footer />
        </Providers>
      </body>
      {process.env.NODE_ENV === "production" && (
        <GoogleAnalytics gaId={GOOGLE_ANALYTICS_ID} />
      )}
    </html>
  );
}
