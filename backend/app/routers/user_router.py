from uuid import UUID

from fastapi import APIRouter, Query, status

from app.dependencies import UserServiceDep
from app.schemas import UserCreate, UserRead, UserUpdate

user_routes = APIRouter(prefix="/users", tags=["users"])


@user_routes.post("", response_model=UserRead, status_code=status.HTTP_201_CREATED)
def create_user(data: UserCreate, service: UserServiceDep):
    return service.create(data)


@user_routes.get("", response_model=list[UserRead])
def list_users(
    service: UserServiceDep,
    skip: int = Query(0, ge=0),
    limit: int = Query(100, ge=1, le=500),
):
    return service.page(skip=skip, limit=limit)


@user_routes.get("/{user_id}", response_model=UserRead)
def get_user(user_id: UUID, service: UserServiceDep):
    return service.read(user_id)


@user_routes.patch("/{user_id}", response_model=UserRead)
def update_user(user_id: UUID, data: UserUpdate, service: UserServiceDep):
    return service.update(user_id, data)


@user_routes.delete("/{user_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_user(user_id: UUID, service: UserServiceDep):
    service.delete(user_id)
