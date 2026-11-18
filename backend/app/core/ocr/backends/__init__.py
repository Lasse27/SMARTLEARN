from .base import OCRBackend, backends, register
from .easyocr import EasyOCRBackend
from .paddleocr import PaddleOCRBackend
from .rapidocr import RapidOCRBackend
from .tesseract import TesseractBackend

__all__ = [
    "EasyOCRBackend",
    "OCRBackend",
    "PaddleOCRBackend",
    "RapidOCRBackend",
    "TesseractBackend",
    "backends",
    "register",
]
