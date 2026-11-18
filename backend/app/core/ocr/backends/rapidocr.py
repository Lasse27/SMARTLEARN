from __future__ import annotations

from typing import Any

import numpy as np

from .base import OCRBackend, register


@register("rapidocr")
class RapidOCRBackend(OCRBackend):
    def __init__(self, **options: Any):
        from rapidocr_onnxruntime import RapidOCR

        self.engine = RapidOCR(**options)

    @classmethod
    def create(cls, args: OCRArgs) -> OCRBackend:
        if args.model is not None or args.model_options:
            raise ValueError(
                "RapidOCR does not support model or model_options through OCRArgs"
            )

        return cls(**args.options)

    def recognize(self, image: np.ndarray, **kwargs: Any) -> str:
        result, _ = self.engine(image)

        if not result:
            return ""

        items = sorted(
            result,
            key=lambda item: (
                sum(point[1] for point in item[0]) / len(item[0]),
                min(point[0] for point in item[0]),
            ),
        )

        return "\n".join(
            item[1] for item in items if len(item) > 1 and item[1]
        ).strip()
