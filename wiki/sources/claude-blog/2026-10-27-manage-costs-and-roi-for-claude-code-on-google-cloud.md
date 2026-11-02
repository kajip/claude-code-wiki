---
type: source
source_id: claude-blog
title: Manage costs and demonstrate ROI for Claude Code on Google Cloud
url: https://claude.com/resources/articles/how-to-manage-costs-and-demonstrate-roi-for-claude-code-on-google-cloud
published: 2026-10-27
retrieved: 2026-11-02
version:
tier: primary
review: pending
recheck: none
fingerprint: b083171dfa36e4984b75cdd6ead155cd4f37ddc86ef229c93af5d29c70610b19
archive_url:
---

# Manage costs and demonstrate ROI for Claude Code on Google Cloud

## 要点

- Google Cloud 上の Claude Code のコストと効果を、control（ガードレール）、track（可視化）、prove（ROI の証明）の3つのレバーで扱う手引き。Google Cloud との共催ウェビナーが元になっている。
- Claude on Google Cloud は従量課金で、請求額はトークン消費量とモデル選択で決まる。エージェント型の Claude Code はチャットより1タスクあたりのトークンが多い。
- control: Claude apps gateway（自己ホスト。Google Cloud のプロジェクト内で Claude Code と Claude on Google Cloud の間に置く）が、ユーザー・IdP グループ・組織単位の spend cap、グループ別のモデル allowlist、既定モデル、admin API を提供する。高額なセッションは悪いとは限らず、無駄は「ヘビーユーザーの長い中間層」にあるという立場。
- track: Claude Code の OpenTelemetry（skill、plugin、agent、MCP server 別の内訳を含む）、Google Cloud Billing の BigQuery エクスポート、Cloud Monitoring のテンプレートで可視化する。
- prove: usage、satisfaction、impact（time、effort、volume）の3軸で測る。PR 数は定義した種類の merged PR で数え、Claude Code の PR 指標は「作成した PR」であって merge 済みではない点に注意する。
- 顧客事例として Delivery Hero、Shopify、Fifth Dimension を挙げる（数値は記事の自己申告）。

## 具体的な値

- Google Cloud 側の機能: per-project billing、billing budgets and alerts、Spend caps（**Preview**）、BigQuery exports、Quotas（モデルファミリーとエンドポイントのロケーションごとに、分あたりのリクエスト数・入力トークン数・出力トークン数）、Provisioned throughput（固定料金の予約容量）。
- gateway: 同じ `claude` バイナリに同梱。spend cap は user／IdP group／組織、期間は日・週・月。group と組織の cap は共有プールではなく、各メンバーが継承する既定値。
- 閾値アラート: Claude Code 内で 75% 超と 95% 超に警告。cap に達すると gateway は 429 を返し、期間のリセットか管理者の引き上げまで続く。引き上げは gateway の admin API で自動化できる。
- モデルの allowlist は gateway がリクエストごとにサーバー側で強制する。既定モデルの設定は、多くの人がそのまま使うので効果が高い、と記事は述べる。
- テレメトリ: OTLP で Google Cloud Monitoring などへ。gateway に送信先を設定すると、サインインした開発者のテレメトリを有効にし、検証済みのメールと IdP グループを付けて出力する。
- 環境変数: `OTEL_RESOURCE_ATTRIBUTES`（例: `department=engineering,cost_center=eng-123`）で部門やコストセンターを属性として付ける。
- OTel の quickstart は、ログを BigQuery のパーティション表（イベント種別ごと: API requests、tool decisions、tool results、assistant responses、完了した hook executions）に流し、SQL クエリ例を含む。
- ユーザーのプロンプトは自動では記録されず、オプトインが必要。
- impact 指標の例: PR cycle time（open から merge）、code review turnaround、review iterations per PR、PRs per engineer、deployment frequency。
- 顧客事例: Delivery Hero は 100 個の UI コンポーネントのデザインシステム刷新を数分（通常は1人1週間）、Fifth Dimension は月 30 万行超・採用率 98%。
- 推奨の出発点: 組織全体の spend cap、既定モデル、モデル allowlist を置き、データを見て役割やチームごとに調整する。
- 価格の数値は記事に無い。

## 関連ページ

- [[concepts/claude-on-google-cloud]]
- [[concepts/claude-apps-gateway]]
- [[sources/platform-docs/2026-10-30-release-notes-2026-10-22-to-10-30]]

## 取り込みメモ

- 記事ページ本体を curl で取得した（HTML 全体の sha256 を fingerprint とした）。公開日は記事ページの「October 27, 2026」で確認した（一覧の表示と一致）。
- URL は claude.com/resources/articles 配下で、blog-category の一覧経由で見つけた記事として claude-blog に置いた。
- 記事は Claude on Google Cloud の提供形態（Anthropic managed か Vertex AI 経由か）、対象モデル、リージョンを説明していない。Vertex AI との違いは分からない。
- 記事中に「Fable」というモデル名が出る（Sonnet で足りる定常作業に使う例として）。他ページとの対応は未確認。
- 記事のリンク先ドキュメント（spend limits、OTel quickstart、Claude Code Monitoring テンプレート）は取得していない。
- ページ内に指示文は見当たらなかった。
