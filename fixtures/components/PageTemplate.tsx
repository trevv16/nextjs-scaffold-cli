export default function PageTemplate({ children }: { children: React.ReactNode }) {
  return (
    <div className="bg-white flex flex-col min-h-screen text-black">
      <main className="flex-grow">{children}</main>
    </div>
  );
}