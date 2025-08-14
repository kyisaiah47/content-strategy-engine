'use client'

import { useState } from 'react'
import { Check } from 'lucide-react'

const plans = [
  {
    name: "Starter",
    price: 29,
    description: "Perfect for small businesses",
    features: [
      "3 brands",
      "1,000 API calls/month",
      "Basic AI analysis",
      "Content calendar",
      "Email support"
    ],
    cta: "Start Free Trial",
    popular: false
  },
  {
    name: "Professional",
    price: 99,
    description: "For growing marketing teams",
    features: [
      "10 brands",
      "10,000 API calls/month",
      "Advanced AI insights",
      "Competitor analysis",
      "Priority support",
      "API access"
    ],
    cta: "Start Free Trial",
    popular: true
  },
  {
    name: "Agency",
    price: 299,
    description: "For agencies and enterprises",
    features: [
      "50 brands",
      "100,000 API calls/month",
      "White-label dashboard",
      "Client management",
      "Custom integrations",
      "Dedicated support"
    ],
    cta: "Contact Sales",
    popular: false
  }
]

export default function Pricing() {
  const [isAnnual, setIsAnnual] = useState(false)

  const handleSubscribe = async (planName: string) => {
    try {
      const response = await fetch('/api/v1/billing/checkout', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${document.cookie.match(/auth_token=([^;]+)/)?.[1]}`
        },
        body: JSON.stringify({ plan: planName.toLowerCase() })
      })
      
      if (response.ok) {
        const data = await response.json()
        window.location.href = data.checkout_url
      }
    } catch (error) {
      console.error('Failed to create checkout session:', error)
    }
  }

  return (
    <div className="py-12">
      <div className="text-center mb-12">
        <h2 className="text-3xl font-bold text-gray-900 mb-4">
          Choose Your Plan
        </h2>
        <p className="text-xl text-gray-600">
          Start with a 14-day free trial. No credit card required.
        </p>
        
        <div className="flex items-center justify-center mt-6">
          <span className="text-sm">Monthly</span>
          <button
            onClick={() => setIsAnnual(!isAnnual)}
            className="mx-3 relative inline-flex h-6 w-11 items-center rounded-full bg-gray-200 transition-colors focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2"
          >
            <span className={`inline-block h-4 w-4 transform rounded-full bg-white transition-transform ${isAnnual ? 'translate-x-6' : 'translate-x-1'}`} />
          </button>
          <span className="text-sm">Annual (Save 20%)</span>
        </div>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-8 max-w-6xl mx-auto">
        {plans.map((plan) => (
          <div
            key={plan.name}
            className={`relative bg-white rounded-2xl shadow-lg ${plan.popular ? 'ring-2 ring-blue-500' : ''}`}
          >
            {plan.popular && (
              <div className="absolute -top-4 left-1/2 transform -translate-x-1/2">
                <span className="bg-blue-500 text-white px-4 py-1 rounded-full text-sm font-medium">
                  Most Popular
                </span>
              </div>
            )}
            
            <div className="p-8">
              <h3 className="text-xl font-semibold text-gray-900">{plan.name}</h3>
              <p className="text-gray-600 mt-2">{plan.description}</p>
              
              <div className="mt-6">
                <span className="text-4xl font-bold text-gray-900">
                  ${isAnnual ? Math.round(plan.price * 0.8) : plan.price}
                </span>
                <span className="text-gray-600">/month</span>
              </div>
              
              <button
                onClick={() => handleSubscribe(plan.name)}
                className={`w-full mt-8 py-3 px-4 rounded-lg font-medium ${
                  plan.popular
                    ? 'bg-blue-600 text-white hover:bg-blue-700'
                    : 'bg-gray-100 text-gray-900 hover:bg-gray-200'
                }`}
              >
                {plan.cta}
              </button>
              
              <ul className="mt-8 space-y-3">
                {plan.features.map((feature) => (
                  <li key={feature} className="flex items-center">
                    <Check className="h-5 w-5 text-green-500 mr-3" />
                    <span className="text-gray-700">{feature}</span>
                  </li>
                ))}
              </ul>
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}
