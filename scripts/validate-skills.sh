#!/usr/bin/env bash
# Validate skills in this collection (frontmatter + layout heuristics).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_DIR="$ROOT/.agents/skills"
errors=0

if [[ ! -d "$SKILLS_DIR" ]]; then
  echo "error: missing $SKILLS_DIR" >&2
  exit 1
fi

shopt -s nullglob
skill_dirs=()
while IFS= read -r -d '' skill_md; do
  skill_dirs+=("$(dirname "$skill_md")")
done < <(find "$SKILLS_DIR" -type f -name SKILL.md -print0 | sort -z)

if (( ${#skill_dirs[@]} == 0 )); then
  echo "error: no SKILL.md files under $SKILLS_DIR" >&2
  exit 1
fi

echo "Checking ${#skill_dirs[@]} skill(s)..."

for dir in "${skill_dirs[@]}"; do
  folder="$(basename "$dir")"
  skill_md="$dir/SKILL.md"
  rel="${dir#"$ROOT"/}"

  # Extract frontmatter name (first name: line after opening ---)
  fm_name="$(awk '
    BEGIN { in_fm=0 }
    /^---[[:space:]]*$/ {
      if (in_fm == 0) { in_fm=1; next }
      else { exit }
    }
    in_fm && /^name:[[:space:]]*/ {
      sub(/^name:[[:space:]]*/, "")
      gsub(/^["'\'']|["'\'']$/, "")
      print
      exit
    }
  ' "$skill_md")"

  fm_desc="$(awk '
    BEGIN { in_fm=0; collecting=0; desc="" }
    /^---[[:space:]]*$/ {
      if (in_fm == 0) { in_fm=1; next }
      else { exit }
    }
    in_fm && collecting {
      if ($0 ~ /^[a-zA-Z0-9_-]+:/) { exit }
      line=$0
      sub(/^[[:space:]]*/, "", line)
      sub(/[[:space:]]*$/, "", line)
      if (desc != "") desc=desc " "
      desc=desc line
      next
    }
    in_fm && /^description:[[:space:]]*>?-?[[:space:]]*$/ {
      collecting=1
      next
    }
    in_fm && /^description:[[:space:]]*/ {
      sub(/^description:[[:space:]]*/, "")
      gsub(/^["'\'']|["'\'']$/, "")
      print
      exit
    }
    END { if (desc != "") print desc }
  ' "$skill_md")"

  if [[ -z "$fm_name" ]]; then
    echo "FAIL  $rel: missing name in frontmatter"
    errors=$((errors + 1))
    continue
  fi

  if [[ "$fm_name" != "$folder" ]]; then
    echo "FAIL  $rel: name '$fm_name' does not match folder '$folder'"
    errors=$((errors + 1))
  fi

  if [[ ! "$fm_name" =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then
    echo "FAIL  $rel: invalid name '$fm_name'"
    errors=$((errors + 1))
  fi

  if [[ -z "$fm_desc" ]]; then
    echo "FAIL  $rel: missing description in frontmatter"
    errors=$((errors + 1))
  elif (( ${#fm_desc} > 1024 )); then
    echo "FAIL  $rel: description exceeds 1024 characters"
    errors=$((errors + 1))
  fi

  lines="$(wc -l <"$skill_md" | tr -d ' ')"
  if (( lines > 500 )); then
    echo "WARN  $rel: SKILL.md has $lines lines (recommend ≤500)"
  fi

  if [[ "$fm_name" == "$folder" && -n "$fm_desc" ]]; then
    echo "OK    $rel"
  fi
done

# Prefer official validator when available
if command -v skills-ref >/dev/null 2>&1; then
  echo
  echo "Running skills-ref validate..."
  for dir in "${skill_dirs[@]}"; do
    if ! skills-ref validate "$dir"; then
      errors=$((errors + 1))
    fi
  done
else
  echo
  echo "Note: install skills-ref for full spec validation (optional)."
fi

if (( errors > 0 )); then
  echo
  echo "Validation failed with $errors error(s)."
  exit 1
fi

echo
echo "All skills passed basic validation."
