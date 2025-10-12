from fastapi import APIRouter
from pydantic import BaseModel
from typing import List
from datetime import datetime

router = APIRouter()

# Dummy in-memory storage
data_store = []

class SensorData(BaseModel):
    device_id: str
    pm25: float
    co2: float
    battery: float
    timestamp: datetime

@router.post("/post-reading")
def post_reading(data: SensorData):
    data_store.append(data)
    return {"message": "Sensor data saved successfully"}

@router.get("/get-readings", response_model=List[SensorData])
def get_readings():
    return data_store
