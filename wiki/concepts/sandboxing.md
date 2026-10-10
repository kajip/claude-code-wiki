---
type: concept
title: サンドボックスと隔離（封じ込め）
updated: 2026-10-10
sources:
  - sources/engineering/2026-05-25-how-we-contain-claude
  - sources/engineering/2026-04-08-scaling-managed-agents
---

# サンドボックスと隔離（封じ込め）

## 概要

エージェントが「何をするか」ではなく「何ができるか」を、環境側の境界で制限する考え方と実装（[[sources/engineering/2026-05-25-how-we-contain-claude]]）。承認ダイアログでの監督は疲れで形骸化するため、封じ込めを先に設計し、モデル側の防御は補助とする（同）。

## 現状（as of 2026-10-10）

docs のサンドボックスページと Cowork の docs はまだ取り込んでいない。以下は2026-05-25時点の記述で、現行の仕様は未確認。

- 製品ごとの型（公開時点）: claude.ai は gVisor の使い捨てコンテナ、Claude Code は OS レベルのサンドボックス＋人の承認、Cowork はローカル VM（[[sources/engineering/2026-05-25-how-we-contain-claude]]）。
- Claude Code のサンドボックス（公開時点）: macOS は Seatbelt、Linux は bubblewrap。書き込みはワークスペース内、ネットワークは既定で拒否。権限プロンプトが 84% 減った。ランタイムは OSS（同）。
- リファレンス devcontainer は無人実行用（同）。
- 防御は環境、モデル、外部コンテンツの3要素に重ねる。モデル層（auto mode など）は確率的で 100% にならない（同）。→ [[concepts/auto-mode]]
- 設計上の教訓: 許可ドメインは「宛先フィルタ」ではなく「機能の付与」と考える。信頼ダイアログ前にプロジェクト設定を実行しない。symlink 解決をパス検証より先に行う。自前の部品が最も弱い（同）。
- 他の実装例: Managed Agents は sandbox を session、harness と分離し、認証情報を sandbox から届かない場所に置く（[[sources/engineering/2026-04-08-scaling-managed-agents]]）。→ [[concepts/managed-agents]]

## 変更履歴

- 2026-05-25 — 3製品の封じ込め設計と、見落とした4件のリスクを Engineering 記事で公開。Cowork は full-VM mode から、agent loop を VM 外に置く host mode へ移行済み（[[sources/engineering/2026-05-25-how-we-contain-claude]]）

## 未解決・矛盾

- 記事の数値（93%、84%、約0.1%／5〜6% など）と各製品の構成が現行でも同じかは未確認。docs のサンドボックス関連ページの Ingest で確かめる。
