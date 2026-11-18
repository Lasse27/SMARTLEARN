from __future__ import annotations

from typing import Callable, Iterable

import cv2
import numpy as np


def _gray(image: np.ndarray) -> np.ndarray:
    if image.ndim == 2:
        return image

    return cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)


def _contrast(image: np.ndarray) -> np.ndarray:
    return cv2.createCLAHE(
        clipLimit=2.0,
        tileGridSize=(8, 8),
    ).apply(_gray(image))


def _threshold(image: np.ndarray) -> np.ndarray:
    return cv2.threshold(
        _gray(image),
        0,
        255,
        cv2.THRESH_BINARY + cv2.THRESH_OTSU,
    )[1]


def _adaptive_threshold(image: np.ndarray) -> np.ndarray:
    return cv2.adaptiveThreshold(
        _gray(image),
        255,
        cv2.ADAPTIVE_THRESH_GAUSSIAN_C,
        cv2.THRESH_BINARY,
        31,
        15,
    )


def _denoise(image: np.ndarray) -> np.ndarray:
    return cv2.fastNlMeansDenoising(_gray(image), None, 10, 7, 21)


def _upscale_2x(image: np.ndarray) -> np.ndarray:
    return cv2.resize(
        image,
        None,
        fx=2,
        fy=2,
        interpolation=cv2.INTER_CUBIC,
    )


PREPROCESSORS: dict[str, Callable[[np.ndarray], np.ndarray]] = {
    "gray": _gray,
    "contrast": _contrast,
    "threshold": _threshold,
    "adaptive_threshold": _adaptive_threshold,
    "denoise": _denoise,
    "upscale_2x": _upscale_2x,
    "invert": cv2.bitwise_not,
}


def apply_preprocess(
    image: np.ndarray,
    steps: Iterable[str | Callable[[np.ndarray], np.ndarray]] | None,
) -> np.ndarray:
    for step in steps or ():
        function = PREPROCESSORS.get(step) if isinstance(step, str) else step

        if function is None:
            raise ValueError(
                f"Unknown preprocessing step {step!r}. "
                f"Available: {sorted(PREPROCESSORS)}"
            )

        if not callable(function):
            raise TypeError(f"Preprocessing step must be callable: {step!r}")

        image = function(image)

        if not isinstance(image, np.ndarray):
            raise TypeError(f"Preprocessor {step!r} did not return an ndarray")

        if image.dtype != np.uint8:
            raise ValueError(f"Preprocessor {step!r} must return uint8 data")

    return image
