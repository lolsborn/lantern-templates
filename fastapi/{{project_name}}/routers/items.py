"""Item management router."""

from typing import List

from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import select

from ..core.database import get_db
from ..models.item import Item
from ..schemas.item import ItemCreate, ItemResponse, ItemUpdate

router = APIRouter()


@router.post("/", response_model=ItemResponse, status_code=status.HTTP_201_CREATED)
async def create_item(
    item_data: ItemCreate, db: AsyncSession = Depends(get_db)
) -> ItemResponse:
    """Create a new item."""
    db_item = Item(
        title=item_data.title,
        description=item_data.description,
        price=item_data.price,
        is_active=item_data.is_active,
    )

    db.add(db_item)
    await db.commit()
    await db.refresh(db_item)

    return ItemResponse.model_validate(db_item)


@router.get("/", response_model=List[ItemResponse])
async def get_items(
    skip: int = 0, limit: int = 100, db: AsyncSession = Depends(get_db)
) -> List[ItemResponse]:
    """Get all items with pagination."""
    result = await db.execute(select(Item).offset(skip).limit(limit))
    items = result.scalars().all()
    return [ItemResponse.model_validate(item) for item in items]


@router.get("/{item_id}", response_model=ItemResponse)
async def get_item(item_id: int, db: AsyncSession = Depends(get_db)) -> ItemResponse:
    """Get an item by ID."""
    result = await db.execute(select(Item).where(Item.id == item_id))
    item = result.scalar_one_or_none()

    if not item:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Item not found",
        )

    return ItemResponse.model_validate(item)


@router.put("/{item_id}", response_model=ItemResponse)
async def update_item(
    item_id: int, item_data: ItemUpdate, db: AsyncSession = Depends(get_db)
) -> ItemResponse:
    """Update an item."""
    result = await db.execute(select(Item).where(Item.id == item_id))
    item = result.scalar_one_or_none()

    if not item:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Item not found",
        )

    # Update fields if provided
    update_data = item_data.model_dump(exclude_unset=True)
    for field, value in update_data.items():
        setattr(item, field, value)

    await db.commit()
    await db.refresh(item)

    return ItemResponse.model_validate(item)


@router.delete("/{item_id}", status_code=status.HTTP_204_NO_CONTENT)
async def delete_item(item_id: int, db: AsyncSession = Depends(get_db)) -> None:
    """Delete an item."""
    result = await db.execute(select(Item).where(Item.id == item_id))
    item = result.scalar_one_or_none()

    if not item:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Item not found",
        )

    await db.delete(item)
    await db.commit()