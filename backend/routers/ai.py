from fastapi import APIRouter
import joblib
import os

router = APIRouter()

MODEL_PATH = "models/dust_model.pkl"

# Load model only once when API starts
if os.path.exists(MODEL_PATH):
    model = joblib.load(MODEL_PATH)
else:
    model = None

@router.post("/ai/predict-dust-risk")
def predict_dust_risk(pm25: float, co2: float, battery: float):
    if not model:
        return {"error": "Model not trained yet"}
    prediction = model.predict([[pm25, co2, battery]])[0]
    return {"risk_level": prediction}
