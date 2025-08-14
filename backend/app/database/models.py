
# SaaS Models
class User(Base):
    __tablename__ = "users"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    email = Column(String(255), unique=True, nullable=False)
    password_hash = Column(String(255), nullable=False)
    name = Column(String(255), nullable=False)
    subscription_tier = Column(String(50), default="free")
    stripe_customer_id = Column(String(255))
    trial_ends_at = Column(DateTime)
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime, default=func.now())
    updated_at = Column(DateTime, default=func.now(), onupdate=func.now())
    
    # Relationships
    brands = relationship("Brand", back_populates="user")
    usage_records = relationship("UsageRecord", back_populates="user")

class Brand(Base):
    __tablename__ = "brands"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    name = Column(String(100), nullable=False)
    industry = Column(String(100))
    target_audience = Column(JSON)
    connected_platforms = Column(JSON)
    settings = Column(JSON)
    is_active = Column(Boolean, default=True)
    created_at = Column(DateTime, default=func.now())
    
    user = relationship("User", back_populates="brands")

class UsageRecord(Base):
    __tablename__ = "usage_records"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    feature = Column(String(100), nullable=False)  # api_calls, calendar_generations, etc.
    count = Column(Integer, default=1)
    metadata = Column(JSON)
    created_at = Column(DateTime, default=func.now())
    
    user = relationship("User", back_populates="usage_records")
    
    __table_args__ = (
        Index('idx_user_feature_date', 'user_id', 'feature', 'created_at'),
    )

class Subscription(Base):
    __tablename__ = "subscriptions"
    
    id = Column(Integer, primary_key=True, autoincrement=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    stripe_subscription_id = Column(String(255))
    plan = Column(String(50), nullable=False)
    status = Column(String(50), nullable=False)  # active, canceled, past_due
    current_period_start = Column(DateTime)
    current_period_end = Column(DateTime)
    created_at = Column(DateTime, default=func.now())
    updated_at = Column(DateTime, default=func.now(), onupdate=func.now())
