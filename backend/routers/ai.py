from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from pathlib import Path
import joblib
import os

router = APIRouter()

# Resolve model path relative to this file
BASE_DIR = Path(__file__).resolve().parent.parent  # points to backend/
MODEL_PATH = BASE_DIR / "models" / "dust_model.pkl"

# Load model once at import/startup
_model = None
if MODEL_PATH.exists():
    try:
        _model = joblib.load(MODEL_PATH)
    except Exception as e:
        # keep service up even if model fails to load
        _model = None
        print(f"Failed to load model: {e}")
else:
    print(f"Model not found at {MODEL_PATH}")

class PredictRequest(BaseModel):
    pm25: float
    co2: float
    battery: float

class PredictResponse(BaseModel):
    risk_level: str

@router.post("/predict-dust-risk", response_model=PredictResponse)
def predict_dust_risk(payload: PredictRequest):
    global _model
    if _model is None:
        raise HTTPException(status_code=503, detail="Model not available. Train model or check path.")
    try:
        pred = _model.predict([[payload.pm25, payload.co2, payload.battery]])[0]
        return {"risk_level": str(pred)}
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Prediction error: {e}")
