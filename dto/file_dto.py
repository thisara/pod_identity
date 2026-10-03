from dataclasses import dataclass
from typing import Optional

@dataclass
class FileDTO:
    file_name: str
    content: Optional[str] = None
    size: Optional[int] = None
