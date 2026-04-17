#!/bin/bash
# install.sh — Install the multi-agent development team into a project
#
# Usage:
#   ./install.sh /path/to/your/project
#   ./install.sh              # installs into current directory
#
# What it does:
# 1. Copies agent definitions into .claude/agents/
# 2. Copies skill definitions into .claude/skills/
# 3. Does NOT overwrite existing files (safe to re-run)
# 4. Does NOT touch settings.local.json, CLAUDE.md, or any other existing config

set -euo pipefail

TARGET="${1:-.}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ ! -d "$TARGET" ]; then
  echo "Error: $TARGET is not a directory"
  exit 1
fi

TARGET="$(cd "$TARGET" && pwd)"
CLAUDE_DIR="$TARGET/.claude"

echo "Installing dev team into: $TARGET"
echo ""

mkdir -p "$CLAUDE_DIR/agents"
mkdir -p "$CLAUDE_DIR/skills"
mkdir -p "$CLAUDE_DIR/context"

# Ensure context directory is gitignored
GITIGNORE="$TARGET/.gitignore"
if [ -f "$GITIGNORE" ]; then
  if ! grep -q '.claude/context/' "$GITIGNORE" 2>/dev/null; then
    echo "" >> "$GITIGNORE"
    echo "# Agent working memory (machine-local, not shared)" >> "$GITIGNORE"
    echo ".claude/context/" >> "$GITIGNORE"
    echo "  ADD   .gitignore entry for .claude/context/"
  fi
else
  echo "# Agent working memory (machine-local, not shared)" > "$GITIGNORE"
  echo ".claude/context/" >> "$GITIGNORE"
  echo "  ADD   .gitignore with .claude/context/"
fi

# Copy agents
for agent_file in "$SCRIPT_DIR/agents/"*.md; do
  [ -f "$agent_file" ] || continue
  filename=$(basename "$agent_file")
  dest="$CLAUDE_DIR/agents/$filename"
  if [ -f "$dest" ]; then
    echo "  SKIP  agents/$filename (already exists)"
  else
    cp "$agent_file" "$dest"
    echo "  ADD   agents/$filename"
  fi
done

# Copy skills (recursively)
for skill_dir in "$SCRIPT_DIR/skills/"*/; do
  [ -d "$skill_dir" ] || continue
  skill_name=$(basename "$skill_dir")
  dest_dir="$CLAUDE_DIR/skills/$skill_name"
  if [ -d "$dest_dir" ]; then
    echo "  SKIP  skills/$skill_name/ (already exists)"
  else
    cp -r "$skill_dir" "$dest_dir"
    echo "  ADD   skills/$skill_name/"
  fi
done

echo ""
echo "Done. Available commands:"
echo ""
echo "  /dev-team <task>          Full team orchestration"
echo "  /dev-backend <task>       Backend specialist"
echo "  /dev-frontend <task>      Frontend specialist"
echo "  /dev-ux <task>            UX design review"
echo "  /dev-infra <task>         Infrastructure & DevOps"
echo "  /dev-architecture <task>  System architecture review"
echo "  /dev-qa <task>            Quality assurance & testing"
echo "  /dev-product <task>       Product thinking & requirements"
echo ""
echo "Tip: Ensure your project has a comprehensive CLAUDE.md —"
echo "     all agents read it as their first step."
