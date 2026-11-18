from __future__ import annotations

import os
from pathlib import Path

import cv2
import numpy as np

from .types import ImageInput

try:
    from PIL import Image as PILImage
except ImportError:
    PILImage = None


def _decode(data: bytes) -> np.ndarray:
    image = cv2.imdecode(
        np.frombuffer(data, dtype=np.uint8),
        cv2.IMREAD_COLOR,
    )

    if image is None:
        raise ValueError("Could not decode image data")

    return image


def load_image(source: ImageInput) -> np.ndarray:
    if isinstance(source, np.ndarray):
        image = source.copy()

        if image.dtype != np.uint8:
            raise ValueError("Image ndarray must have dtype uint8")

        if image.ndim == 2:
            return cv2.cvtColor(image, cv2.COLOR_GRAY2BGR)

        if image.ndim != 3 or image.shape[2] not in (3, 4):
            raise ValueError("Expected a grayscale, BGR, or BGRA image")

        if image.shape[2] == 4:
            image = cv2.cvtColor(image, cv2.COLOR_BGRA2BGR)

        return np.ascontiguousarray(image)

    if isinstance(source, (bytes, bytearray)):
        return _decode(bytes(source))

    if PILImage is not None and isinstance(source, PILImage.Image):
        return cv2.cvtColor(
            np.array(source.convert("RGB")),
            cv2.COLOR_RGB2BGR,
        )

    if hasattr(source, "read"):
        position = None

        if hasattr(source, "tell") and hasattr(source, "seek"):
            try:
                position = source.tell()
                source.seek(0)
            except (OSError, ValueError):
                position = None

        try:
            data = source.read()
        finally:
            if position is not None:
                source.seek(position)

        if not isinstance(data, (bytes, bytearray)):
            raise TypeError("File object must return bytes")

        return _decode(bytes(data))

    if isinstance(source, (str, os.PathLike)):
        path_text = str(source)

        if path_text.startswith(("http://", "https://")):
            raise ValueError("Local OCR does not accept image URLs")

        path = Path(path_text)

        if not path.is_file():
            raise FileNotFoundError(f"No such image file: {path}")

        return _decode(path.read_bytes())

    raise TypeError(f"Unsupported image input type: {type(source)!r}")


def resize_image(
    image: np.ndarray,
    max_size: tuple[int, int] | None,
    allow_upscale: bool = False,
) -> np.ndarray:
    if max_size is None:
        return image

    if len(max_size) != 2:
        raise ValueError("image_size must contain (max_width, max_height)")

    max_width, max_height = max_size

    if max_width <= 0 or max_height <= 0:
        raise ValueError("image_size values must be positive")

    height, width = image.shape[:2]
    scale = min(max_width / width, max_height / height)

    if not allow_upscale:
        scale = min(scale, 1.0)

    if abs(scale - 1.0) < 1e-9:
        return image

    interpolation = cv2.INTER_CUBIC if scale > 1 else cv2.INTER_AREA

    return cv2.resize(
        image,
        (max(1, round(width * scale)), max(1, round(height * scale))),
        interpolation=interpolation,
    )
