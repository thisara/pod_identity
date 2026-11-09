import os
import base64
import hashlib

from cryptography.hazmat.primitives.ciphers.aead import AESGCM
from typing import List
from dto.file_dto import FileDTO, FileListDTO
from utils.s3_client import S3Client, get_s3_client

class FileService:

    def __init__(self, s3_client: S3Client):
        self.s3_client = s3_client

    def create_file(self, file: FileDTO) -> FileDTO:

        encrypted_file = self.encrypt_file(file)

        if not encrypted_file.content:
            raise ValueError("Encrypted file content is empty.")
        
        content_bytes = encrypted_file.content.encode("utf-8")

        self.s3_client.add_object(
            key=file.file_name,
            content=content_bytes,
            content_type="text/plain"
        )

        return FileDTO( file_name=file.file_name, content=file.content ,size=len(content_bytes))

    def encrypt_file(self,file: FileDTO) -> FileDTO:

        encryption_key = os.environ["AWS_S3_ENC"]

        if not encryption_key:
            raise ValueError("Encryption key is missing or empty.")

        key = hashlib.sha256(encryption_key.encode("utf-8")).digest()
        nonce = os.urandom(12)

        aesgcm = AESGCM(key)
        encrypted_content = aesgcm.encrypt(
            nonce,
            file.content.encode("utf-8"),
            None
        )

        encoded_content = base64.b64encode(
            nonce + encrypted_content
        ).decode("utf-8")

        return FileDTO(
            file_name=file.file_name,
            content=encoded_content,
            size=len(encoded_content.encode("utf-8"))
        )

    def list_files(self) -> List[FileDTO]:

        objects = self.s3_client.list_objects()
        print(objects)
        return [
            FileListDTO(file_name=obj["key"], size=obj["size"])
            for obj in objects
        ]


def get_file_service() -> FileService:
    return FileService(get_s3_client())