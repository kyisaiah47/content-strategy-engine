#!/bin/bash

# Simple Frontend Fix - No Framer Motion
# Removes dependencies that might cause build issues

echo "🔧 Creating simple frontend without framer-motion..."

cd frontend

echo "📝 Creating build-friendly page.tsx..."

cat > src/app/page.tsx << 'EOF'
'use client'

import { useState, useEffect } from 'react'
import { 
  BarChart3, 
  Calendar, 
  TrendingUp, 
  Zap,
  Target,
  Users,
  Brain,
  CheckCircle,
  ArrowRight
} from 'lucide-react'

export default function Dashboard() {
  const [activeTab, setActiveTab] = useState('overview')
  const [apiStatus, setApiStatus] = useState('checking...')
  const [apiUrl] = useState(process.env.NEXT_PUBLIC_API_URL || 'https://contentr-production.up.railway.app')

  useEffect(() => {
    const testConnection = async () => {
      try {
        console.log('Testing API connection to:', apiUrl)
        const response = await fetch(`${apiUrl}/health`)
        if (response.ok) {
          const data = await response.json()
          setApiStatus('healthy')
          console.log('API connection successful:', data)
        } else {
          setApiStatus('error')
          console.error('API response not ok:', response.status)
        }
      } catch (error) {
        setApiStatus('disconnected')
        console.error('API connection failed:', error)
      }
    }
    
    testConnection()
  }, [apiUrl])

  const getStatusColor = () => {
    switch (apiStatus) {
      case 'healthy': return 'text-green-600'
      case 'disconnected': return 'text-red-600'
      case 'error': return 'text-yellow-600'
      default: return 'text-gray-600'
    }
  }

  const statsCards = [
    { title: 'Content Planned', value: '8', change: '+12%', icon: Calendar, color: 'bg-blue-500' },
    { title: 'Avg Engagement', value: '4.5%', change: '+2.5%', icon: TrendingUp, color: 'bg-green-500' },
    { title: 'Total Reach', value: '18,500', change: '+15%', icon: Users, color: 'bg-purple-500' },
    { title: 'Opportunities', value: '8', change: '+3', icon: Brain, color: 'bg-orange-500' }
  ]

  const tabs = [
    { id: 'overview', name: 'Overview', icon: BarChart3 },
    { id: 'gaps', name: 'Content Gaps', icon: Target },
    { id: 'calendar', name: 'Calendar', icon: Calendar },
    { id: 'automation', name: 'Automation', icon: Zap },
  ]

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <header className="bg-white shadow-sm border-b">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between items-center py-4">
            <div>
              <h1 className="text-2xl font-bold text-gray-900">Contentr</h1>
              <p className="text-sm text-gray-600">AI-powered content automation</p>
            </div>
            <div className="flex items-center space-x-4">
              <div className="flex items-center space-x-1 px-3 py-1 bg-blue-100 text-blue-800 rounded-full text-sm">
                <div className={`w-2 h-2 rounded-full ${apiStatus === 'healthy' ? 'bg-green-500' : 'bg-red-500'}`}></div>
                <span>API: <span className={getStatusColor()}>{apiStatus}</span></span>
              </div>
              <button className="bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700">
                Start Free Trial
              </button>
            </div>
          </div>
        </div>
      </header>

      {/* Hero Banner */}
      <div className="bg-gradient-to-r from-blue-600 to-purple-600 text-white py-8">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="text-center">
            <h2 className="text-3xl font-bold mb-2">🏆 TiDB AgentX Hackathon 2025 Demo</h2>
            <p className="text-xl opacity-90">Agentic AI that automates your entire content strategy</p>
            <div className="mt-4 flex justify-center space-x-6 text-sm">
              <div className="flex items-center">
                <CheckCircle className="w-4 h-4 mr-1" />
                <span>Multi-step AI workflow</span>
              </div>
              <div className="flex items-center">
                <CheckCircle className="w-4 h-4 mr-1" />
                <span>TiDB vector search</span>
              </div>
              <div className="flex items-center">
                <CheckCircle className="w-4 h-4 mr-1" />
                <span>Real-world automation</span>
              </div>
            </div>
            <div className="mt-4 text-sm opacity-75">
              <p>Backend API: {apiUrl}</p>
            </div>
          </div>
        </div>
      </div>

      {/* API Test Section */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div className="bg-white p-6 rounded-lg shadow mb-8">
          <h3 className="text-lg font-semibold mb-4">🧪 Live API Demo</h3>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <a 
              href={`${apiUrl}/api/v1/analysis/content-gaps-sync?niche=API%20security`}
              target="_blank"
              rel="noopener noreferrer"
              className="block p-4 border rounded-lg hover:bg-gray-50 transition-colors"
            >
              <h4 className="font-semibold text-blue-600">Content Gap Analysis</h4>
              <p className="text-sm text-gray-600">AI identifies content opportunities</p>
              <p className="text-xs text-gray-400 mt-1">Click to test API →</p>
            </a>
            <a 
              href={`${apiUrl}/api/v1/calendar/generate-sync?niche=DevOps&days=7`}
              target="_blank"
              rel="noopener noreferrer"
              className="block p-4 border rounded-lg hover:bg-gray-50 transition-colors"
            >
              <h4 className="font-semibold text-blue-600">Content Calendar</h4>
              <p className="text-sm text-gray-600">Generate 7-day strategy</p>
              <p className="text-xs text-gray-400 mt-1">Click to test API →</p>
            </a>
            <a 
              href={`${apiUrl}/docs`}
              target="_blank"
              rel="noopener noreferrer"
              className="block p-4 border rounded-lg hover:bg-gray-50 transition-colors"
            >
              <h4 className="font-semibold text-blue-600">API Documentation</h4>
              <p className="text-sm text-gray-600">Interactive FastAPI docs</p>
              <p className="text-xs text-gray-400 mt-1">Click to view docs →</p>
            </a>
          </div>
        </div>

        {/* Navigation Tabs */}
        <nav className="bg-white border-b rounded-lg mb-8">
          <div className="flex space-x-8 px-6">
            {tabs.map((tab) => {
              const Icon = tab.icon
              return (
                <button
                  key={tab.id}
                  onClick={() => setActiveTab(tab.id)}
                  className={`flex items-center space-x-2 py-4 px-1 border-b-2 font-medium text-sm transition-colors ${
                    activeTab === tab.id
                      ? 'border-blue-500 text-blue-600'
                      : 'border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300'
                  }`}
                >
                  <Icon size={16} />
                  <span>{tab.name}</span>
                </button>
              )
            })}
          </div>
        </nav>

        {/* Content Area */}
        {activeTab === 'overview' && (
          <div>
            {/* Stats Cards */}
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
              {statsCards.map((stat) => {
                const Icon = stat.icon
                return (
                  <div key={stat.title} className="bg-white p-6 rounded-lg shadow-sm border">
                    <div className="flex items-center justify-between">
                      <div>
                        <p className="text-sm font-medium text-gray-600">{stat.title}</p>
                        <p className="text-2xl font-bold text-gray-900">{stat.value}</p>
                        <p className="text-sm text-green-600">{stat.change} from last week</p>
                      </div>
                      <div className={`p-3 rounded-full ${stat.color}`}>
                        <Icon size={24} className="text-white" />
                      </div>
                    </div>
                  </div>
                )
              })}
            </div>

            {/* Agentic Workflow */}
            <div className="bg-white p-6 rounded-lg shadow">
              <h3 className="text-lg font-semibold mb-4">🧠 Agentic AI Workflow</h3>
              <div className="grid grid-cols-2 md:grid-cols-6 gap-4">
                {[
                  "1. Data Ingestion",
                  "2. Vector Search", 
                  "3. AI Analysis",
                  "4. Strategy Generation",
                  "5. Auto Execution",
                  "6. Performance Optimization"
                ].map((step, index) => (
                  <div key={step} className="text-center">
                    <div className="bg-blue-100 p-4 rounded-lg mb-2">
                      <div className="text-blue-600 font-semibold text-sm">{step}</div>
                    </div>
                    {index < 5 && <ArrowRight className="mx-auto text-gray-400" size={16} />}
                  </div>
                ))}
              </div>
            </div>
          </div>
        )}

        {activeTab === 'gaps' && (
          <div className="bg-white p-6 rounded-lg shadow">
            <h3 className="text-lg font-semibold mb-4">🎯 Content Gap Analysis</h3>
            <p className="text-gray-600 mb-4">AI-powered competitor analysis reveals high-opportunity content topics.</p>
            <a 
              href={`${apiUrl}/api/v1/analysis/content-gaps-sync?niche=B2B%20SaaS`}
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex items-center px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
            >
              Test Content Gap Analysis API
              <ArrowRight className="ml-2" size={16} />
            </a>
          </div>
        )}

        {activeTab === 'calendar' && (
          <div className="bg-white p-6 rounded-lg shadow">
            <h3 className="text-lg font-semibold mb-4">📅 AI-Generated Content Calendar</h3>
            <p className="text-gray-600 mb-4">Automated 30-day content strategy with performance predictions.</p>
            <a 
              href={`${apiUrl}/api/v1/calendar/generate-sync?niche=DevOps&days=30`}
              target="_blank"
              rel="noopener noreferrer"
              className="inline-flex items-center px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700"
            >
              Generate 30-Day Calendar
              <ArrowRight className="ml-2" size={16} />
            </a>
          </div>
        )}

        {activeTab === 'automation' && (
          <div className="bg-white p-6 rounded-lg shadow">
            <h3 className="text-lg font-semibold mb-4">⚡ Automation Dashboard</h3>
            <p className="text-gray-600 mb-4">End-to-end workflow automation with real-time monitoring.</p>
            <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
              <div className="text-center p-4 bg-green-50 rounded-lg">
                <CheckCircle className="mx-auto text-green-500 mb-2" size={32} />
                <h4 className="font-semibold">6 Posts Scheduled</h4>
                <p className="text-sm text-gray-600">Next: Today at 9:00 AM</p>
              </div>
              
              <div className="text-center p-4 bg-blue-50 rounded-lg">
                <BarChart3 className="mx-auto text-blue-500 mb-2" size={32} />
                <h4 className="font-semibold">18.5K Projected Reach</h4>
                <p className="text-sm text-gray-600">This week's content</p>
              </div>
              
              <div className="text-center p-4 bg-purple-50 rounded-lg">
                <Zap className="mx-auto text-purple-500 mb-2" size={32} />
                <h4 className="font-semibold">15 Hours Saved</h4>
                <p className="text-sm text-gray-600">This month</p>
              </div>
            </div>
          </div>
        )}
      </div>

      {/* Footer */}
      <footer className="bg-gray-900 text-white py-8 mt-12">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <h3 className="text-xl font-bold mb-2">🏆 Built for TiDB AgentX Hackathon 2025</h3>
          <p className="text-gray-400">Contentr: Agentic AI for Real-World Content Automation</p>
          <div className="mt-4 space-x-6 text-sm">
            <span>✅ Multi-step AI workflow</span>
            <span>✅ TiDB Serverless integration</span>
            <span>✅ Production-ready SaaS</span>
          </div>
        </div>
      </footer>
    </div>
  )
}
EOF

echo "✅ Simple frontend created (no framer-motion dependency)!"
echo ""
echo "🚀 Deploy to Vercel:"
echo "vercel --prod"
