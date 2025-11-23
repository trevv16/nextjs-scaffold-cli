import Icon from "./Icon";

const navigation = [
  {
    "name": "GitHub",
    "href": "https://github.com/trevv16",
    "icon": "github",
    "iconSize": "w-6 h-6"
  },
  {
    "name": "LinkedIn",
    "href": "https://www.linkedin.com/in/trevornjeru",
    "icon": "linkedin",
    "iconSize": "w-6 h-6"
  }
];

export default function Footer() {
  return (
    <footer className="bg-white">
      <div className="mx-auto max-w-7xl px-6 py-12 md:flex md:items-center md:justify-between lg:px-8">
        <div className="flex justify-center gap-x-6 md:order-2">
          {navigation.map((item) => (
            <a key={item.name} href={item.href} className="text-gray-600 hover:text-gray-800">
              <span className="sr-only">{item.name}</span>
              <Icon name={item.icon} aria-hidden="true" className={item.iconSize} />
            </a>
          ))}
        </div>
        <p className="mt-8 text-center text-sm/6 text-gray-600 md:order-1 md:mt-0">
          &copy; {new Date().getFullYear()} ${copyright}. All rights reserved.
        </p>
      </div>
    </footer>
  )
}
