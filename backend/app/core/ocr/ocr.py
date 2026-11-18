"""Backward-compatible public OCR module."""

from .backends import (
    EasyOCRBackend,
    OCRBackend,
    PaddleOCRBackend,
    RapidOCRBackend,
    TesseractBackend,
    backends,
    register,
)
from .config import OCRArgs
from .image import load_image, resize_image
from .preprocess import PREPROCESSORS, apply_preprocess
from .service import OCRService
from .types import ImageInput

_BACKENDS = backends()

__all__ = [
    "EasyOCRBackend",
    "ImageInput",
    "OCRArgs",
    "OCRBackend",
    "OCRService",
    "PaddleOCRBackend",
    "PREPROCESSORS",
    "RapidOCRBackend",
    "TesseractBackend",
    "apply_preprocess",
    "load_image",
    "register",
    "resize_image",
]
