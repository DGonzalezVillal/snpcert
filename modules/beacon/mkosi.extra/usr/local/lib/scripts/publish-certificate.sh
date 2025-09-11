#!/usr/bin/bash
set -euo pipefail

CERT_FILE="$HOME/sev_certificate.txt"

# Determine OS name and version
if [ -f /etc/os-release ]; then
    # shellcheck disable=SC1091
    . /etc/os-release
    OS_NAME="${ID}"            # e.g., ubuntu, rhel, fedora
    OS_VERSION="${VERSION_ID}" # e.g., 22.04, 9.2
else
    OS_NAME="$(uname -s)"
    OS_VERSION=""
fi

# Get current date
TODAY=$(date +%Y-%m-%d)

# Build title
if [ -n "$OS_VERSION" ]; then
    TITLE="${OS_NAME} ${OS_VERSION} ${TODAY} SEV Certificate"
else
    TITLE="${OS_NAME} ${TODAY} SEV Certificate"
fi

# Call beacon
beacon --title "$TITLE" --body "$CERT_FILE"

echo "Published SEV certificate via beacon with title: $TITLE"