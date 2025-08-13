'use client'

import { useState, useEffect } from 'react'

export default function Home() {
  const [apiStatus, setApiStatus] = useState('checking...')

  useEffect(() => {
    fetch('http://localhost:8000/health')
      .then(res => res.json())
      .then(data => setApiStatus(data.status))
      .catch(() => setApiStatus('disconnected'))
  }, [])

  return (
    <div className="min-h-screen bg-gray-50 p-8">
      <div className="max-w-4xl mx-auto">
        <h1 className="text-4xl font-bold text-gray-900 mb-4">
          Content Strategy Engine
        </h1>
        <p className="text-xl text-gray-600 mb-8">
          AI-powered content strategy for TiDB AgentX Hackathon 2025
        </p>
        
        <div className="mb-6 p-4 bg-blue-50 rounded-lg">
          <p className="text-blue-900">
            🚀 <strong>Demo Ready!</strong> API Status: <span className="font-mono">{apiStatus}</span>
          </p>
        </div>
        
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
          <div className="bg-white p-6 rounded-lg shadow">
            <h2 className="text-xl font-semibold mb-2">Content Gap Analysis</h2>
            <p className="text-gray-600 mb-4">AI identifies content opportunities</p>
            <a href="http://localhost:8000/api/v1/analysis/content-gaps-sync?niche=API%20security" 
               target="_blank" 
               className="text-blue-600 hover:underline">
              → Try Demo API
            </a>
          </div>
          
          <div className="bg-white p-6 rounded-lg shadow">
            <h2 className="text-xl font-semibold mb-2">Auto Calendar</h2>
            <p className="text-gray-600 mb-4">Generate 30-day content strategy</p>
            <a href="http://localhost:8000/api/v1/calendar/generate-sync?niche=DevOps&days=7" 
               target="_blank"
               className="text-blue-600 hover:underline">
              → Try Demo API
            </a>
          </div>
          
          <div className="bg-white p-6 rounded-lg shadow">
            <h2 className="text-xl font-semibold mb-2">Dashboard</h2>
            <p className="text-gray-600 mb-4">Performance metrics & automation</p>
            <a href="http://localhost:8000/api/v1/dashboard/overview" 
               target="_blank"
               className="text-blue-600 hover:underline">
              → Try Demo API
            </a>
          </div>
        </div>

        <div className="bg-green-50 p-4 rounded-lg">
          <h3 className="font-semibold text-green-900 mb-2">🏆 Hackathon Features</h3>
          <ul className="text-green-700 space-y-1">
            <li>✅ Multi-step agentic AI workflow</li>
            <li>✅ TiDB Serverless integration ready</li>
            <li>✅ Vector search capabilities</li>
            <li>✅ Real-world automation impact</li>
          </ul>
        </div>
      </div>
    </div>
  )
}
