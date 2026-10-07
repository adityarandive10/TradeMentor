import React from 'react'
import Header from './components/Header'
import Footer from './components/Footer'
import AIAnalyst from './pages/AIAnalyst'

function App() {
  return (
    <div className="min-h-screen bg-light-gray font-sans flex flex-col">
      <Header />
      <main className="flex-1 w-full px-4 py-8">
        <AIAnalyst />
      </main>
      <Footer />
    </div>
  )
}

export default App
