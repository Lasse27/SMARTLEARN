from __future__ import annotations

import logging
from dataclasses import replace
from typing import Any, Callable, Iterable

import numpy as np

from .backends import OCRBackend, backends
from .config import OCRArgs
from .image import load_image, resize_image
from .preprocess import apply_preprocess
from .types import ImageInput

logger = logging.getLogger(__name__)


class OCRService:
    AUTO_ORDER = ("rapidocr", "tesseract", "paddleocr", "easyocr")

    def __init__(self, args: OCRArgs | dict[str, Any] | None = None):
        if args is None:
            args = OCRArgs()
        elif isinstance(args, dict):
            args = OCRArgs(**args)
        elif not isinstance(args, OCRArgs):
            raise TypeError("args must be OCRArgs, dict, or None")

        self.args = args
        self.backend = self._create_backend(args)

    def _create_backend(self, args: OCRArgs) -> OCRBackend:
        if args.engine != "auto":
            return backends()[args.engine].create(args)

        errors = []
        for engine_name in self.AUTO_ORDER:
            engine_options = args.options.get(engine_name, {})
            if not isinstance(engine_options, dict):
                errors.append(f"{engine_name}: options must be a dictionary")
                continue

            backend_args = replace(
                args,
                engine=engine_name,
                options=engine_options,
            )

            try:
                backend = backends()[engine_name].create(backend_args)
                logger.info("Initialized OCR backend: %s", engine_name)
                return backend
            except Exception as exc:
                logger.warning(
                    "Could not initialize OCR backend %s: %s",
                    engine_name,
                    exc,
                )
                errors.append(f"{engine_name}: {exc}")

        raise RuntimeError(
            "No configured local OCR engine could be initialized:\n"
            + "\n".join(errors)
        )

    def ocr(
        self,
        image: ImageInput,
        *,
        preprocess: list[str | Callable[[np.ndarray], np.ndarray]] | None = None,
        image_size: tuple[int, int] | None = None,
        **read_options: Any,
    ) -> str:
        loaded = load_image(image)
        target_size = self.args.image_size if image_size is None else image_size
        loaded = resize_image(
            loaded,
            target_size,
            allow_upscale=self.args.allow_upscale,
        )

        steps = self.args.preprocess if preprocess is None else preprocess
        prepared = apply_preprocess(loaded, steps)
        options = {**self.args.read_options, **read_options}
        return self.backend.recognize(prepared, **options)

    def ocr_many(
        self,
        images: Iterable[ImageInput],
        separator: str = "\n\n",
        **ocr_options: Any,
    ) -> str:
        return separator.join(
            self.ocr(image, **ocr_options)
            for image in images
        )
