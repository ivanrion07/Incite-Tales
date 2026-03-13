#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOC_FILE="$SCRIPT_DIR/incitetales_idea2poc_master.txt"

if [[ ! -f "$DOC_FILE" ]]; then
  echo "Error: Document not found at $DOC_FILE" >&2
  exit 1
fi

echo "==============================================="
echo " INCITETALES IDEA2POC DOCUMENT RUNNER"
echo "==============================================="
echo
cat "$DOC_FILE"
