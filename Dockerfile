# Stage 1: Base image with Python and Poetry
FROM --platform=linux/amd64 python:3.12-slim as base

# Set environment variables for Poetry
ENV POETRY_VERSION=1.8.3 \
    POETRY_HOME=/opt/poetry \
    POETRY_VENV=/opt/poetry-venv \
    VIRTUAL_ENV=/opt/poetry-venv \
    POETRY_CACHE_DIR=/opt/.cache

# Install Poetry
RUN python3 -m venv $POETRY_VENV \
    && $POETRY_VENV/bin/pip install -U pip setuptools \
    && $POETRY_VENV/bin/pip install poetry==${POETRY_VERSION}

# Add Poetry to PATH
ENV PATH="${PATH}:${POETRY_VENV}/bin"

# Verify Poetry installation
RUN poetry --version

# Stage 2: Install dependencies
FROM base as builder
WORKDIR /app
COPY poetry.lock pyproject.toml ./
RUN poetry install --no-dev --no-interaction --no-cache

# Stage 3: Final image with the application
FROM base as final
WORKDIR /app
COPY --from=builder /app /app
COPY . /app
RUN poetry install --no-dev --no-interaction --no-cache

CMD ["poetry", "run", "gunicorn", "--workers", "4", "--bind", "0.0.0.0:5050", "--timeout", "120", "src.app:app"]

EXPOSE 5050
