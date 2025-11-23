import Link from "next/link"

export default function NotFound() {
  return (
    <div className="bg-white flex flex-col items-center justify-center min-h-screen">
      <h2 className="text-2xl text-black font-bold mb-4">404 - Page Not Found</h2>
      <p className="mb-4 text-black">Sorry, we couldn&apos;t find the page you&apos;re looking for.</p>
      <Link href="/" className="px-4 py-2 bg-indigo-500 text-white rounded hover:bg-indigo-600">
        Go back home
      </Link>
    </div>
  )
}
