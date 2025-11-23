'use client';

interface IconProps {
  name: string;
  size: string;
}

export default function Icon(props: IconProps) {
  switch (props.name?.toLowerCase()) {
    case 'linkedin':
      return <div className={`${props.size} flex-shrink-0 hover:text-gray-500`} />;

    case 'github':
      return <div className={`${props.size} flex-shrink-0 hover:text-gray-500`} />;

    default:
      return null;
  }
}
