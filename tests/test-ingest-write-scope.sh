#!/bin/bash
# Tests for .claude/hooks/ingest-write-scope.sh (exit 0 = allow, exit 2 = block)
set -u
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
HOOK="$ROOT/.claude/hooks/ingest-write-scope.sh"
fail=0
check() { # expected_exit description file_path
  local out
  printf '{"tool_name":"Write","tool_input":{"file_path":"%s"}}' "$3" | CLAUDE_PROJECT_DIR="$ROOT" "$HOOK" >/dev/null 2>&1
  out=$?
  if [ "$out" -ne "$1" ]; then echo "FAIL: $2 (got $out, want $1)"; fail=1; else echo "ok: $2"; fi
}
check 0 "source page"            "$ROOT/wiki/sources/claude-dev/2026-10-06-x.md"
check 0 "concept page"           "$ROOT/wiki/concepts/mods.md"
check 2 "CLAUDE.md"              "$ROOT/CLAUDE.md"
check 2 "index.md"               "$ROOT/wiki/index.md"
check 2 "log.md"                 "$ROOT/wiki/log.md"
check 2 "outside project"        "/tmp/evil.md"
check 2 "path traversal"         "$ROOT/wiki/sources/../log.md"
check 2 "relative path escape"   "wiki/concepts/../../CLAUDE.md"
check 0 "relative concept path"  "wiki/concepts/mods.md"
check 2 "empty path"             ""
exit $fail
