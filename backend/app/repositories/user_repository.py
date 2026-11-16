from typing import Protocol
from uuid import UUID

from app.models import User


class UserRepository(Protocol):
    """
    Protocol/Interface für User Repositories.
    """

    def create(self, user: User) -> User: ...
    def read(self, user_id: UUID) -> User | None: ...
    def readByName(self, name: str) -> list[User]: ...
    def readByEmail(self, email: str) -> list[User]: ...
    def list(self, skip: int = 0, limit: int = 100) -> list[User]: ...
    def update(self, user: User) -> User: ...
    def delete(self, user_id: UUID) -> None: ...


class InMemoryUserRepository(UserRepository):
    """
    In-Memory-Repository für User. Nur fürs Testen. Nutzer sind nach Neustart der App weg.
    """

    def __init__(self) -> None:
        super().__init__()
        self.entries: dict[UUID, User] = {}

    def create(self, user: User) -> User:
        self.entries[user.id] = user
        return user

    def read(self, user_id: UUID) -> User | None:
        return self.entries.get(user_id)

    def readByEmail(self, email: str) -> list[User]:
        return [
            user
            for user in self.entries.values()
            if user.email.lower() == email.lower()
        ]

    def readByName(self, name: str) -> list[User]:
        return [
            user for user in self.entries.values() if user.name.lower() == name.lower()
        ]

    def list(self, skip: int = 0, limit: int = 100) -> list[User]:
        return list(self.entries.values())[skip : skip + limit]

    def update(self, user: User) -> User:
        self.entries[user.id] = user
        return user

    def delete(self, user_id: UUID) -> None:
        self.entries.pop(user_id)
