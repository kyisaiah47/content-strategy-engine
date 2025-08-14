from fastapi import APIRouter, HTTPException, Depends, Request
from app.services.auth import get_current_user
from app.services.billing import billing_service, PRICING_PLANS
from app.services.usage import usage_service

router = APIRouter()

@router.get("/plans")
async def get_pricing_plans():
    return {
        "plans": PRICING_PLANS,
        "success": True
    }

@router.post("/checkout")
async def create_checkout_session(
    plan: str,
    current_user = Depends(get_current_user)
):
    if plan not in PRICING_PLANS:
        raise HTTPException(status_code=400, detail="Invalid plan")
    
    result = await billing_service.create_checkout_session(
        customer_id=current_user.stripe_customer_id,
        plan=plan,
        success_url="https://yourapp.com/success",
        cancel_url="https://yourapp.com/pricing"
    )
    
    if not result["success"]:
        raise HTTPException(status_code=400, detail=result["error"])
    
    return {"checkout_url": result["checkout_url"]}

@router.get("/usage")
async def get_usage_stats(current_user = Depends(get_current_user)):
    usage = await usage_service.get_usage_stats(
        current_user.id, 
        current_user.subscription_tier
    )
    return {"usage": usage, "success": True}

@router.post("/webhook")
async def handle_stripe_webhook(request: Request):
    payload = await request.body()
    sig_header = request.headers.get('stripe-signature')
    
    result = await billing_service.handle_webhook(payload, sig_header)
    
    if not result["success"]:
        raise HTTPException(status_code=400, detail=result["error"])
    
    return {"success": True}
