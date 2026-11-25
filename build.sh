#!/usr/bin/env bash
set -euo pipefail

TEMPLATE_NAME="han"
TEMPLATE_BUNDLE="${TEMPLATE_NAME}.iatemplate"
TEMPLATE_ZIP="${TEMPLATE_NAME}.iatemplate.zip"

if [[ ! -d "${TEMPLATE_BUNDLE}" ]]; then
    printf 'Missing %s\n' "${TEMPLATE_BUNDLE}" >&2
    exit 1
fi

python3 - "${TEMPLATE_BUNDLE}/Contents/Info.plist" <<'PY'
import plistlib
import sys
from pathlib import Path

plist_path = Path(sys.argv[1])
with plist_path.open("rb") as plist_file:
    plistlib.load(plist_file)

print(f"Validated {plist_path}")
PY

rm -f "${TEMPLATE_ZIP}"

zip -r -X -q "${TEMPLATE_ZIP}" "${TEMPLATE_BUNDLE}"

printf 'Built %s\n' "${TEMPLATE_ZIP}"
