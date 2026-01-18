from sqlalchemy import Column, Integer, String, Float, DateTime, Boolean, ForeignKey
from sqlalchemy.orm import relationship
from datetime import datetime
from database import Base

# -----------------------
# User Table
# -----------------------
class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    email = Column(String, unique=True, index=True, nullable=False)
    password = Column(String, nullable=False)
    created_at = Column(DateTime, default=datetime.utcnow)


# -----------------------
# Sensor Data Table
# -----------------------
class SensorData(Base):
    __tablename__ = "sensor_data"

    id = Column(Integer, primary_key=True, index=True)
    device_id = Column(String, index=True)
    pm25 = Column(Float)
    pm10 = Column(Float)
    co2 = Column(Float)
    ph = Column(Float)
    turbidity = Column(Float)
    temperature = Column(Float)
    airflow = Column(Float)
    dust_collected = Column(Float)
    mist_tank_level = Column(Float)
    water_tank_level = Column(Float)
    battery = Column(Float)
    timestamp = Column(DateTime, default=datetime.utcnow)


# -----------------------
# Alerts Table
# -----------------------
class Alert(Base):
    __tablename__ = "alerts"

    id = Column(Integer, primary_key=True, index=True)
    message = Column(String)
    level = Column(String)  # e.g. "info", "warning", "critical"
    resolved = Column(Boolean, default=False)
    timestamp = Column(DateTime, default=datetime.utcnow)


# -----------------------
# Manual Commands Table
# -----------------------
class Command(Base):
    __tablename__ = "commands"

    id = Column(Integer, primary_key=True, index=True)
    device_id = Column(String)
    action = Column(String)
    executed = Column(Boolean, default=False)
    timestamp = Column(DateTime, default=datetime.utcnow)


# -----------------------
# Recycling Logs Table
# -----------------------
class RecyclingLog(Base):
    __tablename__ = "recycling_logs"

    id = Column(Integer, primary_key=True, index=True)
    type = Column(String)  # e.g. "dust" or "algae"
    weight = Column(Float)
    status = Column(String, default="stored")  # e.g. "stored", "ready", "picked_up"
    timestamp = Column(DateTime, default=datetime.utcnow)


# -----------------------
# Impact Reports Table
# -----------------------
class ImpactReport(Base):
    __tablename__ = "impact_reports"

    id = Column(Integer, primary_key=True, index=True)
    co2_reduced = Column(Float)
    pm_reduced = Column(Float)
    dust_collected = Column(Float)
    algae_harvested = Column(Float)
    report_period = Column(String)  # e.g. "daily", "weekly"
    created_at = Column(DateTime, default=datetime.utcnow)
