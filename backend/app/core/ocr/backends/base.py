from __future__ import annotations

from abc import ABC, abstractmethod
from typing import TYPE_CHECKING, Any

import numpy as np

if TYPE_CHECKING:
    from ..config import OCRArgs


class OCRBackend(ABC):
    name = "base"

    @classmethod
    @abstractmethod
    def create(cls, args: OCRArgs) -> OCRBackend:
        pass

    @abstractmethod
    def recognize(self, image: np.ndarray, **read_options: Any) -> str:
        pass


_BACKENDS: dict[str, type[OCRBackend]] = {}


def backends() -> dict[str, type[OCRBackend]]:
    return _BACKENDS


def register(name: str):
    def decorator(cls: type[OCRBackend]):
        if name in _BACKENDS:
            raise ValueError(f"OCR backend already registered: {name}")

        _BACKENDS[name] = cls
        cls.name = name
        return cls

    return decorator
