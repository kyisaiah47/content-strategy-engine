from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI(
    title="Contentr",
    description="AI-powered content automation for TiDB Hackathon 2025",
    version="1.0.0"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/")
async def root():
    return {
        "message": "Contentr API",
        "status": "running",
        "hackathon": "TiDB AgentX 2025"
    }

@app.get("/health")
async def health():
    return {"status": "healthy"}

# Demo endpoints
@app.get("/api/v1/analysis/content-gaps-sync")
async def demo_content_gaps(niche: str = "B2B SaaS"):
    return {
        "status": "completed",
        "niche": niche,
        "analysis": {
            "content_gaps": [
                {
                    "topic": "API Security Best Practices",
                    "opportunity_score": 0.92,
                    "reasoning": "High competitor coverage, zero your coverage"
                }
            ],
            "trending_themes": ["AI in DevOps", "Cloud Cost Optimization"],
            "recommendations": [
                "Create API security content series",
                "Focus on cloud optimization topics"
            ]
        }
    }

@app.get("/api/v1/calendar/generate-sync") 
async def demo_calendar(niche: str = "DevOps", days: int = 7):
    return {
        "status": "completed",
        "calendar": {
            "calendar": [
                {
                    "day": 1,
                    "date": "2025-08-14", 
                    "platform": "linkedin",
                    "topic": "API Security Checklist",
                    "content_brief": "Share 8 essential API security practices...",
                    "predicted_engagement": 0.045
                }
            ]
        }
    }

@app.get("/api/v1/dashboard/overview")
async def demo_dashboard():
    return {
        "overview": {
            "content_calendar": {"planned_this_week": 8},
            "performance": {"avg_engagement_rate_7d": 0.045, "total_reach_7d": 18500},
            "automation": {"active": True, "scheduled_posts": 6},
            "content_gaps": {"opportunities_identified": 8}
        }
    }
