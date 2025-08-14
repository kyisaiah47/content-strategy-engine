import './globals.css'

export const metadata = {
  title: 'Contentr',
  description: 'AI-powered content strategy for TiDB Hackathon 2025',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  )
}
