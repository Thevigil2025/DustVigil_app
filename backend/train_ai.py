import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
import joblib
from pathlib import Path
import os

BASE_DIR = Path(__file__).resolve().parent  # backend/
DATA_PATH = BASE_DIR / "dust_data.csv"
MODEL_DIR = BASE_DIR / "models"
MODEL_PATH = MODEL_DIR / "dust_model.pkl"

if not DATA_PATH.exists():
    raise FileNotFoundError(f"CSV not found at {DATA_PATH}")

data = pd.read_csv(DATA_PATH)

X = data[["pm25", "co2", "battery"]]
y = data["dust_risk"]

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

accuracy = model.score(X_test, y_test)
print(f"Model trained with accuracy: {accuracy * 100:.2f}%")

MODEL_DIR.mkdir(parents=True, exist_ok=True)
joblib.dump(model, MODEL_PATH)
print(f"✅ Model saved to {MODEL_PATH}")
