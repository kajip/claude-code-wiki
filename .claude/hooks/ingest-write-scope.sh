#!/bin/bash
# PreToolUse hook for the wiki-ingest subagent: allow Write/Edit only under
# wiki/sources/ and wiki/concepts/. Shared files (index, log, status) are the
# main session's job, so concurrent ingests can't clobber them.
exec python3 -I -c '
import json, os, sys
root = os.path.realpath(os.environ.get("CLAUDE_PROJECT_DIR", os.getcwd()))
try:
    path = json.load(sys.stdin).get("tool_input", {}).get("file_path") or ""
except ValueError:
    path = ""
if path:
    full = os.path.normpath(os.path.join(root, path))
    for allowed in ("wiki/sources", "wiki/concepts"):
        if full.startswith(os.path.join(root, allowed) + os.sep):
            sys.exit(0)
sys.stderr.write(f"Blocked: wiki-ingest may write only under wiki/sources/ and wiki/concepts/ (got {path!r})\n")
sys.exit(2)
'
