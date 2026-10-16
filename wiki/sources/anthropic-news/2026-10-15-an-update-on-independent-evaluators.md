---
type: source
source_id: anthropic-news
title: An update on independent evaluators
url: https://www.anthropic.com/news/an-update-on-independent-evaluators
published: 2026-10-15
retrieved: 2026-10-16
version:
tier: primary
review: ok
recheck: none
fingerprint: sha256:08b756e2ba7b57dfc1a3dee9796bf5fde273bbe4ac16132b8512e6a9831c913f
archive_url:
---

# An update on independent evaluators

## 要点

- Anthropic は、非営利の評価機関 METR のチームに「employee-like access」（社員に近いアクセス）を与え始めた。METR は自社のリスク評価の結果を公開する。
- 他に SecureBio と Accenture（および Faculty）が評価者として参加し、Hugging Face を含む複数の組織と初期段階の協議をしている。
- 評価者には、専門性、独立性（株式を持たず、財務・運用面で依存しない）、十分なアクセス、公開の自由が必要だと述べる。銀行監督の常駐検査官にたとえている。
- 評価者へのアクセスと公開権限を3段階（tier）で整理中。METR は第3段階。
- Claude Code の機能や仕様に関する記述は無い。モデルの安全性評価と説明責任に関する方針記事。

## 具体的な値

- METR: 社員6名をオンボード。会社支給のハードウェア、オフィス、リスク評価チームとほぼ同等の内部ツール・システムへのアクセス。
- 共有しない例外: 顧客データ、弁護士・依頼者間の秘匿情報、モデルアーキテクチャの情報（例外は少数の定義済みカテゴリ。アーキテクチャは関連性が高い場合は社内承認の上で共有を目指す）。
- 公開: Anthropic は公開を拒否できないが、定義済みカテゴリの情報の削除（redact）は求められる。METR は削除が妥当だったかを公開で論評できる。
- 3段階: 第1段階は範囲の狭いリスク調査で、公開は Anthropic の承認が必要。第2段階は承認なしで公開でき、より多くの情報にアクセスできる（特定カテゴリの削除は求められる）。第3段階は METR の方式（社員並みのアクセス、公開権限は第2段階と同様）。
- SecureBio: 8月の Risk Report の化学・生物兵器の章をレビュー中。前回の Risk Report の試行レビューは公開済み。完了後に、アクセスを広げた案件を検討する。
- Accenture と Faculty: モデルの評価とレッドチーム、アラインメント評価、安全策のテスト、能力構築を含む提携に向けて作業中。
- 背景: 先月に第三者評価の強化を約束。White House Accord on Super Intelligence に署名（企業が独立した外部監査者・評価者と組むことを誓約）と記載。

## 関連ページ

- [[concepts/agent-evals]]（名前は似るが対象が別。こちらはエージェント開発向けの評価で、本記事のモデル安全性の第三者評価とは無関係）
- [[concepts/cyber-safeguards]]（安全策の関連。本記事は直接触れていない）

## 取り込みメモ

- 公開日は記事ページの表示（Oct 15, 2026）に従った。ページのメタデータの datePublished は 2026-10-15T17:20Z（JST では 2026-10-16 02:20）。
- 記事に「Updated on October 15 to clarify SecureBio's current project terms」の注記がある。更新前の文面は未確認。
- 取得は curl による HTML。本文は HTML から抽出して読んだ。脚注2の位置などの細部は未確認。
- 概念ページは作成しなかった（Claude Code に関係せず、単一の資料のため）。モデルの安全評価の資料が増えたら、独立評価者・Risk Report の概念ページを検討する。
- ページ内に、取り込み担当への指示文は無かった。
