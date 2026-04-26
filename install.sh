#!/bin/bash
set -euo pipefail

SKILL_DIR="$HOME/.copilot/skills/nodejs-repo-template"
REPO_URL="https://raw.githubusercontent.com/vladislavs-luminati/gh-node-tpl/main/SKILL.md"

mkdir -p "$SKILL_DIR"

# If running locally with SKILL.md next to the script, copy it; otherwise download
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || echo "")"
if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/SKILL.md" ]; then
    cp "$SCRIPT_DIR/SKILL.md" "$SKILL_DIR/SKILL.md"
else
    curl --proto =https -fsSL "$REPO_URL" -o "$SKILL_DIR/SKILL.md"
fi

echo "Installed to $SKILL_DIR/SKILL.md"

# Auto-register in VS Code Copilot chat instructions
case "$(uname -s)" in
    Darwin)  SETTINGS_DIR="${HOME}/Library/Application Support/Code/User" ;;
    Linux)   SETTINGS_DIR="${HOME}/.config/Code/User" ;;
    MINGW*|MSYS*|CYGWIN*) SETTINGS_DIR="${APPDATA}/Code/User" ;;
    *)       SETTINGS_DIR="" ;;
esac
SETTINGS_FILE="${SETTINGS_DIR:+$SETTINGS_DIR/settings.json}"

SKILL_ENTRY='{"text":"Always check if any skills apply. Available skills:\\n<skill>\\n<name>nodejs-repo-template</name>\\n<description>Scaffold a production-ready Node.js GitHub repository. Triggers: new node project, scaffold nodejs, create repo template, nodejs template.</description>\\n<file>~/.copilot/skills/nodejs-repo-template/SKILL.md</file>\\n</skill>"}'

if [ -n "$SETTINGS_FILE" ] && [ -f "$SETTINGS_FILE" ] && command -v node >/dev/null 2>&1; then
    KEY="github.copilot.chat.codeGeneration.instructions"
    if ! grep -q "nodejs-repo-template" "$SETTINGS_FILE" 2>/dev/null; then
        SETTINGS_FILE="$SETTINGS_FILE" KEY="$KEY" SKILL_ENTRY="$SKILL_ENTRY" node -e "
const fs = require('fs');
const f = process.env.SETTINGS_FILE;
const s = JSON.parse(fs.readFileSync(f, 'utf8'));
const key = process.env.KEY;
if (!s[key]) s[key] = [];
s[key].push(JSON.parse(process.env.SKILL_ENTRY));
fs.writeFileSync(f, JSON.stringify(s, null, 2) + '\n');
console.log('Registered in VS Code settings.');
"
    else
        echo "Already registered in VS Code settings."
    fi
else
    echo ""
    echo "Could not auto-register. Add this manually to VS Code settings.json:"
    echo "  \"github.copilot.chat.codeGeneration.instructions\":"
    echo ""
    cat <<'SNIPPET'
<skill>
  <name>nodejs-repo-template</name>
  <description>Scaffold a production-ready Node.js GitHub repository. Triggers: 'new node project', 'scaffold nodejs', 'create repo template', 'nodejs template'.</description>
  <file>~/.copilot/skills/nodejs-repo-template/SKILL.md</file>
</skill>
SNIPPET
fi
