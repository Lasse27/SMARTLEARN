from __future__ import annotations

import io
import os
from typing import Union, Any

import numpy as np

ImageInput = Union[
    str,
    os.PathLike,
    bytes,
    bytearray,
    np.ndarray,
    io.IOBase,
    Any,
]