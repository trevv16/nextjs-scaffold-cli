"use client";

export default function Error({
  error,
  reset,
}: {
  error: Error
  reset: () => void
}) {
  console.error(error)

  return (
    <div className="flex flex-col items-center justify-center min-h-screen px-4 py-12">
      <h2 className="text-2xl font-bold mb-4">Something went wrong!</h2>
      <button
        className="px-4 py-2 bg-primary-500 text-indigo-200 rounded hover:bg-primary-600"
        onClick={
          // Attempt to recover by trying to re-render the segment
          () => reset()
        }
      >
        Try again
      </button>
    </div>
  )
}
