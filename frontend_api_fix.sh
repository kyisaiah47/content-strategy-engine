#!/bin/bash

# Frontend API Connection Fix
# Ensures frontend connects to Railway backend properly

echo "🔧 Fixing frontend API connection..."

cd frontend

echo "📝 Updating page.tsx to use environment variable..."

cat > src/app/page.tsx << 'EOF'
'use client'

import { useState, useEffect } from 'react'
import { motion } from 'framer-motion'
import { 
  BarChart3, 
  Calendar, 
  TrendingUp, 
  Zap,
  Target,
  Clock,
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
    // Test API connection
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

  const demoData = {
    overview: {
      content_calendar: { planned_this_week: 8, published_this_week: 5, avg_engagement_rate: 0.045 },
      performance: { total_reach_7d: 18500, avg_engagement_rate_7d: 0.045, improvement_vs_last_week: 12.5 },
      automation: { active: true, scheduled_posts: 6, last_briefing: "2025-08-13T09:00:00Z" },
      content_gaps: { opportunities_identified: 8, high_priority: 3, trending_topics: 5 }
    }
  }

  const tabs = [
    { id: 'overview', name: 'Overview', icon: BarChart3 },
    { id: 'gaps', name: 'Content Gaps', icon: Target },
    { id: 'calendar', name: 'Calendar', icon: Calendar },
    { id: 'automation', name: 'Automation', icon: Zap },
  ]

  const statsCards = [
    {
      title: 'Content Planned',
      value: demoData.overview.content_calendar.planned_this_week,
      change: '+12%',
      icon: Calendar,
      color: 'bg-blue-500'
    },
    {
      title: 'Avg Engagement',
      value: `${(demoData.overview.performance.avg_engagement_rate_7d * 100).toFixed(1)}%`,
      change: '+2.5%',
      icon: TrendingUp,
      color: 'bg-green-500'
    },
    {
      title: 'Total Reach',
      value: demoData.overview.performance.total_reach_7d.toLocaleString(),
      change: '+15%',
      icon: Users,
      color: 'bg-purple-500'
    },
    {
      title: 'Opportunities',
      value: demoData.overview.content_gaps.opportunities_identified,
      change: '+3',
      icon: Brain,
      color: 'bg-orange-500'
    }
  ]

  const getStatusColor = () => {
    switch (apiStatus) {
      case 'healthy': return 'text-green-600'
      case 'disconnected': return 'text-red-600'
      case 'error': return 'text-yellow-600'
      default: return 'text-gray-600'
    }
  }

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <header className="bg-white shadow-sm border-b">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between items-center py-4">
            <div>
              <h1 className="text-2xl font-bold text-gray-900">
                Contentr
              </h1>
              <p className="text-sm text-gray-600">
                AI-powered content automation for modern teams
              </p>
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
              <p>API URL: {apiUrl}</p>
            </div>
          </div>
        </div>
      </div>

      {/* Navigation Tabs */}
      <nav className="bg-white border-b">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex space-x-8">
            {tabs.map((tab) => {
              const Icon = tab.icon
              return (
                <button
                  key={tab.id}
                  onClick={() => setActiveTab(tab.id)}
                  className={`flex items-center space-x-2 py-4 px-1 border-b-2 font-medium text-sm ${
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
        </div>
      </nav>

      {/* Main Content */}
      <main className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        {/* API Test Section */}
        <div className="bg-white p-6 rounded-lg shadow mb-8">
          <h3 className="text-lg font-semibold mb-4">🧪 Live API Demo</h3>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <a 
              href={`${apiUrl}/api/v1/analysis/content-gaps-sync?niche=API%20security`}
              target="_blank"
              className="block p-4 border rounded-lg hover:bg-gray-50"
            >
              <h4 className="font-semibold text-blue-600">Content Gap Analysis</h4>
              <p className="text-sm text-gray-600">AI identifies content opportunities</p>
            </a>
            <a 
              href={`${apiUrl}/api/v1/calendar/generate-sync?niche=DevOps&days=7`}
              target="_blank"
              className="block p-4 border rounded-lg hover:bg-gray-50"
            >
              <h4 className="font-semibold text-blue-600">Content Calendar</h4>
              <p className="text-sm text-gray-600">Generate 7-day strategy</p>
            </a>
            <a 
              href={`${apiUrl}/docs`}
              target="_blank"
              className="block p-4 border rounded-lg hover:bg-gray-50"
            >
              <h4 className="font-semibold text-blue-600">API Documentation</h4>
              <p className="text-sm text-gray-600">Interactive FastAPI docs</p>
            </a>
          </div>
        </div>

        {activeTab === 'overview' && (
          <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ duration: 0.5 }}
          >
            {/* Stats Cards */}
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
              {statsCards.map((stat, index) => {
                const Icon = stat.icon
                return (
                  <motion.div
                    key={stat.title}
                    initial={{ opacity: 0, y: 20 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.5, delay: index * 0.1 }}
                    className="bg-white p-6 rounded-lg shadow-sm border"
                  >
                    <div className="flex items-center justify-between">
                      <div>
                        <p className="text-sm font-medium text-gray-600">
                          {stat.title}
                        </p>
                        <p className="text-2xl font-bold text-gray-900">
                          {stat.value}
                        </p>
                        <p className="text-sm text-green-600">
                          {stat.change} from last week
                        </p>
                      </div>
                      <div className={`p-3 rounded-full ${stat.color}`}>
                        <Icon size={24} className="text-white" />
                      </div>
                    </div>
                  </motion.div>
                )
              })}
            </div>

            {/* Workflow Demo */}
            <div className="bg-white p-6 rounded-lg shadow mb-8">
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
          </motion.div>
        )}

        {/* Other tabs content... */}
      </main>

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

echo "✅ Frontend updated with proper API connection!"
echo ""
echo "🚀 Deploy to Vercel:"
echo "vercel --prod"
echo ""
echo "🧪 This should now show 'API: healthy' in the header!"
