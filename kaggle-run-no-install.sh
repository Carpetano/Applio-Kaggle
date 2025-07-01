#!/bin/bash
set -e  # Exit on any error

printf "\033]0;Kaggle Applio Launcher\007"
clear

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"; }

# Environment variables for optional fallback (if using MPS)
export PYTORCH_ENABLE_MPS_FALLBACK=1
export PYTORCH_MPS_HIGH_WATERMARK_RATIO=0.0

# Launch Applio
log "Starting Applio..."
python3 app.py --share --open
