'use client'

import { useState, useEffect } from 'react'
import { BarChart3, Users, Zap, AlertTriangle } from 'lucide-react'

interface UsageData {
  api_calls: { current: number; limit: number; percentage: number }
  brands: { current: number; limit: number; percentage: number }
  calendar_generations: { current: number; limit: number; percentage: number }
}

export default function UsageDashboard() {
  const [usage, setUsage] = useState<UsageData | null>(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    fetchUsage()
  }, [])

  const fetchUsage = async () => {
    try {
      const response = await fetch('/api/v1/billing/usage', {
        headers: {
          'Authorization': `Bearer ${document.cookie.match(/auth_token=([^;]+)/)?.[1]}`
        }
      })
      if (response.ok) {
        const data = await response.json()
        setUsage(data.usage)
      }
    } catch (error) {
      console.error('Failed to fetch usage:', error)
    } finally {
      setLoading(false)
    }
  }

  if (loading) {
    return <div className="animate-pulse bg-gray-200 h-64 rounded-lg"></div>
  }

  const usageItems = [
    {
      name: 'API Calls',
      icon: BarChart3,
      data: usage?.api_calls,
      color: 'blue'
    },
    {
      name: 'Brands',
      icon: Users,
      data: usage?.brands,
      color: 'green'
    },
    {
      name: 'Calendar Generations',
      icon: Zap,
      data: usage?.calendar_generations,
      color: 'purple'
    }
  ]

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h3 className="text-lg font-semibold">Usage Overview</h3>
        <button 
          onClick={fetchUsage}
          className="text-sm text-blue-600 hover:text-blue-800"
        >
          Refresh
        </button>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
        {usageItems.map((item) => {
          const Icon = item.icon
          const isNearLimit = (item.data?.percentage || 0) > 80
          
          return (
            <div key={item.name} className="bg-white p-6 rounded-lg shadow border">
              <div className="flex items-center justify-between mb-4">
                <div className="flex items-center">
                  <Icon className={`h-5 w-5 text-${item.color}-500 mr-2`} />
                  <span className="font-medium">{item.name}</span>
                </div>
                {isNearLimit && (
                  <AlertTriangle className="h-5 w-5 text-yellow-500" />
                )}
              </div>
              
              <div className="space-y-2">
                <div className="flex justify-between text-sm">
                  <span>Used</span>
                  <span>{item.data?.current || 0} of {item.data?.limit || 0}</span>
                </div>
                
                <div className="w-full bg-gray-200 rounded-full h-2">
                  <div 
                    className={`h-2 rounded-full ${
                      isNearLimit ? 'bg-yellow-500' : `bg-${item.color}-500`
                    }`}
                    style={{ width: `${Math.min(item.data?.percentage || 0, 100)}%` }}
                  ></div>
                </div>
                
                <div className="text-xs text-gray-500">
                  {item.data?.percentage || 0}% used this month
                </div>
              </div>
              
              {isNearLimit && (
                <div className="mt-4 p-2 bg-yellow-50 rounded border border-yellow-200">
                  <p className="text-xs text-yellow-800">
                    You're approaching your limit. Consider upgrading your plan.
                  </p>
                </div>
              )}
            </div>
          )
        })}
      </div>
    </div>
  )
}
