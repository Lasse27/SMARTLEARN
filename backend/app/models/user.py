from __future__ import annotations

import uuid
from datetime import datetime
from typing import TYPE_CHECKING

from sqlalchemy import DateTime, Index, String, func, text
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.core.db import Base

if TYPE_CHECKING:
    from .document import Document


# Datenmodell für den Nutzer
class User(Base):
    __tablename__ = "users"

    # Attribute
    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        primary_key=True,
        default=uuid.uuid4,
    )

    name: Mapped[str] = mapped_column(
        String(320),
        nullable=False,
    )

    email: Mapped[str] = mapped_column(
        String(320),
        nullable=False,
    )

    email_verified: Mapped[bool] = mapped_column(
        default=False,
        nullable=False,
    )

    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        server_default=func.now(),
    )

    # Beziehungen
    documents: Mapped[list[Document]] = relationship(
        back_populates="user", cascade="all, delete-orphan"
    )

    # Indizes und co.
    __table_args__ = (
        # E-Mail unabhängig von Groß-/Kleinschreibung eindeutig
        Index("uq_users_email", text("lower(email)"), unique=True),
        # Username unabhängig von Groß-/Kleinschreibung eindeutig
        Index("uq_users_name", text("lower(name)"), unique=True),
    )
