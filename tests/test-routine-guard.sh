#!/bin/bash
# Tests for .claude/hooks/routine-guard.sh (exit 0 = allow, exit 2 = block)
set -u
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
HOOK="$ROOT/.claude/hooks/routine-guard.sh"
fail=0
run() { # expected_exit description routine_flag tool_name command
  local input out
  input=$(jq -cn --arg t "$4" --arg c "$5" '{tool_name:$t, tool_input:{command:$c}}')
  if [ -n "$3" ]; then
    printf '%s' "$input" | WIKI_ROUTINE="$3" "$HOOK" >/dev/null 2>&1
  else
    printf '%s' "$input" | env -u WIKI_ROUTINE "$HOOK" >/dev/null 2>&1
  fi
  out=$?
  if [ "$out" -ne "$1" ]; then echo "FAIL: $2 (got $out, want $1)"; fail=1; else echo "ok: $2"; fi
}
# Outside the routine the hook stays out of the way.
run 0 "local: push to main"               ""  Bash "git push origin main"
run 0 "local: merge PR via mcp"           ""  mcp__github__merge_pull_request ""
# Inside the routine: only a standalone push of a claude/ branch.
run 0 "routine: push claude branch"       1   Bash "git push -u origin claude/daily-2026-10-17"
run 0 "routine: push claude branch (no -u)" 1 Bash "git push origin claude/daily-2026-10-17"
run 2 "routine: push main"                1   Bash "git push origin main"
run 2 "routine: bare push"                1   Bash "git push"
run 2 "routine: force push claude"        1   Bash "git push -f origin claude/daily-2026-10-17"
run 2 "routine: force-with-lease"         1   Bash "git push --force-with-lease origin claude/x"
run 2 "routine: refspec to main"          1   Bash "git push origin claude/x:main"
run 2 "routine: HEAD to main"             1   Bash "git push origin HEAD:main"
run 2 "routine: delete via colon"         1   Bash "git push origin :claude/x"
run 2 "routine: chained after commit"     1   Bash "git commit -m x && git push origin claude/x"
run 2 "routine: git -C push"              1   Bash "git -C . push origin main"
run 2 "routine: push two refs"            1   Bash "git push origin claude/x main"
run 0 "routine: commit only"              1   Bash "git commit -m 'chore: x'"
run 0 "routine: unrelated command"        1   Bash "grep -n push wiki/log.md"
run 0 "routine: mcp create PR"            1   mcp__github__create_pull_request ""
run 0 "routine: mcp read"                 1   mcp__github__get_pull_request ""
run 0 "routine: mcp list"                 1   mcp__github__list_commits ""
run 2 "routine: mcp merge PR"             1   mcp__github__merge_pull_request ""
run 2 "routine: mcp push files"           1   mcp__github__push_files ""
run 2 "routine: mcp update file"          1   mcp__github__create_or_update_file ""
exit $fail
