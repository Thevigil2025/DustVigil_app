import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
import joblib
import os

# Load dummy dataset (later replace with DB or IoT logs)
data = pd.read_csv("dust_data.csv")

X = data[["pm25", "co2", "battery"]]
y = data["dust_risk"]

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X_train, y_train)

accuracy = model.score(X_test, y_test)
print(f"Model trained with accuracy: {accuracy * 100:.2f}%")

os.makedirs("models", exist_ok=True)
joblib.dump(model, "models/dust_model.pkl")
print("✅ Model saved to models/dust_model.pkl")
