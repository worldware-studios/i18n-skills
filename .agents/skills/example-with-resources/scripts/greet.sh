#!/usr/bin/env bash
set -euo pipefail

name="${1:-world}"
printf 'Hello, %s — from example-with-resources.\n' "$name"
