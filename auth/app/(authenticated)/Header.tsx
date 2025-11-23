'use client'

type HeaderProps = {
  pageTitle: string;
  headerActions: React.ReactNode;
}

export default function Header({ pageTitle, headerActions }: HeaderProps) {
  return (
    <div className="bg-dark">
      <header className="py-10">
        <div className="lg:flex lg:items-center lg:justify-between">
          <div className="min-w-0 flex-1">
            <h2 className="text-2xl/7 font-bold sm:truncate sm:text-3xl sm:tracking-tight text-base">
              {pageTitle}
            </h2>
          </div>
          <div className="mt-5 flex lg:mt-0 lg:ml-4">
            {headerActions}
          </div>
        </div>
      </header>
    </div>
  )
}