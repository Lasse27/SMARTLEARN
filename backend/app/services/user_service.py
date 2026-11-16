import uuid
from datetime import UTC, datetime
from uuid import UUID

from app.models import User
from app.repositories import UserRepository
from app.schemas import UserCreate, UserUpdate


class UserNotFoundError(Exception):
    """
    Stellt einen Fehler dar, der aufritt, wenn ein Nutzer angefragt wird, der nicht existiert.
    """


class UserNameAlreadyExistsError(Exception):
    """
    Stellt einen Fehler dar, der auftritt, wenn der gewünschte Nutzername bereits existiert.
    """


class UserEmailAlreadyExistsError(Exception):
    """
    Stellt einen Fehler dar, der auftritt, wenn die gewünschte Email bereits existiert.
    """


class UserService:
    """
    Service für die Geschäftslogik für User-Instanzen.
    """

    def __init__(self, repository: UserRepository) -> None:
        self._repository = repository

    def create(self, data: UserCreate) -> User:
        # Validierung der Eingabedaten
        if not self._name_is_unique(data.name):
            raise UserNameAlreadyExistsError()

        if not self._email_is_unique(data.email):
            raise UserEmailAlreadyExistsError()

        # Erstellung des Modells und Speicherung in Repository
        user = User(
            id=uuid.uuid4(),
            name=data.name,
            email=data.email,
            email_verified=False,
            created_at=datetime.now(UTC),
        )
        return self._repository.create(user)

    def read(self, user_id: UUID) -> User:
        user = self._repository.read(user_id)
        if user is None:
            raise UserNotFoundError()
        return user

    def page(self, skip=0, limit=100) -> list[User]:
        return self._repository.list(skip, limit)

    def update(self, user_id: UUID, data: UserUpdate) -> User:
        user = self.read(user_id)

        if data.name is not None:
            if not self._name_is_unique(data.name):
                raise UserNameAlreadyExistsError()
            user.name = data.name

        if data.email is not None:
            if not self._email_is_unique(data.email):
                raise UserEmailAlreadyExistsError()
            user.email = data.email
            user.email_verified = False

        if data.password_hash is not None:
            user.password_hash = data.password_hash

        return self._repository.update(user)

    def delete(self, user_id: UUID) -> None:
        user = self._repository.read(user_id)
        if user is None:
            raise UserNotFoundError()
        self._repository.delete(user_id)

    def _name_is_unique(self, name: str) -> bool:
        return len(self._repository.readByName(name)) == 0

    def _email_is_unique(self, email: str) -> bool:
        return len(self._repository.readByEmail(email)) == 0
