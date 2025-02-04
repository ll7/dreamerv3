#!/bin/bash

# Exit on error
set -e

# Check if virtual environment exists and activate it
if [ -d ".venv" ]; then
    source .venv/bin/activate
else
    echo "Virtual environment not found. Please run install.sh first."
    exit 1
fi

# Generate timestamp for logging
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Check GPU availability
if ! command -v nvidia-smi &> /dev/null; then
    echo "Warning: NVIDIA GPU not detected"
fi

# Validate arguments
CONFIG=${1:-crafter}
TRAIN_RATIO=${2:-32}

echo "Starting training with config: $CONFIG"
echo "Log directory: ./logdir/$TIMESTAMP"

python dreamerv3/main.py \
    --logdir "./logdir/$TIMESTAMP" \
    --configs "$CONFIG" \
    --run.train_ratio "$TRAIN_RATIO" || {
        echo "Training failed"
        exit 1
    }

echo "Training completed successfully"