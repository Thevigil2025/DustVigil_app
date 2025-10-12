from fastapi import FastAPI
from routers import auth, data, control, ai

app = FastAPI()

app.include_router(auth.router, prefix="/auth", tags=["Auth"])
app.include_router(data.router, prefix="/data", tags=["Data"])
app.include_router(control.router, prefix="/control", tags=["Control"])
app.include_router(ai.router, prefix="/ai", tags=["AI"])

@app.get("/")
def home():
    return {"message": "Welcome to DustVigil API"}
