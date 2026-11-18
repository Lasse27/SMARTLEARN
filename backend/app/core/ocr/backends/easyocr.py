from __future__ import annotations

from typing import Any

import numpy as np

from .base import OCRBackend, register


@register("easyocr")
class EasyOCRBackend(OCRBackend):
    def __init__(
        self,
        languages: list[str] | None = None,
        gpu: bool = False,
        model_dir: str | None = None,
        offline: bool = True,
    ):
        import easyocr

        reader_options: dict[str, Any] = {"gpu": gpu}

        if model_dir:
            reader_options["model_storage_directory"] = model_dir

        if offline:
            reader_options["download_enabled"] = False

        self.reader = easyocr.Reader(languages or ["en"], **reader_options)

    @classmethod
    def create(cls, args: OCRArgs) -> OCRBackend:
        if args.model is not None or args.model_options:
            raise ValueError(
                "EasyOCR does not support model or model_options through OCRArgs"
            )

        return cls(**args.options)

    def recognize(self, image: np.ndarray, **kwargs: Any) -> str:
        lines = self.reader.readtext(
            image,
            detail=0,
            paragraph=kwargs.get("paragraph", True),
        )
        return "\n".join(lines).strip()
