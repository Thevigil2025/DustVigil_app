from fastapi import APIRouter
from pydantic import BaseModel

router = APIRouter()

class Command(BaseModel):
    device_id: str
    action: str  # e.g., "start_misting", "scrape_hepa"

@router.post("/send-command")
def send_command(cmd: Command):
    # In real app, send command to device via MQTT/WebSocket
    return {"message": f"Command '{cmd.action}' sent to {cmd.device_id}"}
