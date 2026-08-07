#!/usr/bin/env bash
# Scaffold a new skill from templates/skill/
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TEMPLATE="$ROOT/templates/skill"
SKILLS_DIR="$ROOT/.agents/skills"

usage() {
  cat <<'EOF'
Usage: new-skill.sh <skill-name>

Creates .agents/skills/<skill-name>/ from templates/skill/.
Skill names: lowercase letters, numbers, hyphens; no leading/trailing or consecutive hyphens.
EOF
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" || $# -lt 1 ]]; then
  usage
  exit 0
fi

name="$1"

if [[ ! "$name" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then
  echo "error: invalid skill name '$name'" >&2
  echo "use lowercase letters, numbers, and single hyphens only" >&2
  exit 1
fi

if (( ${#name} > 64 )); then
  echo "error: skill name must be at most 64 characters" >&2
  exit 1
fi

dest="$SKILLS_DIR/$name"
if [[ -e "$dest" ]]; then
  echo "error: already exists: $dest" >&2
  exit 1
fi

mkdir -p "$dest"
cp -R "$TEMPLATE/." "$dest"

# Replace placeholder name in frontmatter and title
# portable sed: write to temp then move
tmp="$(mktemp)"
sed -e "s/^name: skill-name$/name: $name/" \
    -e "s/^# Skill Name$/# ${name}/" \
    "$dest/SKILL.md" >"$tmp"
mv "$tmp" "$dest/SKILL.md"

# Drop empty keep files if present (optional dirs stay)
find "$dest" -name .gitkeep -delete 2>/dev/null || true

echo "Created $dest"
echo "Next: edit $dest/SKILL.md and add a row to CATALOG.md"
