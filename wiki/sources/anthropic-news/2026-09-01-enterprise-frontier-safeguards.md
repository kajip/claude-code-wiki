---
type: source
source_id: anthropic-news
title: Developing Enterprise Frontier Safeguards with our customers
url: https://www.anthropic.com/news/enterprise-frontier-safeguards
published: 2026-09-01
retrieved: 2026-10-11
version:
tier: primary
review: ok
recheck: weekly
fingerprint: d38bd96e2fe223d2b410a9c4d6065f4a7a7b8b6b5fcb785d68d0bda211505550
archive_url:
---

# Developing Enterprise Frontier Safeguards with our customers

## 要点

- Enterprise Frontier Safeguards（EFS）を発表。ZDR（zero data retention）のプライバシーと、不正利用を検知する安全策を両立させる仕組み。データは Anthropic ではなく顧客が管理するクラウド基盤に保存する。
- 段階的な提供で、開始は「この秋の後半」。EFS が使えるようになるまで、対象の顧客は Fable 5 と Fable 5.1 で ZDR を受けられる。
- 背景: Mythos-class のモデル（例: Claude Fable 5.1）は誤用や自律的な不正行動のリスクも高い。複数のセッションとアカウントにまたがる誤用は、データを一定期間保持して相関を取らないと検知しにくい。そのため Fable 5 から 30日のデータ保持を導入していた。
- 設計の柱: 監視のフラグは顧客に直接送る。活動データは顧客自身のクラウドアカウントに置ける。自動監視のみで、Anthropic の人によるレビューは不要。
- 対応先に Claude Code が含まれる。Anthropic は EFS に課金しない。モデルの挙動、API 価格、レート制限は変わらない。

## 具体的な値

- 対応先（記事の列挙）: Claude Code、Claude Enterprise、the Claude Platform、Amazon Bedrock、Claude Platform on AWS、Google's Agent Platform、Microsoft Foundry。
- 共同設計: 100社以上の顧客（金融、医療、製造、通信、法務、小売、公共）と、AWS、Google Cloud、Microsoft Azure。
- 保存先の例: Amazon S3、Azure Blob Storage、Google Cloud Storage。
- opt-in の3機能: customer-owned storage、Customer-Managed Encryption Keys、fully automated review。いずれも、モデルの挙動、API 価格、レート制限を変えない。
- 自動分析の対象: トラフィックの rolling window。攻撃的なサイバー能力や生物能力を開発しようとする試み、盗まれた・漏れた認証情報の兆候など。
- 費用: Anthropic は無償。顧客が自社クラウドに保存する場合、保存、読み書き、データ転送（egress）の費用はクラウド事業者が顧客に請求する。
- 提供時期: 「later this fall」に広く利用可能にする目標。アクセス申請はフォーム経由（URL は取得したテキストに無し）。
- 期間: 30-day data retention（Fable 5 から）。ZDR の暫定提供は Fable 5 と Fable 5.1。

## 関連ページ

- [[concepts/enterprise-frontier-safeguards]]
- [[concepts/cyber-safeguards]]

## 取り込みメモ

- 日付: ページ表示は「Sep 1, 2026」。メタデータの `article:published_time` は 2026-09-01T23:31:00Z（JST では 2026-09-02 08:31）。ページ表示と一覧の日付に合わせて 2026-09-01 とした。
- curl で取得した HTML（239,464 バイト）から本文を抽出して読んだ。fingerprint はこの HTML の sha256。
- 顧客の引用が多数あるが（銀行、Snowflake、Stripe など）、要約では省いた。社名と肩書きの対応は抽出テキストでは崩れている。
- 記事の「Fable 5」「Fable 5.1」「Mythos-class」の位置づけは、記事だけでは詳しく分からない。
- ページの中に、読み手への指示文は見つからなかった。
