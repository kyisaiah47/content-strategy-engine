from datetime import datetime, timedelta
from typing import Dict, Optional
from fastapi import HTTPException
from app.services.billing import PRICING_PLANS, SubscriptionTier

class UsageService:
    def __init__(self):
        self.limits = {
            "free": {"api_calls": 10, "brands": 1, "calendar_generations": 2},
            "starter": {"api_calls": 1000, "brands": 3, "calendar_generations": 50},
            "professional": {"api_calls": 10000, "brands": 10, "calendar_generations": 500},
            "agency": {"api_calls": 100000, "brands": 50, "calendar_generations": 5000}
        }
    
    async def check_usage_limit(self, user_id: int, subscription_tier: str, feature: str):
        current_usage = await self.get_monthly_usage(user_id, feature)
        limit = self.limits[subscription_tier][feature]
        
        if current_usage >= limit:
            raise HTTPException(
                status_code=402,
                detail={
                    "error": "Usage limit exceeded",
                    "message": f"You've reached your {feature} limit of {limit}",
                    "upgrade_url": "/pricing",
                    "current_usage": current_usage,
                    "limit": limit
                }
            )
        
        await self.increment_usage(user_id, feature)
        return True
    
    async def get_monthly_usage(self, user_id: int, feature: str) -> int:
        # Query database for current month usage
        # This would be implemented with your actual database
        return 0
    
    async def increment_usage(self, user_id: int, feature: str):
        # Increment usage counter in database
        pass
    
    async def get_usage_stats(self, user_id: int, subscription_tier: str) -> Dict:
        usage = {}
        limits = self.limits[subscription_tier]
        
        for feature, limit in limits.items():
            current = await self.get_monthly_usage(user_id, feature)
            usage[feature] = {
                "current": current,
                "limit": limit,
                "percentage": round((current / limit) * 100, 1) if limit > 0 else 0
            }
        
        return usage

usage_service = UsageService()
