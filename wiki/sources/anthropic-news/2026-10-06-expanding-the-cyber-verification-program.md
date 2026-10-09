---
type: source
source_id: anthropic-news
title: Expanding the Cyber Verification Program
url: https://www.anthropic.com/news/cyber-verification-program
published: 2026-10-06
retrieved: 2026-10-10
version:
tier: primary
review: ok
recheck: none
fingerprint:
archive_url:
---

# Expanding the Cyber Verification Program

## 要点

- Cyber Verification Program（CVP）を拡大し、Project Glasswing を統合した。アクセスの段階は3つ。
- どの段階でも、Opus 5.5、Sonnet 5.5、Mythos 5.1 を含む最上位のモデルが使える。
- 一般提供のモデルはサイバー関連の作業の多くをブロックする。CVP の各段階は、範囲に応じてそのブロックを緩める。
- 一般提供のモデルでも、コードレビュー、既知の問題の修正、セキュリティアラートの仕分けはできる。
- 参加する組織にはデータの保持が求められる（悪用の監視のため）。

## 具体的な値

- 段階: **Defense Access**（防御の作業。個人の研究者も対象）、**Red Team Access**（許可されたペネトレーションテスト。組織のみ）、**Specialized Access**（重要な安全系の試験。米国政府と一緒に審査）。
- 提供先: Claude Platform、Google Cloud Vertex AI、Microsoft Foundry。Amazon Bedrock は Enterprise Frontier Safeguards（EFS）の対象顧客だけ。
- CyScenarioBench（Opus 5.5、50試行）: CVP なしでは全件が最初のプロンプトでブロック。Defense Access では 46/50 がどこかでブロック。Red Team Access ではブロックが無く、34/50 を完了。
- Project Glasswing: 2026年4〜7月に、パートナーが少なくとも129,000件の脆弱性を確認した。

## 関連ページ

- [[concepts/cyber-safeguards]]

## 取り込みメモ

- 本文に Claude Code への言及は無い。
