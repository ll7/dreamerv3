#!/bin/bash

# Exit on error
set -e

# Check if pip is installed
if ! command -v pip &> /dev/null; then
    echo "pip not found. Please install Python and pip first."
    exit 1
fi

# Install and upgrade uv
pip install --upgrade uv

# Create and activate virtual environment
uv venv --python 3.12
source .venv/bin/activate || {
    echo "Failed to activate virtual environment"
    exit 1
}

# Install packages with error handling
uv pip install "jax[cuda12]" || {
    echo "Failed to install JAX"
    exit 1
}

uv pip install -r requirements.txt || {
    echo "Failed to install requirements"
    exit 1
}

echo "Installation completed successfully"