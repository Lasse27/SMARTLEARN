import os
from app.core.ocr.ocr import OCRArgs, OCRService

BASE_DIR = os.path.dirname(os.path.abspath(__file__))


# Tesseract
args = OCRArgs(
    engine="tesseract",
    image_size=(2000, 2000),
    preprocess=["gray", "contrast"],
    options={
        "lang": "eng",
        "psm": 6,
        "oem": 3
    }
)
# Easyocr
# args = OCRArgs(
#     engine="easyocr",
#     image_size=(2000, 2000),
#     preprocess=["gray", "contrast"],
#     options={
#         "languages": ["en"],
#         "gpu": False,
#         "offline": True,
#         "model_dir": os.path.join(
#             BASE_DIR,
#             "..",
#             "app",
#             "models",
#         ),
#     },
# )
# Paddleocr
# args = OCRArgs(
#     engine="paddleocr",
#     model="PP-OCRv6_medium_rec",
#     model_options={
#         "text_detection_model_name": "PP-OCRv6_medium_det",
#         "enable_mkldnn": False,
#         "device": "cpu",
#     },
#     image_size=(2000, 2000),
#     preprocess=[],
#     options={}
# )
# Rapidocr
# args = OCRArgs(
#     engine="rapidocr",
#     image_size=(2000, 2000),
#     preprocess=["gray", "contrast"],
#     options={},
#     read_options={},
# )

ocr = OCRService(args)

directory = os.path.abspath(
    os.path.join(BASE_DIR, "resources", "ocr")
)

print(f"Reading images from: {directory}")

if not os.path.exists(directory):
    raise FileNotFoundError(f"Directory not found: {directory}")

with os.scandir(directory) as entries:
    for entry in entries:
        if entry.is_file():
            print(f"\n{entry.path} extracted text:")
            try:
                text = ocr.ocr(entry.path)
                print(text)
            except Exception as e:
                print(f"OCR failed: {e}")