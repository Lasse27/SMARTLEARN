from datetime import datetime
from uuid import UUID

from pydantic import BaseModel, ConfigDict, EmailStr, Field


class UserBase(BaseModel):
    """
    Base-Klasse für alle Schemas/DTOs des Nutzers
    """


class UserRead(UserBase):
    """
    Schema für das Lesen eines Nutzers
    """

    id: UUID
    email: EmailStr
    name: str = Field(min_length=3, max_length=50)
    email_verified: bool
    created_at: datetime
    model_config = ConfigDict(from_attributes=True)


class UserCreate(UserBase):
    """
    Schema für die Erstellung eines neuen Nutzers
    """

    email: EmailStr
    name: str = Field(min_length=3, max_length=50)
    password_hash: str = Field(min_length=8, max_length=128)


class UserUpdate(UserBase):
    """
    Schema für das Update eines Nutzers
    """

    email: EmailStr | None = None
    name: str | None = Field(default=None, min_length=3, max_length=50)
    password_hash: str | None = Field(default=None, min_length=8, max_length=128)
