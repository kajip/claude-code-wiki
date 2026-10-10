---
type: concept
title: auto mode（権限の自動判定）
updated: 2026-10-10
sources:
  - sources/engineering/2026-03-25-claude-code-auto-mode
  - sources/engineering/2026-05-25-how-we-contain-claude
  - sources/claude-dev/2026-10-06-claude-code-in-the-cloud
  - sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296
  - sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09
---

# auto mode

## 概要

Claude Code の承認を、人ではなくモデルベースの分類器に任せるモード。手動承認と `--dangerously-skip-permissions` の中間にあたる（[[sources/engineering/2026-03-25-claude-code-auto-mode]]）。設計の一次情報は2026-03-25の Engineering 記事だけで、docs の auto mode ページはまだ取り込んでいない。

## 現状（as of 2026-10-10）

設計の記述は2026-03-25の記事に基づく。数値とモデルは「公開時点の値」で、現行の値は未確認。

- 2層: 入力側の prompt-injection probe と、出力側の transcript classifier（[[sources/engineering/2026-03-25-claude-code-auto-mode]]）。
- 分類器は2段（単一トークンのフィルタ→必要時のみ推論）。ユーザーのメッセージとツール呼び出しだけを見る。公開時点では Sonnet 4.6 で動いていた（同）。
- 判定は3層。安全ツールの許可リストとユーザー設定、プロジェクト内のファイル操作、分類器の順。入るとき、任意コード実行を許す広い許可ルールは外される（同）。
- 設定は3つの枠（environment、block rules、allow exceptions）。`claude auto-mode defaults` で既定を確認できる（同）。
- 公開時点の性能: 実トラフィックの FPR 0.4%、実 overeager の FNR 17%、合成 exfil の FNR 5.7%。著者は、慎重に手動承認している人にとっては退行になりうるとしている（同）。
- 拒否後は別の手を探させ、連続3回または合計20回でエスカレーション。headless（`claude -p`）では終了する（同）。
- サブエージェントの委任時と返却時にも分類器が働く（同）。→ [[concepts/subagents]]
- cloud sessions の承認モードは Auto、Accept edits、Plan だけ（[[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]]）。→ [[concepts/cloud-sessions]]
- Managed Agents の権限ポリシー `auto` も、サーバーが各呼び出しを判定する。Claude Code の auto mode との実装上の関係は出典に記述が無い（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）。→ [[concepts/managed-agents]]
- 位置づけ（2026-05-25の記事）: 確率的な防御で取りこぼしがあるため、サンドボックス内の多層防御の一層であり代替ではない。当時の説明では overeager の約 83% を実行前に捕捉（FPR 0.4%、FNR 約 17% は3月の値と整合）。環境側の防御が使えない場面でモデル層が補う役割（[[sources/engineering/2026-05-25-how-we-contain-claude]]）。→ [[concepts/sandboxing]]

## 変更履歴

- 2026-10-07 — 2.1.292: auto mode が、ネットワーク（UNC）パスからのファイル読み込みで許可の確認を飛ばしていた問題を修正（Security）。同期間のバッチで、2.1.281 で入れた auto mode の拒否メッセージの変更を取り消し（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-09-10 — Managed Agents に権限ポリシー `auto` を追加（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）
- 2026-05-25 — 封じ込めの記事で、承認プロンプトの約 93% が承認されている（承認疲れ）ことを auto mode の動機として説明。自動化は取りこぼしがあるためサンドボックスと併用する位置づけ（[[sources/engineering/2026-05-25-how-we-contain-claude]]）
- 2026-03-25 — 設計と評価を Engineering 記事で公開。分類器は Sonnet 4.6、FPR 0.4%、overeager の FNR 17%（[[sources/engineering/2026-03-25-claude-code-auto-mode]]）

## 未解決・矛盾

- 公開時点（2026-03）の分類器のモデル・数値・既定の block rules が、現行（5.5 世代）でも同じかは未確認。docs の auto mode ページの Ingest で確かめる。
