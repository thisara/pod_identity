from typing import List
from dto.file_dto import FileDTO
from utils.s3_client import S3Client, get_s3_client

class FileService:

    def __init__(self, s3_client: S3Client):
        self.s3_client = s3_client

    def create_file(self, file: FileDTO) -> FileDTO:

        content_bytes = file.content.encode("utf-8")

        self.s3_client.put_object(
            key=file.file_name,
            content=content_bytes,
            content_type="text/plain"
        )

        return FileDTO( file_name=file.file_name, size=len(content_bytes))

    def list_files(self) -> List[FileDTO]:

        objects = self.s3_client.list_objects()

        return [
            FileDTO(file_name=obj["key"], size=obj["size"])
            for obj in objects
        ]


def get_file_service() -> FileService:
    return FileService(get_s3_client())