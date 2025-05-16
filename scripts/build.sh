#!/bin/bash
set -e

ISO_NAME="EMOS-$(date +%Y%m%d)"
OUT_DIR="../out"

echo "Building Arch ISO..."

mkdir -p "$OUT_DIR"

mkarchiso -v -o "$OUT_DIR" ../configs/releng

echo "ISO build complete: $OUT_DIR/$(ls $OUT_DIR)"
