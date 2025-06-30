#!/bin/bash
set -e

printf "\033]0;Kaggle Applio Installer\007"
clear

# Logging helper
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

log "Updating apt and installing FFmpeg..."
sudo apt-get update -y
sudo apt-get install -y ffmpeg

log "Upgrading pip and installing Python packages..."
python3 -m pip install --upgrade pip
python3 -m pip install python-ffmpeg

if [ -f requirements.txt ]; then
  python3 -m pip install -r requirements.txt
else
  log "⚠️ requirements.txt not found — skipping."
fi

log "Installing PyTorch (CUDA 11.7 build)..."
python3 -m pip install torch==2.7.1+cu117 torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu117

export PYTORCH_ENABLE_MPS_FALLBACK=1
export PYTORCH_MPS_HIGH_WATERMARK_RATIO=0.0

log "Launching Applio..."
python3 app.py --open
