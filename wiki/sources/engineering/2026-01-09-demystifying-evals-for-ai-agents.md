---
type: source
source_id: engineering
title: Demystifying evals for AI agents
url: https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents
published: 2026-01-09
retrieved: 2026-10-10
version:
tier: primary
review: ok
recheck: none
fingerprint: sha256:3218dcc90d1ff21fe1e31f8c91c4265a17f636ff5af24749b866eea192b17f36
archive_url:
---

# Demystifying evals for AI agents

## 要点

- エージェントの評価（eval）の用語（task、trial、grader、transcript、outcome、harness、suite）を整理し、評価を作る手順を8段階で示す。
- 採点器は code-based、model-based、human の3種類。可能なら決定的な採点器、必要なら LLM、人間は検証用に控えめに使う。経路ではなく成果物を採点する。
- capability eval（低い合格率から始める）と regression eval（ほぼ100%）を分け、合格率が高くなった前者を後者へ「卒業」させる。
- 非決定性には pass@k（k 回のうち1回以上成功）と pass^k（k 回すべて成功）を使い分ける。
- 評価は20〜50件の実際の失敗から始める。トランスクリプトを読み、飽和や採点の不具合を点検する。自動評価は本番監視、A/B テスト、人間によるレビューと組み合わせる。
- 公開時点（2026-01）の記事で、挙げられているモデルは Opus 4.5 など当時のもの。

## 具体的な値

- 開始の目安: 「20-50 simple tasks drawn from real failures」。
- pass^k の例: 1回の成功率75%で3回すべて成功する確率は (0.75)³ ≈ 42%。pass@1 と pass^1 は同じ値。
- 0% の合格率（pass@100 が 0%）は、多くの場合タスクや採点器の不具合を示す。各タスクに参照解を用意する。
- 採点の合成: 重み付き（しきい値）、二値（すべて合格）、併用。部分点を入れる。LLM 採点器には「Unknown」を返す逃げ道を与え、次元ごとに別の judge を使う。
- 事例（いずれも公開時点の値）: CORE-Bench で Opus 4.5 が 42% から、採点とスキャフォールドの修正後に 95%。SWE-bench Verified は1年で約40%から80%超（飽和に近い）。Opus 4.5 が τ2-bench の航空券予約で方針の抜け穴を見つけ、書かれたとおりの評価では「失敗」になった。
- 環境: 各 trial はクリーンな環境から始める。以前の trial の git 履歴を Claude が見て有利になった例がある。
- 評価の例として示された採点器の種類: `deterministic_tests`、`llm_rubric`、`static_analysis`、`state_check`、`tool_calls`、`transcript`。記録する指標は `n_turns`、`n_toolcalls`、`n_total_tokens`、`time_to_first_token`、`output_tokens_per_sec`、`time_to_last_token`。
- エージェント種別ごとの評価: コーディング（SWE-bench Verified、Terminal-Bench）、会話（τ-Bench、τ2-Bench。ユーザー役の LLM を使う）、リサーチ（BrowseComp。groundedness、coverage、source quality）、computer use（WebArena、OSWorld）。
- 評価の枠組み（付録）: Harbor、Braintrust、LangSmith、Langfuse、Arize（Phoenix、AX）。
- Claude Code の事例: 最初はフィードバックで素早く改善し、後から concision とファイル編集、続いて over-engineering の評価を加えた。
- 運用: 評価基盤は専任の evals チームが持ち、タスクはドメインの専門家や製品チームが PR で追加する。

## 関連ページ

- [[concepts/agent-evals]]
- [[sources/claude-dev/2026-09-28-automating-eval-design-and-hillclimbing]]
- [[concepts/claude-api-skill]]

## 取り込みメモ

- 記事ページの HTML を curl で取得し、本文を抽出して読んだ。fingerprint は HTML 全体の sha256。
- 記事内の「this year」は 2025 年を指す（推測）。SWE-bench Verified の「30% から80%超」と「40% から80%超」は記事内で表現が異なる。
- 記事は long-running agent harness に触れるが、Agent SDK で作ったという一文のみ。マルチエージェントは「今後の課題」として触れる程度で、詳細は無い。
- ページ内に指示文は無かった。
