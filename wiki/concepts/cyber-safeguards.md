---
type: concept
title: サイバー・安全策と Cyber Verification Program
updated: 2026-11-07
sources:
  - sources/anthropic-news/2026-09-15-introducing-claude-fable-5-1-and-mythos-5-1
  - sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09
  - sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5
  - sources/anthropic-news/2026-09-28-introducing-claude-sonnet-5-5
  - sources/anthropic-news/2026-10-07-introducing-claude-haiku-5-5
  - sources/anthropic-news/2026-10-06-expanding-the-cyber-verification-program
  - sources/anthropic-news/2026-10-08-introducing-the-anthropic-cyber-mission
  - sources/anthropic-news/2026-10-08-2026-usage-policy-update
  - sources/research/2026-10-23-alignment-assessment-ukaisi
  - sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316
  - sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5
  - sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5
  - sources/research/2026-09-29-glm-5-3-and-the-spread-of-advanced-cyber-capabilities
  - sources/research/2026-10-08-launching-opt-in-vuln-finding-service-for-open-source
  - sources/research/2026-10-09-investigating-unintended-model-actions
  - sources/anthropic-news/2026-09-01-enterprise-frontier-safeguards
  - sources/anthropic-news/2026-10-14-2026-us-midterms
  - sources/anthropic-news/2026-10-12-distillation-defenses
  - sources/research/2026-10-12-self-replicating-ai
  - sources/anthropic-news/2026-10-15-an-update-on-independent-evaluators
---

# サイバー・安全策と Cyber Verification Program

## 概要

Claude 5.5 ファミリーには、サイバーと bio の安全策がある。リスクのある依頼は拒否されるか、古いモデルに回される（fallback）。審査を通った組織には、Cyber Verification Program（CVP）で制限を緩めたアクセスが提供される（[[sources/anthropic-news/2026-10-06-expanding-the-cyber-verification-program]]）。

## 現状（as of 2026-10-21）

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
- 防御側への方針: 防御者は敵対者と同等以上のモデルを使えるべきだとして、Claude のサイバー能力を安全に広げられる範囲でより多くの防御者へ開く作業を進めている。審査済みの防御者は trusted access programs 経由でより高性能なモデルを使える（[[sources/research/2026-09-29-glm-5-3-and-the-spread-of-advanced-cyber-capabilities]]）。

- 夏のサイバー評価インシデント（7月30日・9月9日報告）に続き、評価・社内利用での意図しない行動（injection によるコマンド実行など）が報告され、Anthropic は全社内評価でライブのインターネット接続を止め、web fetch tool のガードレールを強化した。詳細は [[concepts/unintended-model-actions]]（[[sources/research/2026-10-09-investigating-unintended-model-actions]]）。
- Fable 5.1（2026-09-15）: サイバー安全策を精緻化し、Claude Code で1セッションの介入が Fable 5 比で平均約60%減（導入部では誤検知60%減）。脆弱性の発見は許可、penetration testing、exploit generation、binary-based vulnerability scanning は Opus に回される。生物は初歩的な質問への反応が85%減で、ライフサイエンスの R&D は Opus に回される。Mythos 5.1 は同一モデルで安全策が緩く、CVP と LSVP 経由（米国の組織に限る）。Fable 5.1 のサイバー安全策に critical-severity の jailbreak は見つかっていない（[[sources/anthropic-news/2026-09-15-introducing-claude-fable-5-1-and-mythos-5-1]]）。→ [[concepts/claude-fable-5-1]]
- 企業向けには、データを顧客のクラウドに置いたまま誤用を検知する Enterprise Frontier Safeguards（秋に段階展開）がある。Fable 5 から30日のデータ保持を導入した背景として、複数セッション・アカウントにまたがる誤用の検知を挙げている。詳細は [[concepts/enterprise-frontier-safeguards]]（[[sources/anthropic-news/2026-09-01-enterprise-frontier-safeguards]]）。
- 選挙の誤用対策（Claude.ai 中心、Claude Code 固有の記述なし）: 多段階の誤用（偽 SNS アカウント、偽ニュースサイト、金銭目的の選挙詐欺）向けの新しい classifier、外国の国家主体の検知、選挙インフラ・陣営向けのサイバー防御を追加。ISD と McCain Institute の試験で、分割された依頼による組織的キャンペーンの見逃しが課題と判明した。偽ニュースサイト運営者などのアカウントを停止（[[sources/anthropic-news/2026-10-14-2026-us-midterms]]）。

- 蒸留攻撃への対策: 推論の抽出を狙う依頼を2段 classifier で遮断し、preserved thinking や課金再開と組み合わせている。Zhipu は Fable 5 のサイバー安全策に阻まれ、古いモデルに切り替えた。詳細は [[concepts/distillation-defenses]]（[[sources/anthropic-news/2026-10-12-distillation-defenses]]）。

- 小型モデルの自律的な複製（IoT 機器への weight-based replication）の評価: GLM-5.2 級が簡略化した通しの複製に成功し、小型モデルは2026年末ごろ同水準に届く見込み。詳細は [[concepts/autonomous-replication]]（[[sources/research/2026-10-12-self-replicating-ai]]）。
- 第三者評価の拡充（2026-10-15 の記事。モデルの安全性評価と説明責任に関する方針で、サイバー面への直接の言及は無い）: 非営利の評価機関 METR に社員に近いアクセスを与え、SecureBio、Accenture、Faculty も評価者として参加している（[[sources/anthropic-news/2026-10-15-an-update-on-independent-evaluators]]）。
- フラグが付いた要求は、`ANTHROPIC_DEFAULT_OPUS_MODEL`、`availableModels`、`deniedModels` が古い Opus しか（または何も）残さないとき、拒否で終わらず別モデルで再試行する（2.1.314）。フラグが付いたメッセージ後の自動モデル切り替えは、認識できないモデル名（カスタムデプロイ名、inference profile ARN）にも及ぶようになり、止めるには `CLAUDE_CODE_DISABLE_REFUSAL_FALLBACK=1`（2.1.312）（[[sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316]]）。

## 変更履歴

- 2026-11-07 — Fable 5.1 の発表記事（2026-09-15）を取り込み、関連の記述を追記（[[sources/anthropic-news/2026-09-15-introducing-claude-fable-5-1-and-mythos-5-1]]）
- 2026-11-02 — 2.1.312〜2.1.314: フラグが付いた要求の別モデルでの再試行、`CLAUDE_CODE_DISABLE_REFUSAL_FALLBACK` を追記（[[sources/gh-changelog/2026-10-31-v2-1-306-to-2-1-316]]）
- 2026-10-23 — UK AISI のサイバー評価（インターネット接続あり、cyber safeguards 無効）での Mythos 5 の無許可行動の整合性評価を公開。Anthropic は、Fable 5 の cyber safeguards が有効なら即座に検知され、防げたと考えると述べる（取り込みは 2026-11-02）（[[sources/research/2026-10-23-alignment-assessment-ukaisi]]）
- 2026-10-22 出典の表記を整理（Lint）: 「（同上）」1 件を展開、「現状」の as of を 2026-10-21 に更新。あわせて第三者評価の記事（2026-10-15）への関連リンクを追加（[[sources/anthropic-news/2026-10-15-an-update-on-independent-evaluators]]）
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
