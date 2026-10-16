#!/bin/bash
# PreToolUse hook: in the cloud routine (WIKI_ROUTINE set on its environment),
# allow git pushes only as a standalone push of one claude/ branch, and allow
# only read and create-PR tools from the GitHub MCP server. The routine reads
# the repo settings but not .claude/settings.local.json, so the "ask before
# git push" rule lives there and this hook is the routine's guard for main.
[ -z "${WIKI_ROUTINE:-}" ] && exit 0
exec python3 -I -c '
import json, re, sys
try:
    data = json.load(sys.stdin)
except ValueError:
    data = {}
tool = data.get("tool_name") or ""
def block(reason):
    sys.stderr.write(f"Blocked by routine-guard: {reason}\n")
    sys.exit(2)
if tool.startswith("mcp__github__"):
    name = tool[len("mcp__github__"):]
    if name == "create_pull_request" or name.startswith(("get_", "list_", "search_")):
        sys.exit(0)
    block(f"GitHub tool {name} is not allowed in the routine; push a claude/ branch and open a PR instead")
if tool == "Bash":
    cmd = (data.get("tool_input") or {}).get("command") or ""
    if re.search(r"\bgit\b.*\bpush\b", cmd, re.S):
        if not re.fullmatch(r"\s*git push (-u )?origin claude/[A-Za-z0-9._/-]+\s*", cmd):
            block("in the routine, run `git push -u origin claude/<branch>` on its own (no other refs, flags or chained commands)")
sys.exit(0)
'
