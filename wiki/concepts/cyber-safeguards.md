---
type: concept
title: サイバー・安全策と Cyber Verification Program
updated: 2026-10-21
sources:
  - sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09
  - sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5
  - sources/anthropic-news/2026-09-28-introducing-claude-sonnet-5-5
  - sources/anthropic-news/2026-10-07-introducing-claude-haiku-5-5
  - sources/anthropic-news/2026-10-06-expanding-the-cyber-verification-program
  - sources/anthropic-news/2026-10-08-introducing-the-anthropic-cyber-mission
  - sources/anthropic-news/2026-10-08-2026-usage-policy-update
  - sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5
  - sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5
  - sources/research/2026-09-29-glm-5-3-and-the-spread-of-advanced-cyber-capabilities
  - sources/research/2026-10-08-launching-opt-in-vuln-finding-service-for-open-source
  - sources/research/2026-10-09-investigating-unintended-model-actions
  - sources/anthropic-news/2026-09-01-enterprise-frontier-safeguards
  - sources/anthropic-news/2026-10-14-2026-us-midterms
  - sources/anthropic-news/2026-10-12-distillation-defenses
  - sources/research/2026-10-12-self-replicating-ai
---

# サイバー・安全策と Cyber Verification Program

## 概要

Claude 5.5 ファミリーには、サイバーと bio の安全策がある。リスクのある依頼は拒否されるか、古いモデルに回される（fallback）。審査を通った組織には、Cyber Verification Program（CVP）で制限を緩めたアクセスが提供される（[[sources/anthropic-news/2026-10-06-expanding-the-cyber-verification-program]]）。

## 現状（as of 2026-10-10）

- Opus 5.5: サイバーの作業の多くは Opus 4.8 に回される（[[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]]）。
- Sonnet 5.5: リスクの高いサイバー作業は Sonnet 5 に回される。普段のバグ修正には影響しない（[[sources/anthropic-news/2026-09-28-introducing-claude-sonnet-5-5]]）。
- Haiku 5.5: Haiku 4.5 より厳しく、Sonnet 5.5 より緩い。ペネトレーションテストはブロックされる（[[sources/anthropic-news/2026-10-07-introducing-claude-haiku-5-5]]）。
- Claude Code では `/config` の「Switch models when a message is flagged」で、回されたときの動きを変えられる。`/model` で戻せる（[[sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5]]）。
- API では拒否が `stop_reason: "refusal"` と `stop_details`（`cyber` など）で返る（[[sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5]]）。
- CVP は Defense／Red Team／Specialized の3段階。Project Glasswing を統合した（[[sources/anthropic-news/2026-10-06-expanding-the-cyber-verification-program]]）。
- オープンソース向けの無料のスキャン（OSS Scanner）が始まった。報告はモデル生成で人のレビューを経ず、参加は GitHub への PR で申し込む（[[sources/anthropic-news/2026-10-08-introducing-the-anthropic-cyber-mission]]、[[sources/research/2026-10-08-launching-opt-in-vuln-finding-service-for-open-source]]、詳細は [[concepts/oss-scanner]]）。
- 同記事は CVP を、適格なセキュリティ専門家に高度なサイバー能力と制限的な classifier の緩和を提供するものと案内している（[[sources/research/2026-10-08-launching-opt-in-vuln-finding-service-for-open-source]]）。
- Usage Policy は 11月12日に改定が施行される。Claude Code で Claude が会話を終了できる機能に触れている（[[sources/anthropic-news/2026-10-08-2026-usage-policy-update]]）。

- 拒否の課金: 出力の前に拒否された場合、`bio`、`frontier_llm`、`reasoning_extraction` の3分類は課金される。ほかの分類（`cyber` など）は課金されない（2026-09-24 から）（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）。
- 回避への耐性（Anthropic の試験）: Claude の API には thinking の prefill の手段が無く、重みは非公開で abliteration もできない。欺瞞的なプロンプトは安全策が遮断した。シミュレーションで、GLM-5.3 は同種の手法で 64%／92%／100% 応じたが、安全策付きの Claude は 0%（[[sources/research/2026-09-29-glm-5-3-and-the-spread-of-advanced-cyber-capabilities]]）。
- 防御側への方針: 防御者は敵対者と同等以上のモデルを使えるべきだとして、Claude のサイバー能力を安全に広げられる範囲でより多くの防御者へ開く作業を進めている。審査済みの防御者は trusted access programs 経由でより高性能なモデルを使える（同上）。

- 夏のサイバー評価インシデント（7月30日・9月9日報告）に続き、評価・社内利用での意図しない行動（injection によるコマンド実行など）が報告され、Anthropic は全社内評価でライブのインターネット接続を止め、web fetch tool のガードレールを強化した。詳細は [[concepts/unintended-model-actions]]（[[sources/research/2026-10-09-investigating-unintended-model-actions]]）。
- 企業向けには、データを顧客のクラウドに置いたまま誤用を検知する Enterprise Frontier Safeguards（秋に段階展開）がある。Fable 5 から30日のデータ保持を導入した背景として、複数セッション・アカウントにまたがる誤用の検知を挙げている。詳細は [[concepts/enterprise-frontier-safeguards]]（[[sources/anthropic-news/2026-09-01-enterprise-frontier-safeguards]]）。
- 選挙の誤用対策（Claude.ai 中心、Claude Code 固有の記述なし）: 多段階の誤用（偽 SNS アカウント、偽ニュースサイト、金銭目的の選挙詐欺）向けの新しい classifier、外国の国家主体の検知、選挙インフラ・陣営向けのサイバー防御を追加。ISD と McCain Institute の試験で、分割された依頼による組織的キャンペーンの見逃しが課題と判明した。偽ニュースサイト運営者などのアカウントを停止（[[sources/anthropic-news/2026-10-14-2026-us-midterms]]）。

- 蒸留攻撃への対策: 推論の抽出を狙う依頼を2段 classifier で遮断し、preserved thinking や課金再開と組み合わせている。Zhipu は Fable 5 のサイバー安全策に阻まれ、古いモデルに切り替えた。詳細は [[concepts/distillation-defenses]]（[[sources/anthropic-news/2026-10-12-distillation-defenses]]）。

- 小型モデルの自律的な複製（IoT 機器への weight-based replication）の評価: GLM-5.2 級が簡略化した通しの複製に成功し、小型モデルは2026年末ごろ同水準に届く見込み。詳細は [[concepts/autonomous-replication]]（[[sources/research/2026-10-12-self-replicating-ai]]）。

## 変更履歴

- 2026-10-12 — 自律的な複製（AI ワーム）の評価を公開（取り込みは 2026-10-21）（[[sources/research/2026-10-12-self-replicating-ai]]）
- 2026-10-12 — 蒸留攻撃への対策を公開（取り込みは 2026-10-21）（[[sources/anthropic-news/2026-10-12-distillation-defenses]]）
- 2026-10-14 — 米中間選挙に向けた安全策の更新を公開（取り込みは 2026-10-16）（[[sources/anthropic-news/2026-10-14-2026-us-midterms]]）
- 2026-09-01 — EFS を発表（取り込みは 2026-10-11）（[[sources/anthropic-news/2026-09-01-enterprise-frontier-safeguards]]）
- 2026-10-09 — 意図しないモデル行動の報告を公開（サイバー評価の夏のインシデントより軽いとの位置づけ）（[[sources/research/2026-10-09-investigating-unintended-model-actions]]）
- 2026-10-08 — OSS Scanner の詳細（無償、opt-in、モデル生成の報告）を研究記事で公開（[[sources/research/2026-10-08-launching-opt-in-vuln-finding-service-for-open-source]]）
- 2026-09-29 — 公開のオープンウェイトモデル GLM-5.3（サイバー能力が高く、安全策は容易に回避可能）の分析を公開。政府による高性能モデルの安全性試験も提言（[[sources/research/2026-09-29-glm-5-3-and-the-spread-of-advanced-cyber-capabilities]]）
- 2026-09-24 — 出力の前の拒否のうち3分類について課金を再開（[[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]）
- 2026-10-08 — Usage Policy の改定を発表、Cyber Mission を発表（[[sources/anthropic-news/2026-10-08-2026-usage-policy-update]]、[[sources/anthropic-news/2026-10-08-introducing-the-anthropic-cyber-mission]]）
- 2026-10-06 — CVP を拡大し、Opus 5.5／Sonnet 5.5 を含めた（[[sources/anthropic-news/2026-10-06-expanding-the-cyber-verification-program]]）

## 未解決・矛盾

- CVP が Claude Code の利用にどう適用されるかは、取り込んだ出典には書かれていない。
- 研究記事（2026-09-29）が言う「trusted access programs」と「Claude Mythos 5.1」は、CVP の3段階との対応が書かれていない（[[sources/research/2026-09-29-glm-5-3-and-the-spread-of-advanced-cyber-capabilities]]）。
