from typing import List, Optional
from fastapi import APIRouter, Depends
from pydantic import BaseModel, Field, validator
from dto.file_dto import FileDTO
from service.file_service import FileService, get_file_service

router = APIRouter(
    prefix="/files",
    tags=["files"]
)

class CreateFileRequest(BaseModel):

    file_name: str = Field(..., min_length=1, max_length=255)

    content: str = Field(..., min_length=1)

    @validator("file_name")
    def validate_file_name(cls, value):
        value = value.strip()

        if not value:
            raise ValueError("file_name cannot be empty!")

        if "/" in value or "\\" in value:
            raise ValueError("file_name must not contain path separators")

        return value

    def to_dto(self):
        return FileDTO(file_name=self.file_name,content=self.content)


class FileResponse(BaseModel):
    file_name: str
    size: Optional[int] = None


@router.post("", response_model=FileResponse, status_code=201)
def create_file(request: CreateFileRequest, service: FileService = Depends(get_file_service)):
    file_dto = request.to_dto()

    result = service.create_file(file_dto)

    return FileResponse(file_name=result.file_name, size=result.size)


@router.get("", response_model=List[FileResponse])
def list_files(service: FileService = Depends(get_file_service)):
    files = service.list_files()

    return [
        FileResponse(file_name=file.file_name, size=file.size)
        for file in files
    ]