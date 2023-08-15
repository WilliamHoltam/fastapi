"""add content column to posts table

Revision ID: 25d6cce332f8
Revises: 6319cb48044b
Create Date: 2023-08-15 11:15:28.723252

"""
from typing import Sequence, Union

import sqlalchemy as sa

from alembic import op

# revision identifiers, used by Alembic.
revision: str = "25d6cce332f8"
down_revision: Union[str, None] = "6319cb48044b"
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    op.add_column(
        "posts",
        sa.Column("content", sa.String(), nullable=False),
    )


def downgrade() -> None:
    op.drop_column("posts", "content")
