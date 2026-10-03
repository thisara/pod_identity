from dotenv import load_dotenv
import os

load_dotenv()

from fastapi import FastAPI
from api.file_api import router as file_router

app = FastAPI(title="S3 File API",version= os.getenv('VERSION', "unknown"))

app.include_router(file_router)

@app.get("/health")
def health():
    return {"status": "UP"}