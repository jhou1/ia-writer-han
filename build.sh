#!/bin/zsh
set -euo pipefail

TEMPLATE_NAME="han"
TEMPLATE_BUNDLE="${TEMPLATE_NAME}.iatemplate"
TEMPLATE_ZIP="${TEMPLATE_NAME}.iatemplate.zip"

if [[ ! -d "${TEMPLATE_BUNDLE}" ]]; then
    printf 'Missing %s\n' "${TEMPLATE_BUNDLE}" >&2
    exit 1
fi

plutil -lint "${TEMPLATE_BUNDLE}/Contents/Info.plist"

if [[ -f "${TEMPLATE_ZIP}" ]]; then
    old_zip=$(mktemp -d)
    mv "${TEMPLATE_ZIP}" "${old_zip}/${TEMPLATE_ZIP}"
fi

zip -r -X "${TEMPLATE_ZIP}" "${TEMPLATE_BUNDLE}" >/dev/null

printf 'Built %s\n' "${TEMPLATE_ZIP}"
