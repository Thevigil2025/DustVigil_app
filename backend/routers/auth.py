from fastapi import APIRouter

router = APIRouter()

@router.post("/register")
def register_user(email: str, password: str):
    return {"message": f"User {email} registered successfully"}

@router.post("/login")
def login_user(email: str, password: str):
    return {"token": "dummy-jwt-token"}  # Replace with real JWT logic later
