"""Item schemas."""

from datetime import datetime
from decimal import Decimal
from typing import Optional

from pydantic import BaseModel, Field


class ItemBase(BaseModel):
    """Base item schema."""

    title: str = Field(..., min_length=1, max_length=200)
    description: Optional[str] = None
    price: Decimal = Field(..., ge=0)
    is_active: bool = True


class ItemCreate(ItemBase):
    """Item creation schema."""

    pass


class ItemUpdate(BaseModel):
    """Item update schema."""

    title: Optional[str] = Field(None, min_length=1, max_length=200)
    description: Optional[str] = None
    price: Optional[Decimal] = Field(None, ge=0)
    is_active: Optional[bool] = None


class ItemResponse(ItemBase):
    """Item response schema."""

    id: int
    created_at: datetime
    updated_at: Optional[datetime] = None

    class Config:
        from_attributes = True


class Item(ItemResponse):
    """Item schema alias for backward compatibility."""

    pass