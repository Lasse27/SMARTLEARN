from __future__ import annotations

from typing import Any

import numpy as np

from .base import OCRBackend, register


@register("tesseract")
class TesseractBackend(OCRBackend):
    def __init__(
        self,
        lang: str = "eng",
        psm: int = 6,
        oem: int = 3,
        whitelist: str | None = None,
        executable: str | None = None,
    ):
        import pytesseract

        if executable:
            pytesseract.pytesseract.tesseract_cmd = executable

        pytesseract.get_tesseract_version()
        self.pytesseract = pytesseract
        self.lang = lang
        self.psm = psm
        self.oem = oem
        self.whitelist = whitelist

    @classmethod
    def create(cls, args: OCRArgs) -> OCRBackend:
        if args.model is not None or args.model_options:
            raise ValueError("Tesseract does not support model or model_options")

        return cls(**args.options)

    def recognize(self, image: np.ndarray, **kwargs: Any) -> str:
        lang = kwargs.pop("lang", self.lang)
        psm = kwargs.pop("psm", self.psm)
        oem = kwargs.pop("oem", self.oem)
        whitelist = kwargs.pop("whitelist", self.whitelist)
        config = f"--oem {oem} --psm {psm}"

        if whitelist:
            config += f" -c tessedit_char_whitelist={whitelist}"

        return self.pytesseract.image_to_string(
            image,
            lang=lang,
            config=config,
            **kwargs,
        ).strip()
