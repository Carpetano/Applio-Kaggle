#!/bin/bash
set -e  # exit on any error

printf "\033]0;Kaggle Applio Installer\007"
clear

# Logging helper
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

# 1) System dependencies
log "Updating apt and installing FFmpeg..."
sudo apt-get update -y
sudo apt-get install -y ffmpeg

# 2) Python dependencies
log "Installing python-ffmpeg and other pip packages..."
python -m pip install --upgrade pip
pip install python-ffmpeg

if [ -f requirements.txt ]; then
  pip install -r requirements.txt
else
  log "⚠️ requirements.txt not found — skipping."
fi

# 3) PyTorch (Kaggle kernels typically have CUDA 11.x; adjust if needed)
log "Installing PyTorch + CUDA support..."
pip install torch==2.7.1+cu117 torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu117

# 4) Environment vars
export PYTORCH_ENABLE_MPS_FALLBACK=1
export PYTORCH_MPS_HIGH_WATERMARK_RATIO=0.0

# 5) Run the app
log "Starting Applio..."
python app.py --open
