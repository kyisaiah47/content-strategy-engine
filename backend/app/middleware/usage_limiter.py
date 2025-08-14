from fastapi import HTTPException, Depends
from app.services.auth import get_current_user
from app.services.usage import usage_service

class UsageLimiter:
    def __init__(self, feature: str):
        self.feature = feature
    
    async def __call__(self, current_user = Depends(get_current_user)):
        await usage_service.check_usage_limit(
            current_user.id,
            current_user.subscription_tier,
            self.feature
        )
        return current_user

# Usage limiters for different features
api_call_limiter = UsageLimiter("api_calls")
calendar_generation_limiter = UsageLimiter("calendar_generations")
brand_limiter = UsageLimiter("brands")
