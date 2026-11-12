from __future__ import annotations

import uuid
from datetime import datetime
from typing import TYPE_CHECKING

from sqlalchemy import DateTime, ForeignKey, Index, String, func, text
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import Mapped, mapped_column, relationship

from backend.app.core.db import Base

if TYPE_CHECKING:
    from .exercise import Exercise
    from .user import User


# Datenmodell für ein Dokument
class Document(Base):
    __tablename__ = "documents"

    # Attribute
    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        primary_key=True,
        default=uuid.uuid4,
    )

    user_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True),
        ForeignKey("users.id", ondelete="CASCADE"),
    )

    title: Mapped[str] = mapped_column(
        String(320),
    )

    created_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        server_default=func.now(),
    )

    updated_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True),
        server_default=func.now(),
        onupdate=func.now(),
    )

    # Beziehungen
    user: Mapped[User] = relationship(back_populates="documents")

    exercises: Mapped[list[Exercise]] = relationship(
        back_populates="document", cascade="all, delete-orphan"
    )

    # Indizes und co.
    __table_args__ = (
        Index("ix_documents_user_name", "user_id", text("lower(title)")),
        Index("ix_documents_user_updated", "user_id", text("updated_at DESC")),
    )
