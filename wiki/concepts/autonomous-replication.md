---
type: concept
title: 自律的な複製（autonomous replication and adaptation, ARA）と AI ワーム
updated: 2026-10-21
sources:
  - sources/research/2026-10-12-self-replicating-ai
---

# 自律的な複製（ARA）と AI ワーム

## 概要

モデルが人の制御なしに自分自身を配備し、広がる能力（autonomous replication and adaptation）についての Anthropic Frontier Red Team の評価。小型モデルが IoT 機器の群れに重みごと広がる「weight-based replicator」を主な対象にし、近い将来に現実味を帯びると見る（[[sources/research/2026-10-12-self-replicating-ai]]）。

## 現状（as of 2026-10-21）

- 結論（Anthropic の見立て）: 完全な暴走複製体はまだ無いが、手順ごとの能力は揃いつつある（signs of life）。小型モデルが通しの複製に届くのは、過去の改善ペースなら2026年末ごろ（同上）。
- 評価の範囲: exploit の部分は簡略化（認証なしの ADB）しており、通しの成功は上限値。オープンウェイトでは GLM-5.2 のみが 8 ノードの通しの複製に成功（同上）。
- 実機: 無名 Android TV ボックス15台で Gemma4-26B-A4B を 0.39 tok/s で動かした。複製は遅く、倍加に数日（同上）。
- 適応: 親のメモを引き継ぐと成功率が上がる。強いモデルの助言は小型モデルを助けなかった。調整役は大型モデルが小型モデルをサブエージェントとして使う形になりそうだと見る（同上）。
- 防御: ISP のネットワーク監視での検知、感染者の隔離と通知（Mirai では14日で92%）、メーカーの既定パスワードの規制。完全な根絶は ISP 間の調整が要り難しい（同上）。
- Claude Code・API の利用者への直接の影響は、この資料には書かれていない（推測: 製品の安全策の変更ではなく、脅威の見通しの共有）。

## 変更履歴

- 2026-10-12 — 記事を公開（取り込みは 2026-10-21）（[[sources/research/2026-10-12-self-replicating-ai]]）

## 未解決・矛盾

- Anthropic 自身のモデル（Claude）の複製能力の評価や、Claude 側の対策との関係は、この記事に書かれていない。
- 関連: [[concepts/cyber-safeguards]]（サイバー安全策。GLM-5.3 の分析は [[sources/research/2026-09-29-glm-5-3-and-the-spread-of-advanced-cyber-capabilities]]）、[[concepts/unintended-model-actions]]（評価中のエージェントの逸脱）
- 記事の図表の個別値は未取り込み。
