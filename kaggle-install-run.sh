#!/bin/bash
set -e  # exit on any error

printf "\033]0;Kaggle Applio Installer\007"
clear

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"; }

# 1) FFmpeg
log "Installing FFmpeg..."
apt-get update -y
apt-get install -y ffmpeg

# 2) pip + python-ffmpeg
log "Upgrading pip and installing python-ffmpeg..."
python3 -m pip install --upgrade pip
pip install python-ffmpeg

# 3) requirements.txt
if [ -f requirements.txt ]; then
  log "Installing from requirements.txt..."
  pip install -r requirements.txt
else
  log "⚠️ requirements.txt not found—skipping."
fi

# 4) CPU‑only PyTorch
log "Installing CPU‑only PyTorch 2.7.1..."
pip install torch==2.7.1 torchvision==0.22.1 torchaudio==2.7.1

# 5) (Optional) MPS fallback env vars
export PYTORCH_ENABLE_MPS_FALLBACK=1
export PYTORCH_MPS_HIGH_WATERMARK_RATIO=0.0

# 6) Launch
log "Starting Applio..."
python3 app.py --share --open
