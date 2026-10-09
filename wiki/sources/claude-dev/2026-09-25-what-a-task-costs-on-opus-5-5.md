---
type: source
source_id: claude-dev
title: What a task costs on Opus 5.5
url: https://claude.dev/blog/what-a-task-costs-on-opus-5-5/
published: 2026-09-25
retrieved: 2026-10-10
version: 2.1.280
tier: primary
review: ok
recheck: none
fingerprint:
archive_url:
---

# What a task costs on Opus 5.5

## 要点

- 定価の計算で、Opus 5.5 のタスク単価を Opus 5 と比べる。同じトークン量でも約31%安く、トークンの使用量が減る分を含めると、ふだんの作業で約40%安い（推定）。
- 費用の多くはキャッシュ読み取りにかかるので、キャッシュを温かく保つのが効く。長く間を空けない、途中でモデルを変えない、MCP を後からつながない。
- effort を変えてもキャッシュが残るのは API キーとサブスクリプションの場合。Bedrock、Google Cloud、ゲートウェイでは消える。
- 推奨: 普段は Opus 5.5 の medium を使い、行き詰まったら high、機械的な編集は low。検索やログの読み取りをするサブエージェントには Sonnet か Haiku を使う。

## 具体的な値

- Opus 5.5 には Claude Code **v2.1.280 以降**が必要。
- Claude Code での Opus 5.5 の既定の effort: medium。
- Fable 5.1: 入力 $10、出力 $50、キャッシュ読み取り $0.25。
- fast mode（Opus 5.5）: 2.5倍速く、2倍の価格（入力 $8、出力 $40）。
- キャッシュ書き込みは、5分キャッシュで入力の1.25倍、1時間キャッシュで2倍。
- Pro、Max、Team では、値下げの分だけ利用上限が Opus 5 より約25%長持ちする。
- Enterprise の目安: 稼働日1日あたり開発者1人約 $13。90%の利用者は $30 未満。
- コマンド: `/effort low|medium|high|xhigh|max`、`/effort status`、`/model`、`/usage`、`/cost`、`/compact [note]`、`/clear`、`/rewind`、`/autocompact <tokens>`、`/mcp`、`/claude-api prompt-audit`、`/feedback`
- 環境変数 `CLAUDE_CODE_SUBAGENT_MODEL`（サブエージェント定義の `model:` の方が優先される）。エイリアス `opusplan`。
- CLAUDE.md はおよそ200行以内に保つことを推奨。

## 関連ページ

- [[concepts/claude-opus-5-5]]
- [[concepts/prompt-caching]]
- [[concepts/effort]]
- [[concepts/fast-mode]]
- [[concepts/subagents]]

## 取り込みメモ

- 金額は定価から作った例示（キャッシュ書き込みは除く）。
