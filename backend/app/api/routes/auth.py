from datetime import timedelta
from fastapi import APIRouter, HTTPException, Depends, status
from fastapi.security import OAuth2PasswordRequestForm
from app.services.auth import AuthService, UserCreate, UserLogin, Token
from app.services.billing import billing_service

router = APIRouter()
auth_service = AuthService()

@router.post("/register", response_model=dict)
async def register(user: UserCreate):
    # Check if user already exists
    existing_user = await auth_service.get_user_by_email(user.email)
    if existing_user:
        raise HTTPException(
            status_code=400,
            detail="Email already registered"
        )
    
    # Hash password
    hashed_password = auth_service.get_password_hash(user.password)
    
    # Create user in database
    # db_user = await create_user_in_db(user.email, hashed_password, user.name)
    
    # Create Stripe customer
    stripe_result = await billing_service.create_customer(user.email, user.name)
    
    # Create access token
    access_token_expires = timedelta(minutes=30)
    access_token = auth_service.create_access_token(
        data={"sub": str("user_id")}, expires_delta=access_token_expires
    )
    
    return {
        "access_token": access_token,
        "token_type": "bearer",
        "user": {
            "email": user.email,
            "name": user.name,
            "subscription_tier": "free"
        }
    }

@router.post("/login", response_model=Token)
async def login(user_credentials: UserLogin):
    # Authenticate user
    user = await auth_service.get_user_by_email(user_credentials.email)
    if not user or not auth_service.verify_password(user_credentials.password, user.password_hash):
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect email or password"
        )
    
    # Create access token
    access_token_expires = timedelta(minutes=30)
    access_token = auth_service.create_access_token(
        data={"sub": str(user.id)}, expires_delta=access_token_expires
    )
    
    return {
        "access_token": access_token,
        "token_type": "bearer",
        "user": {
            "id": user.id,
            "email": user.email,
            "name": user.name,
            "subscription_tier": user.subscription_tier
        }
    }

@router.get("/me")
async def get_current_user_info(current_user = Depends(auth_service.get_current_user)):
    return {
        "id": current_user.id,
        "email": current_user.email,
        "name": current_user.name,
        "subscription_tier": current_user.subscription_tier,
        "created_at": current_user.created_at
    }
