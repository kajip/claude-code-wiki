---
type: concept
title: エージェントの評価（evals）
updated: 2026-10-10
sources:
  - sources/engineering/2026-01-09-demystifying-evals-for-ai-agents
  - sources/claude-dev/2026-09-28-automating-eval-design-and-hillclimbing
  - sources/engineering/2026-02-05-infrastructure-noise
  - sources/engineering/2026-02-05-building-a-c-compiler-with-parallel-claudes
  - sources/engineering/2026-03-24-harness-design-long-running-apps
---

# エージェントの評価（evals）

## 概要

エージェントに入力を与え、採点ロジックで出力や環境の最終状態を測るテスト。ターンをまたいで状態を変えるエージェントは、単発の評価より難しい（[[sources/engineering/2026-01-09-demystifying-evals-for-ai-agents]]）。作り方の原則は上の記事に、Claude Code 上での自動化は `claude-api` スキルにある（[[sources/claude-dev/2026-09-28-automating-eval-design-and-hillclimbing]]）。

## 現状（as of 2026-10-10）

- 用語: task、trial、grader、transcript、outcome、evaluation harness、agent harness、evaluation suite。評価の対象はモデル単体ではなく、harness とモデルの組（[[sources/engineering/2026-01-09-demystifying-evals-for-ai-agents]]、2026-01-09 時点）。
- 採点器は code-based、model-based、human の3種類。決定的なものを優先し、経路ではなく成果物を採点する。部分点を入れる（[[sources/engineering/2026-01-09-demystifying-evals-for-ai-agents]]）。
- capability eval は低い合格率から始め、regression eval はほぼ100%を保つ。高くなった capability eval は regression へ移す（[[sources/engineering/2026-01-09-demystifying-evals-for-ai-agents]]）。
- 非決定性: pass@k と pass^k。顧客向けのように一貫性が要るときは pass^k（[[sources/engineering/2026-01-09-demystifying-evals-for-ai-agents]]）。
- 始め方: 実際の失敗から20〜50件。曖昧さのないタスクと参照解、双方向（するべき／すべきでない）のケース、各 trial のクリーンな環境、トランスクリプトを読む、飽和の監視（[[sources/engineering/2026-01-09-demystifying-evals-for-ai-agents]]）。
- 自動評価は、本番監視、A/B テスト、ユーザーフィードバック、人間によるレビューと組み合わせる（[[sources/engineering/2026-01-09-demystifying-evals-for-ai-agents]]）。
- 実行環境もスコアを左右する。Terminal-Bench 2.0 では資源の余裕の違いだけで最大 6 ポイント（p < 0.01）差が出た。タスク指定の約 3x までは主にインフラエラーが減り、それ以上は評価が測るものが変わる。保証量と上限を別々に指定して報告し、リーダーボードの 3 ポイント未満の差は設定が揃うまで懐疑的に見る（[[sources/engineering/2026-02-05-infrastructure-noise]]、2026-02-05 時点の値）。
- Claude Code では `/claude-api build-eval`（ケースの収集、採点器の選択、ベースライン診断）と `/claude-api hillclimb`（train と test に分けて1回に1修正）が使える（[[sources/claude-dev/2026-09-28-automating-eval-design-and-hillclimbing]]）。
- 自律エージェントでは、検証器がほぼ完全でないと、エージェントは誤った問題を解く。テストの出力は Claude が読む前提で設計する（2026-02-05 公開の事例）（[[sources/engineering/2026-02-05-building-a-c-compiler-with-parallel-claudes]]）。
- 自律エージェントの自己評価は甘くなりやすい。作る役と評価する役を分け、評価役を懐疑的に調整する方が扱いやすい。評価役は Playwright MCP で実アプリを操作させ、判断が人とずれた例を見て調整した。それでも深い機能の見落としが残った（2026-03-24 公開、Sonnet 4.5〜Opus 4.6 の時点）（[[sources/engineering/2026-03-24-harness-design-long-running-apps]]）。

## 変更履歴

- 2026-03-24 — 評価役（evaluator）の分離と、主観品質を採点基準で採点可能にする手法が公開された。モデル名は公開時点（[[sources/engineering/2026-03-24-harness-design-long-running-apps]]）
- 2026-09-28 — `/claude-api build-eval` と `hillclimb` による評価設計の自動化が示された（[[sources/claude-dev/2026-09-28-automating-eval-design-and-hillclimbing]]）
- 2026-02-05 — インフラ設定（資源の割り当てと強制方法）が評価スコアに与えるノイズが定量化された。数値は公開時点（[[sources/engineering/2026-02-05-infrastructure-noise]]）
- 2026-01-09 — 評価の用語、採点器、8段階の手順が整理された。記事中のモデル名と数値（Opus 4.5 の CORE-Bench 42%→95%、SWE-bench Verified 80%超など）は公開時点の値（[[sources/engineering/2026-01-09-demystifying-evals-for-ai-agents]]）

## 未解決・矛盾

- 2026-01 の記事が使う例のモデルは当時のもの。現行モデルでの数値は確認していない。
