#!/bin/bash
# install.sh — Install or update the multi-agent development team into a project
#
# Usage:
#   ./install.sh /path/to/project           # First install (skips existing files)
#   ./install.sh --update /path/to/project   # Update existing files with latest templates
#   ./install.sh --update                    # Update in current directory
#
# First install: adds files, never overwrites
# Update mode:   replaces agents/ and skills/ with latest templates
#                 preserves .claude/context/ (working memory) untouched

set -euo pipefail

UPDATE=false
if [ "${1:-}" = "--update" ]; then
  UPDATE=true
  shift
fi

TARGET="${1:-.}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ ! -d "$TARGET" ]; then
  echo "Error: $TARGET is not a directory"
  exit 1
fi

TARGET="$(cd "$TARGET" && pwd)"
CLAUDE_DIR="$TARGET/.claude"

if $UPDATE; then
  echo "Updating dev team in: $TARGET"
else
  echo "Installing dev team into: $TARGET"
fi
echo ""

mkdir -p "$CLAUDE_DIR/agents"
mkdir -p "$CLAUDE_DIR/skills"
mkdir -p "$CLAUDE_DIR/context"

# Ensure local-only directories are gitignored
GITIGNORE="$TARGET/.gitignore"
add_gitignore_entry() {
  local pattern="$1"
  local comment="$2"
  if [ -f "$GITIGNORE" ]; then
    if ! grep -q "$pattern" "$GITIGNORE" 2>/dev/null; then
      echo "" >> "$GITIGNORE"
      [ -n "$comment" ] && echo "# $comment" >> "$GITIGNORE"
      echo "$pattern" >> "$GITIGNORE"
      echo "  ADD   .gitignore entry for $pattern"
    fi
  else
    [ -n "$comment" ] && echo "# $comment" > "$GITIGNORE"
    echo "$pattern" >> "$GITIGNORE"
    echo "  ADD   .gitignore with $pattern"
  fi
}

add_gitignore_entry ".claude/context/" "Agent working memory (machine-local, not shared)"
add_gitignore_entry ".claude/plans/" "Implementation plans (machine-local, not shared)"

# Copy agents
for agent_file in "$SCRIPT_DIR/agents/"*.md; do
  [ -f "$agent_file" ] || continue
  filename=$(basename "$agent_file")
  dest="$CLAUDE_DIR/agents/$filename"
  if [ -f "$dest" ] && ! $UPDATE; then
    echo "  SKIP  agents/$filename (use --update to replace)"
  else
    cp "$agent_file" "$dest"
    if $UPDATE; then
      echo "  UPDATE  agents/$filename"
    else
      echo "  ADD     agents/$filename"
    fi
  fi
done

# Copy skills (recursively)
for skill_dir in "$SCRIPT_DIR/skills/"*/; do
  [ -d "$skill_dir" ] || continue
  skill_name=$(basename "$skill_dir")
  dest_dir="$CLAUDE_DIR/skills/$skill_name"
  if [ -d "$dest_dir" ] && ! $UPDATE; then
    echo "  SKIP  skills/$skill_name/ (use --update to replace)"
  else
    rm -rf "$dest_dir"
    cp -r "$skill_dir" "$dest_dir"
    if $UPDATE; then
      echo "  UPDATE  skills/$skill_name/"
    else
      echo "  ADD     skills/$skill_name/"
    fi
  fi
done

echo ""
echo "Done. Available commands:"
echo ""
echo "  /dev-setup                 Onboard: reads project, asks questions, prefills context"
echo "  /dev-team <task>          Team orchestration (implement + quick verify)"
echo "  /dev-team-full <task>     Full flow: implement → review → iterate (max 3 rounds)"
echo "  /dev-grill <plan>         Stress-test a plan from every angle"
echo "  /dev-backend <task>       Backend specialist"
echo "  /dev-frontend <task>      Frontend specialist"
echo "  /dev-ux <task>            UX design review"
echo "  /dev-infra <task>         Infrastructure & DevOps"
echo "  /dev-architecture <task>  System architecture review"
echo "  /dev-qa <task>            Quality assurance & testing"
echo "  /dev-product <task>       Product thinking & requirements"
echo ""
if $UPDATE; then
  echo "Templates updated. Context files (.claude/context/) preserved."
else
  echo "Next step: run /dev-setup in Claude Code to onboard the team."
  echo "It reads your project, asks a few questions, and prefills all"
  echo "agent context files so everything starts fast."
fi
