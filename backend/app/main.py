from fastapi import FastAPI, HTTPException, Depends
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager
import logging

from app.config import settings
from app.database.connection import engine, Base
from app.api.routes import analysis, calendar, automation, dashboard, auth, billing
from app.middleware.usage_limiter import api_call_limiter, calendar_generation_limiter

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

@asynccontextmanager
async def lifespan(app: FastAPI):
    logger.info("Starting up Contentr SaaS...")
    async with engine.begin() as conn:
        await conn.run_sync(Base.metadata.create_all)
    logger.info("Database tables created successfully")
    yield
    logger.info("Shutting down Contentr...")
    await engine.dispose()

app = FastAPI(
    title="Contentr",
    description="AI-powered content automation SaaS for businesses",
    version="2.0.0",
    openapi_url=f"{settings.API_V1_STR}/openapi.json",
    lifespan=lifespan
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000", "https://*.vercel.app", "https://yourdomain.com"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include SaaS routes
app.include_router(auth.router, prefix=f"{settings.API_V1_STR}/auth", tags=["authentication"])
app.include_router(billing.router, prefix=f"{settings.API_V1_STR}/billing", tags=["billing"])

# Include original routes with usage limiting
app.include_router(
    analysis.router,
    prefix=f"{settings.API_V1_STR}/analysis",
    tags=["analysis"],
    dependencies=[Depends(api_call_limiter)]
)

app.include_router(
    calendar.router,
    prefix=f"{settings.API_V1_STR}/calendar",
    tags=["calendar"],
    dependencies=[Depends(calendar_generation_limiter)]
)

app.include_router(automation.router, prefix=f"{settings.API_V1_STR}/automation", tags=["automation"])
app.include_router(dashboard.router, prefix=f"{settings.API_V1_STR}/dashboard", tags=["dashboard"])

@app.get("/")
async def root():
    return {
        "message": "Contentr SaaS",
        "version": "2.0.0",
        "status": "production_ready",
        "features": ["authentication", "billing", "usage_limits", "multi_tenancy"]
    }

@app.get("/health")
async def health_check():
    return {"status": "healthy", "type": "saas"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run("app.main:app", host="0.0.0.0", port=8000, reload=True)
