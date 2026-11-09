from dataclasses import dataclass
from typing import Optional

@dataclass
class FileDTO:
    file_name: str
    content: str
    size: Optional[int] = None

@dataclass
class FileListDTO:
    file_name: str
    size: int