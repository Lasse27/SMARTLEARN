from __future__ import annotations

from dataclasses import dataclass, field
from typing import Any, Callable

import numpy as np

from .backends import backends
from .preprocess import PREPROCESSORS


@dataclass
class OCRArgs:
    engine: str = "tesseract"
    model: str | None = None
    model_options: dict[str, Any] = field(default_factory=dict)
    image_size: tuple[int, int] | None = (2000, 2000)
    allow_upscale: bool = False
    preprocess: list[str | Callable[[np.ndarray], np.ndarray]] = field(
        default_factory=list
    )
    options: dict[str, Any] = field(default_factory=dict)
    read_options: dict[str, Any] = field(default_factory=dict)

    def __post_init__(self):
        if self.engine not in (*backends(), "auto"):
            raise ValueError(
                f"Unknown local OCR engine {self.engine!r}. "
                f"Available: {sorted([*backends(), 'auto'])}"
            )

        if self.image_size is not None:
            if (
                len(self.image_size) != 2
                or any(
                    not isinstance(value, int)
                    or isinstance(value, bool)
                    or value <= 0
                    for value in self.image_size
                )
            ):
                raise ValueError("image_size must contain two positive integers")

        if not isinstance(self.options, dict):
            raise TypeError("options must be a dictionary")
        if not isinstance(self.model_options, dict):
            raise TypeError("model_options must be a dictionary")
        if not isinstance(self.read_options, dict):
            raise TypeError("read_options must be a dictionary")
        if not isinstance(self.preprocess, list):
            raise TypeError("preprocess must be a list")

        for step in self.preprocess:
            if isinstance(step, str):
                if step not in PREPROCESSORS:
                    raise ValueError(
                        f"Unknown preprocessing step {step!r}. "
                        f"Available: {sorted(PREPROCESSORS)}"
                    )
            elif not callable(step):
                raise TypeError(f"Invalid preprocessing step: {step!r}")
