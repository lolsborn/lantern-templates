"""Item management router."""

from typing import List

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from sqlalchemy import select

from ..core.database import get_db
from ..models.item import Item
from ..schemas.item import ItemCreate, ItemResponse, ItemUpdate

router = APIRouter()


@router.post("/", response_model=ItemResponse, status_code=status.HTTP_201_CREATED)
def create_item(
    item_data: ItemCreate, db: Session = Depends(get_db)
) -> ItemResponse:
    """Create a new item."""
    db_item = Item(
        title=item_data.title,
        description=item_data.description,
        price=item_data.price,
        is_active=item_data.is_active,
    )

    db.add(db_item)
    db.commit()
    db.refresh(db_item)

    return ItemResponse.model_validate(db_item)


@router.get("/", response_model=List[ItemResponse])
def get_items(
    skip: int = 0, limit: int = 100, db: Session = Depends(get_db)
) -> List[ItemResponse]:
    """Get all items with pagination."""
    items = db.execute(select(Item).offset(skip).limit(limit)).scalars().all()
    return [ItemResponse.model_validate(item) for item in items]


@router.get("/{item_id}", response_model=ItemResponse)
def get_item(item_id: int, db: Session = Depends(get_db)) -> ItemResponse:
    """Get an item by ID."""
    item = db.execute(select(Item).where(Item.id == item_id)).scalar_one_or_none()

    if not item:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Item not found",
        )

    return ItemResponse.model_validate(item)


@router.put("/{item_id}", response_model=ItemResponse)
def update_item(
    item_id: int, item_data: ItemUpdate, db: Session = Depends(get_db)
) -> ItemResponse:
    """Update an item."""
    item = db.execute(select(Item).where(Item.id == item_id)).scalar_one_or_none()

    if not item:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Item not found",
        )

    # Update fields if provided
    update_data = item_data.model_dump(exclude_unset=True)
    for field, value in update_data.items():
        setattr(item, field, value)

    db.commit()
    db.refresh(item)

    return ItemResponse.model_validate(item)


@router.delete("/{item_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_item(item_id: int, db: Session = Depends(get_db)) -> None:
    """Delete an item."""
    item = db.execute(select(Item).where(Item.id == item_id)).scalar_one_or_none()

    if not item:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Item not found",
        )

    db.delete(item)
    db.commit()
