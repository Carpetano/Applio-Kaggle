#!/bin/bash
set -e  # exit on any error

printf "\033]0;Kaggle Applio Installer\007"
clear

# Logging helper
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

# 1) System dependencies
log "Installing FFmpeg (via apt)..."
apt-get update -y && apt-get install -y ffmpeg

# 2) Python dependencies
log "Upgrading pip and installing python-ffmpeg..."
python3 -m pip install --upgrade pip
pip install python-ffmpeg

# 3) Install Python packages from requirements.txt if present
if [ -f requirements.txt ]; then
  log "Installing requirements.txt dependencies..."
  pip install -r requirements.txt
else
  log "⚠️ requirements.txt not found — skipping."
fi

# 4) Install PyTorch (CPU-only for compatibility on Kaggle)
log "Installing PyTorch 2.7.1 (CPU version)..."
pip install torch==2.7.1 torchvision==0.22.1 torchaudio==2.7.1

# 5) Optional PyTorch env vars (mostly macOS-specific, but harmless)
export PYTORCH_ENABLE_MPS_FALLBACK=1
export PYTORCH_MPS_HIGH_WATERMARK_RATIO=0.0

# 6) Run Applio app
log "Starting Applio..."
python3 app.py --open
