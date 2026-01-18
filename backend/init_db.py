from database import engine, Base
from models import *

print("📦 Creating database tables...")
Base.metadata.create_all(bind=engine)
print("✅ All tables created successfully.")
