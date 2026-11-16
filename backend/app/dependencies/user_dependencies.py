from functools import lru_cache
from typing import Annotated

from fastapi import Depends

from app.repositories import InMemoryUserRepository, UserRepository
from backend.app.services import UserService


@lru_cache
def get_user_repository() -> UserRepository:
    return InMemoryUserRepository()


def get_user_service(
    repo: Annotated[UserRepository, Depends(get_user_repository)],
) -> UserService:
    return UserService(repo)


UserServiceDep = Annotated[UserService, Depends(get_user_service)]
