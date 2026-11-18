from __future__ import annotations

import logging
from typing import Any

import cv2
import numpy as np

from .base import OCRBackend, register

logger = logging.getLogger(__name__)


@register("paddleocr")
class PaddleOCRBackend(OCRBackend):
    def __init__(
        self,
        model: str | None = None,
        model_options: dict[str, Any] | None = None,
        **options: Any,
    ):
        from paddleocr import PaddleOCR

        config: dict[str, Any] = {
            "enable_mkldnn": False,
            "device": "cpu",
        }

        if model:
            config["text_recognition_model_name"] = model

        config.update(model_options or {})
        config.update(options)
        self.engine = PaddleOCR(**config)

    @classmethod
    def create(cls, args: OCRArgs) -> OCRBackend:
        return cls(
            model=args.model,
            model_options=args.model_options,
            **args.options,
        )

    def recognize(self, image: np.ndarray, **kwargs: Any) -> str:
        height, width = image.shape[:2]

        if height < 150:
            scale = 3
            image = cv2.resize(
                image,
                (width * scale, height * scale),
                interpolation=cv2.INTER_CUBIC,
            )

        border = 40
        if image.ndim == 2:
            image = cv2.copyMakeBorder(
                image,
                border,
                border,
                border,
                border,
                cv2.BORDER_CONSTANT,
                value=255,
            )
        else:
            image = cv2.copyMakeBorder(
                image,
                border,
                border,
                border,
                border,
                cv2.BORDER_CONSTANT,
                value=(255, 255, 255),
            )

        results = self.engine.predict(image)
        lines = []

        for result in results or []:
            data = result.json if hasattr(result, "json") else result
            if callable(data):
                data = data()
            if not isinstance(data, dict):
                continue

            data = data.get("res", data)
            if not isinstance(data, dict):
                continue

            texts = data.get("rec_texts", [])
            scores = data.get("rec_scores", [])

            for index, text in enumerate(texts):
                if not isinstance(text, str) or not text.strip():
                    continue

                score = (
                    scores[index]
                    if isinstance(scores, (list, tuple)) and index < len(scores)
                    else None
                )
                logger.debug("PaddleOCR detected: %r | Confidence: %s", text, score)
                lines.append(text)

        return "\n".join(lines).strip()
