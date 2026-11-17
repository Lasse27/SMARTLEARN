from typing import TYPE_CHECKING

__all__ = ["UserService"]

if TYPE_CHECKING:
    from .user_service import UserService


def __getattr__(name: str):
    if name == "UserService":
        from .user_service import UserService

        return UserService
    raise AttributeError(f"module {__name__!r} has no attribute {name!r}")
