import stripe
from enum import Enum
from typing import Dict, Any
from app.config import settings

stripe.api_key = settings.STRIPE_SECRET_KEY

class SubscriptionTier(Enum):
    FREE = "free"
    STARTER = "starter"  # $29/month
    PRO = "professional"  # $99/month
    AGENCY = "agency"    # $299/month

PRICING_PLANS = {
    "starter": {
        "stripe_price_id": "price_starter_monthly",
        "amount": 29,
        "currency": "usd",
        "brands_limit": 3,
        "api_calls_limit": 1000,
        "features": ["basic_automation", "content_calendar", "analytics"]
    },
    "professional": {
        "stripe_price_id": "price_pro_monthly",
        "amount": 99,
        "currency": "usd", 
        "brands_limit": 10,
        "api_calls_limit": 10000,
        "features": ["advanced_ai", "competitor_analysis", "white_label", "api_access"]
    },
    "agency": {
        "stripe_price_id": "price_agency_monthly",
        "amount": 299,
        "currency": "usd",
        "brands_limit": 50,
        "api_calls_limit": 100000,
        "features": ["client_management", "custom_workflows", "priority_support"]
    }
}

class BillingService:
    def __init__(self):
        self.stripe = stripe
    
    async def create_customer(self, email: str, name: str) -> Dict[str, Any]:
        try:
            customer = self.stripe.Customer.create(
                email=email,
                name=name
            )
            return {"success": True, "customer_id": customer.id}
        except stripe.error.StripeError as e:
            return {"success": False, "error": str(e)}
    
    async def create_checkout_session(self, customer_id: str, plan: str, success_url: str, cancel_url: str):
        try:
            session = self.stripe.checkout.Session.create(
                customer=customer_id,
                payment_method_types=['card'],
                line_items=[{
                    'price': PRICING_PLANS[plan]["stripe_price_id"],
                    'quantity': 1,
                }],
                mode='subscription',
                success_url=success_url,
                cancel_url=cancel_url,
                trial_period_days=14,
            )
            return {"success": True, "checkout_url": session.url}
        except stripe.error.StripeError as e:
            return {"success": False, "error": str(e)}
    
    async def handle_webhook(self, payload: str, sig_header: str):
        try:
            event = self.stripe.Webhook.construct_event(
                payload, sig_header, settings.STRIPE_WEBHOOK_SECRET
            )
            
            if event['type'] == 'checkout.session.completed':
                await self._handle_successful_subscription(event['data']['object'])
            elif event['type'] == 'invoice.payment_failed':
                await self._handle_failed_payment(event['data']['object'])
            elif event['type'] == 'customer.subscription.deleted':
                await self._handle_cancelled_subscription(event['data']['object'])
                
            return {"success": True}
        except ValueError as e:
            return {"success": False, "error": "Invalid payload"}
        except stripe.error.SignatureVerificationError as e:
            return {"success": False, "error": "Invalid signature"}
    
    async def _handle_successful_subscription(self, session):
        # Update user subscription in database
        pass
    
    async def _handle_failed_payment(self, invoice):
        # Handle failed payment (email user, suspend account, etc.)
        pass
    
    async def _handle_cancelled_subscription(self, subscription):
        # Handle subscription cancellation
        pass

billing_service = BillingService()
