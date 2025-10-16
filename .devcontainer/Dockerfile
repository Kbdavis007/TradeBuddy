FROM mcr.microsoft.com/vscode/devcontainers/python:3.11-bullseye

# Install system dependencies
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    build-essential \
    libffi-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Ensure pip, pipx and uv are installed
RUN python -m pip install --upgrade pip setuptools wheel
RUN python -m pip install --upgrade pipx
RUN python -m pipx ensurepath || true

# Install uv using pipx (will be available on PATH)
RUN /bin/bash -lc "pipx install uv"

# Add a non-root vscode user (image already has 'vscode') and ensure pipx paths available
ENV PIPX_HOME=/home/vscode/.local/pipx
ENV PIPX_BIN_DIR=/home/vscode/.local/bin
ENV PATH="$PIPX_BIN_DIR:$PATH"

USER vscode

# Run no-op to keep layer
CMD ["sleep", "infinity"]
