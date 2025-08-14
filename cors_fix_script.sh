#!/bin/bash

# CORS Fix Script
# Fixes frontend-backend connection issues

echo "🔧 Fixing CORS for frontend connection..."

cd backend

echo "📝 Updating CORS settings in main.py..."

cat > app/main.py << 'EOF'
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
import os
import logging

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI(
    title="Contentr API",
    description="AI-powered content automation",
    version="2.0.0"
)

# Enhanced CORS middleware for frontend connection
app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:3000",
        "https://contentr-one.vercel.app",
        "https://*.vercel.app",
        "*"  # Allow all for demo purposes
    ],
    allow_credentials=True,
    allow_methods=["GET", "POST", "PUT", "DELETE", "OPTIONS"],
    allow_headers=["*"],
)

@app.on_event("startup")
async def startup_event():
    logger.info("🚀 Contentr API starting up...")
    logger.info(f"Port: {os.environ.get('PORT', 'not set')}")

@app.get("/")
async def root():
    return {
        "message": "Contentr API",
        "status": "running",
        "version": "2.0.0",
        "hackathon": "TiDB AgentX 2025",
        "cors": "enabled"
    }

@app.get("/health")
async def health():
    return {
        "status": "healthy",
        "service": "contentr-api",
        "port": os.environ.get("PORT", "unknown"),
        "cors": "enabled"
    }

# Test endpoint for frontend connection
@app.get("/api/test")
async def test_connection():
    return {
        "status": "success",
        "message": "Frontend-backend connection working!",
        "timestamp": "2025-08-13T12:00:00Z"
    }

@app.get("/api/v1/analysis/content-gaps-sync")
async def content_gaps(niche: str = "B2B SaaS"):
    """Demo content gap analysis"""
    return {
        "status": "completed",
        "niche": niche,
        "analysis": {
            "content_gaps": [
                {
                    "topic": "API Security Best Practices",
                    "opportunity_score": 0.92,
                    "reasoning": "High competitor coverage, zero your coverage",
                    "suggested_angle": "Developer-focused security checklist"
                },
                {
                    "topic": "Cloud Cost Optimization",
                    "opportunity_score": 0.87,
                    "reasoning": "Trending topic with high engagement potential",
                    "suggested_angle": "Real case study with specific savings"
                },
                {
                    "topic": "Kubernetes Security Hardening",
                    "opportunity_score": 0.84,
                    "reasoning": "Enterprise focus with growing demand",
                    "suggested_angle": "Production deployment checklist"
                }
            ],
            "trending_themes": ["AI in DevOps", "Cloud Security", "Cost Optimization"],
            "recommendations": [
                "Create API security content series",
                "Focus on practical cloud optimization tips",
                "Target enterprise Kubernetes users"
            ],
            "quantitative_insights": {
                "your_avg_engagement": 0.032,
                "competitor_avg_engagement": 0.058,
                "engagement_gap": 0.026,
                "trending_topics_count": 8
            }
        }
    }

@app.get("/api/v1/calendar/generate-sync")
async def content_calendar(niche: str = "DevOps", days: int = 7):
    """Demo content calendar generation"""
    return {
        "status": "completed",
        "niche": niche,
        "days": days,
        "calendar": {
            "calendar": [
                {
                    "day": 1,
                    "date": "2025-08-14",
                    "platform": "linkedin",
                    "topic": "API Security Checklist",
                    "content_brief": "Share 8 essential API security practices that prevented breaches in production. Include real examples from major companies and actionable implementation steps.",
                    "predicted_engagement": 0.045,
                    "optimal_time": "09:00",
                    "target_audience": "senior developers",
                    "hashtags": ["#APISecurity", "#DevOps", "#CyberSecurity"]
                },
                {
                    "day": 2,
                    "date": "2025-08-15",
                    "platform": "twitter",
                    "topic": "Docker Optimization Tips",
                    "content_brief": "Thread: 5 Docker optimization techniques that reduced our image sizes by 80%. Include before/after metrics and specific commands.",
                    "predicted_engagement": 0.038,
                    "optimal_time": "14:30",
                    "target_audience": "DevOps engineers",
                    "hashtags": ["#Docker", "#DevOps", "#Optimization"]
                },
                {
                    "day": 3,
                    "date": "2025-08-16",
                    "platform": "linkedin",
                    "topic": "Cloud Cost Case Study",
                    "content_brief": "Deep dive: How we reduced AWS costs by 40% using these 6 strategies. Include specific tools, timelines, and ROI calculations.",
                    "predicted_engagement": 0.052,
                    "optimal_time": "10:00",
                    "target_audience": "engineering managers",
                    "hashtags": ["#CloudCosts", "#AWS", "#FinOps"]
                }
            ],
            "weekly_themes": {
                "week1": "Security & Performance Optimization"
            },
            "content_mix": {
                "educational": 60,
                "promotional": 20,
                "engaging": 20
            },
            "success_metrics": {
                "target_engagement_rate": 0.045,
                "target_reach": 15000,
                "content_goals": ["thought leadership", "lead generation"]
            }
        }
    }

@app.get("/api/v1/dashboard/overview")
async def dashboard():
    """Demo dashboard data"""
    return {
        "status": "success",
        "overview": {
            "content_calendar": {
                "planned_this_week": 8,
                "published_this_week": 5,
                "avg_engagement_rate": 0.045,
                "next_post": "2025-08-14T09:00:00Z"
            },
            "performance": {
                "total_reach_7d": 18500,
                "total_engagement_7d": 825,
                "avg_engagement_rate_7d": 0.045,
                "improvement_vs_last_week": 12.5,
                "trending_up": True
            },
            "automation": {
                "active": True,
                "scheduled_posts": 6,
                "auto_optimizations": 3,
                "last_briefing": "2025-08-13T09:00:00Z"
            },
            "content_gaps": {
                "opportunities_identified": 8,
                "high_priority": 3,
                "trending_topics": 5,
                "last_analysis": "2025-08-13T08:00:00Z"
            }
        }
    }

# For Railway deployment
if __name__ == "__main__":
    import uvicorn
    port = int(os.environ.get("PORT", 8000))
    logger.info(f"Starting server on port {port}")
    uvicorn.run(app, host="0.0.0.0", port=port)
EOF

echo "✅ CORS settings updated!"
echo ""
echo "🚀 Push the changes:"
echo "git add ."
echo "git commit -m 'Fix CORS for frontend connection'"
echo "git push origin main"
echo ""
echo "🔧 Then in Vercel:"
echo "1. Make sure NEXT_PUBLIC_API_URL = https://contentr-production.up.railway.app"
echo "2. Redeploy the frontend"
echo ""
echo "🧪 Test the connection:"
echo "curl https://contentr-production.up.railway.app/api/test"
