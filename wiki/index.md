# Index

最終更新: 2026-10-21（要約 64・概念 31）

## 状態

- [[status]] — Claude Code の最新バージョンなどのスナップショット
- [[review-queue.base|レビュー待ち]] — review が ok でない要約ページの一覧（Obsidian の Bases で表示）

## 要約ページ（sources）

ID ごとに新しい順。形式: `- [[sources/<id>/<日付>-<slug>]] — 1行要約（公開日）`

### gh-changelog
- [[sources/gh-changelog/2026-10-21-v2-1-303-to-2-1-305]] — 2.1.303〜2.1.305。`sandbox.allowNestedUserNamespaces`（ファイル保護を回避しうる）、`allowedMcpServers` が managed-mcp.json の一部 stdio サーバーを絞り込まなくなる変更、mods の `decider: "person"` ほか、Code Review の review levels（2026-10-21）
- [[sources/gh-changelog/2026-10-18-v2-1-302]] — 2.1.302。`CLAUDE_CODE_AUTO_MODE_MODEL`、サードパーティのプロバイダの `claude -p` は条件付きで default 開始、fork subagent の既定化、デスクトップアプリと VS Code のサブエージェントは常にバックグラウンド、Claude Design 単体版は 2026-12-14 に終了（2026-10-17）
- [[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]] — 2.1.299〜2.1.301。MCP の allow ルールの限定（非互換の可能性）、アイドル時のコンパクション、mods の `prompt.change` ほか API 追加、サンドボックス関連の修正（2026-10-15）
- [[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]] — 2.1.290〜2.1.296。mods の API、Claude apps gateway、MCP 2026-07-28 の既定化、Haiku 5.5 の追加、セキュリティ修正（2026-10-10）

### claude-blog
- [[sources/claude-blog/2026-10-15-code-review-is-now-generally-available]] — Code Review が研究プレビューから GA（Team／Enterprise、Quick／Standard／Deep、約3倍速）（2026-10-15）
- [[sources/claude-blog/2026-10-08-dashboards-and-motion]] — Dashboards と Motion（ベータ）。Docs、Slides、Design の GA（2026-10-08）
- [[sources/claude-blog/2026-10-01-customize-claude-code-with-mods]] — mods の発表。sec-default、管理者による制御（2026-10-01）
- [[sources/claude-blog/2026-09-30-claude-for-government-ga]] — Claude for Government の GA（FedRAMP High）。Claude Code CLI は early access（2026-09-30）
- [[sources/claude-blog/2026-09-24-opus-5-5-built-for-longer-coding-sessions]] — 長くなるセッションとキャッシュ。利用の傾向の数値（2026-09-24）
- [[sources/claude-blog/2026-09-23-prepare-for-ai-driven-code-modernization]] — モダナイゼーションの6段階。code-modernization プラグイン（2026-09-23）
- [[sources/claude-blog/2026-09-17-projects-redesigned]] — 作り直した Projects（ベータ）。スレッドは cloud session（2026-09-17）
- [[sources/claude-blog/2026-09-14-agentic-coding-is-straining-ci]] — エージェントによるコーディングで CI の負荷が増え、テスト選択サービスを作り直した社内の事例（2026-09-14）
- [[sources/claude-blog/2026-08-14-maximizing-the-value-of-your-claude-code-sessions]] — Claude Code の費用の仕組みとキャッシュを壊す操作、コンテキストを短く保つ運用（2026-08-14）
- [[sources/claude-blog/2026-08-11-compliance-api-cowork-and-claude-code]] — Compliance API が Cowork と Claude Code のセッションを対象に追加。8/26 に GA（2026-08-11）
- [[sources/claude-blog/2026-08-07-auto-mode-default-in-claude-code]] — 2026-08-14 から Pro／Max／Team の新規セッションを auto mode 既定に。分類器の課金停止、安全性データ（2026-08-07）
- [[sources/claude-blog/2026-08-07-running-auto-mode-in-production]] — auto mode の顧客事例（Nuro、Gusto、Garner Health）と運用の工夫（2026-08-07）
- [[sources/claude-blog/2026-08-06-run-claude-code-sessions-on-your-own-compute]] — self-hosted environments が public beta（Team／Enterprise、runner は Fixed／On-demand）（2026-08-06）

### anthropic-news
- [[sources/anthropic-news/2026-10-15-an-update-on-independent-evaluators]] — 独立評価者の方針。METR に社員並みのアクセス、SecureBio・Accenture も参加、アクセスは3段階（2026-10-15）
- [[sources/anthropic-news/2026-10-14-2026-us-midterms]] — 米中間選挙に向けた安全策。公式の投票情報、政治的中立性 99%、多段階の誤用向け classifier（2026-10-14）
- [[sources/anthropic-news/2026-10-12-distillation-defenses]] — 蒸留攻撃への対策。preserved thinking、2段 classifier（誤検知率 0.1% 未満）、課金再開。抜き取られた推論トークンは 1/10〜1/100 以下に（2026-10-12）
- [[sources/anthropic-news/2026-10-08-introducing-the-anthropic-cyber-mission]] — Cyber Mission。OSS Scanner、CIDP（2026-10-08）
- [[sources/anthropic-news/2026-10-08-2026-usage-policy-update]] — Usage Policy の改定（11月12日施行）（2026-10-08）
- [[sources/anthropic-news/2026-10-07-introducing-claude-haiku-5-5]] — Haiku 5.5 の発表。Haiku 4.5 より約75%安い。Sonnet 5.5 のキャッシュ読み取りを値下げ（2026-10-07）
- [[sources/anthropic-news/2026-10-06-expanding-the-cyber-verification-program]] — CVP の拡大。3段階のアクセス、Glasswing を統合（2026-10-06）
- [[sources/anthropic-news/2026-09-28-introducing-claude-sonnet-5-5]] — Sonnet 5.5 の発表。30%以上速く、最大30%安い（2026-09-28）
- [[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]] — Opus 5.5 の発表。Fable 5.1 と同程度の性能で、Opus 5 より約40%安い（2026-09-22）
- [[sources/anthropic-news/2026-09-01-enterprise-frontier-safeguards]] — Enterprise Frontier Safeguards。ZDR と誤用検知の両立、データは顧客のクラウドに保存、今秋に段階展開（2026-09-01）

### claude-dev
- [[sources/claude-dev/2026-10-15-how-the-claude-code-team-does-code-review]] — Claude Code チームのコードレビュー運用（AI レビュー、リスク別承認、収束対策、社内の数値）（2026-10-15）
- [[sources/claude-dev/2026-10-08-building-effective-agent-automations]] — Managed Agents（ベータ）で定期実行するエージェントの参考実装（2026-10-08）
- [[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]] — cloud sessions の手引き。コマンド、環境、制限、セキュリティ（2026-10-06）
- [[sources/claude-dev/2026-10-01-getting-started-with-claude-code-mods]] — mods の作り方（2.1.287 以降）。API、テスト、配布（2026-10-01）
- [[sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5]] — Sonnet 5.5 の仕様と移行。between_tools、Claude Code での既定（2026-09-28）
- [[sources/claude-dev/2026-09-28-automating-eval-design-and-hillclimbing]] — /claude-api build-eval と hillclimb（2026-09-28）
- [[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]] — Opus 5.5 のタスク単価。キャッシュ、コマンド、推奨（2026-09-25）
- [[sources/claude-dev/2026-09-25-spending-your-effort]] — effort の使い分けと計測の結果（2026-09-25）
- [[sources/claude-dev/2026-09-23-how-we-made-claude-ai-faster]] — Claude Tag を使って claude.ai を3倍速くした事例（2026-09-23）
- [[sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5]] — Opus 5.5 の使い方。止まる条件、フラグが付いたときの対応、fast mode（2026-09-22）
- [[sources/claude-dev/2026-07-24-new-rules-of-context-engineering-claude-5]] — Claude Code のシステムプロンプトを 80% 超削った経緯と、CLAUDE.md・skills の整え方（2026-07-24）

### docs
- [[sources/docs/2026-10-16-code-review]] — Code Review の docs。概要と下位5ページ（setup、customize、PR での操作、費用、トラブルシューティング）（公開日不明。取得 2026-10-16）
- [[sources/docs/2026-10-16-routines-and-cloud-sessions]] — routines（研究プレビュー）と cloud sessions の docs。利用枠、1時間あたりの上限、push 先、ネットワーク、設定の読み込み範囲（公開日不明。取得 2026-10-16）
- [[sources/docs/2026-10-10-auto-mode-config]] — Configure auto mode。`autoMode` の設定キー、`claude auto-mode` サブコマンド、`/auto-mode-setup`（公開日不明。取得 2026-10-10）
- [[sources/docs/2026-10-10-sandboxing]] — Bash サンドボックス。有効化、設定キー、ファイルとネットワークの境界、Seatbelt と bubblewrap、管理者のロック、既知の制限（公開日不明。取得 2026-10-10）
- [[sources/docs/2026-10-10-permission-modes]] — Choose a permission mode。各モードと切り替え方、auto mode の要件、分類器（既定は Sonnet 5）、既定でブロックするもの、critical paths（公開日不明。取得 2026-10-10）
- [[sources/docs/2026-10-10-claude-projects]] — Projects の提供範囲、ローカルでのスレッド実行、上限（公開日不明。取得 2026-10-10）
- [[sources/docs/2026-10-10-prompt-caching]] — effort を変えたときのキャッシュの扱い（公開日不明。取得 2026-10-10）
- [[sources/docs/2026-10-10-mods]] — Mods の公式 docs。plugin.json の全フィールド、hooks.json と register の例、`$` の API、`claude plugin test`、型定義、組み込み mod、管理者設定、公開申請の手順（公開日不明。取得 2026-10-10）

### engineering
- [[sources/engineering/2026-10-13-redesigning-source-control]] — Anthropic 社内製 VCS「Scion」で monorepo を git から5か月で移行した事例。1日のマージ数が約2,500件から3万件超に増えた（2026-10-13、10-15更新）
- [[sources/engineering/2026-05-25-how-we-contain-claude]] — 封じ込めの設計（claude.ai の gVisor、Claude Code の OS サンドボックス、Cowork の VM）と、見落とした4件のリスク（2026-05-25）
- [[sources/engineering/2026-04-23-an-update-on-recent-claude-code-quality-reports]] — 2026年3〜4月の品質低下の原因3件（effort の既定、thinking を消すバグ、冗長さを抑えるプロンプト）と再発防止（2026-04-23）
- [[sources/engineering/2026-04-08-scaling-managed-agents]] — Managed Agents の設計。brain・hands・session を分離し、認証情報を sandbox から隔離（2026-04-08）
- [[sources/engineering/2026-03-25-claude-code-auto-mode]] — auto mode の設計。2層の防御と2段の分類器。公開時点の FPR は 0.4%（2026-03-25）
- [[sources/engineering/2026-03-24-harness-design-long-running-apps]] — generator と evaluator を分けた3エージェントのハーネス設計と、モデルの更新に伴う簡素化（2026-03-24）
- [[sources/engineering/2026-02-05-infrastructure-noise]] — 評価のインフラノイズ。資源の設定だけで Terminal-Bench 2.0 が最大 6 ポイント変わる（2026-02-05）
- [[sources/engineering/2026-02-05-building-a-c-compiler-with-parallel-claudes]] — 16 並列の Claude（agent teams）が Rust 製の C コンパイラを作った実験と、ハーネスの設計の学び（2026-02-05）
- [[sources/engineering/2026-01-09-demystifying-evals-for-ai-agents]] — エージェント評価の用語、3種の採点器、pass@k と pass^k、作り方の8段階（2026-01-09）

### research
- [[sources/research/2026-10-12-self-replicating-ai]] — 小型モデルが IoT 機器（無名 Android TV ボックスなど）で自己複製できるようになる時期の見立て。GLM-5.2 が簡略化した通しの複製に成功し、2026年末ごろ小型モデルが追いつく見込み。防御策も整理（2026-10-12）
- [[sources/research/2026-10-09-investigating-unintended-model-actions]] — 評価と社内利用で見つかった、Claude の意図しない行動の4分類と対策（ライブ接続の停止、自動遮断など）（2026-10-09）
- [[sources/research/2026-10-08-launching-opt-in-vuln-finding-service-for-open-source]] — OSS Scanner の開始。OSS 向けに無償・opt-in で定期スキャンを提供。申し込みは GitHub の PR（2026-10-08）
- [[sources/research/2026-10-01-claude-shaped-science]] — Schwartz のゲスト寄稿。Claude Code の複数セッションとバックグラウンドのサブエージェントで、多分野の計算を進めた実践談（2026-10-01）
- [[sources/research/2026-09-29-glm-5-3-and-the-spread-of-advanced-cyber-capabilities]] — GLM-5.3 の分析。回避しやすい安全策と、Claude の API 側の対策、防御側へのアクセス方針（2026-09-29）

### platform-docs
- [[sources/platform-docs/2026-10-20-release-notes-2026-10-14-to-10-20]] — Claude Platform のリリースノート（10-14〜10-20）。Opus 5.5 の fast mode が研究プレビューを脱した、OpenTelemetry export（ベータ）、Inference hooks が Enterprise でベータ終了、Compliance API でユーザーの instructions を取得可（2026-10-20）
- [[sources/platform-docs/2026-10-10-prompt-caching]] — Claude API の prompt caching。effort と thinking の変更でのキャッシュ無効化、モデル別の最小長（公開日不明。取得 2026-10-10）
- [[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]] — Claude Platform のリリースノート（09-10〜10-09）。5.5 世代のモデル、Managed Agents、compaction on demand、Sonnet 4.5 の廃止予告（2026-10-09）

### pricing
- [[sources/pricing/2026-10-10-pricing]] — Claude API の価格表。キャッシュの倍率、fast mode、Batch（公開日不明。取得 2026-10-10）

## 概念ページ（concepts）

形式: `- [[concepts/<slug>]] — 1行要約（出典数）`

- [[concepts/agent-evals]] — エージェントの評価（evals）（出典 5）
- [[concepts/auto-mode]] — auto mode（権限の自動判定）（出典 12）
- [[concepts/autonomous-replication]] — 自律的な複製（ARA）と AI ワーム（出典 1）
- [[concepts/claude-api-skill]] — claude-api スキル（出典 6）
- [[concepts/claude-apps-gateway]] — Claude apps gateway（出典 2）
- [[concepts/claude-code-quality-incidents]] — Claude Code の品質低下の報告と原因（2026年3〜4月）（出典 1）
- [[concepts/claude-haiku-5-5]] — Claude Haiku 5.5（出典 5）
- [[concepts/claude-opus-5-5]] — Claude Opus 5.5（出典 11）
- [[concepts/claude-sonnet-5-5]] — Claude Sonnet 5.5（出典 7）
- [[concepts/claude-tag]] — Claude Tag（Claude in Slack）（出典 6）
- [[concepts/cloud-sessions]] — cloud sessions（Claude Code in the cloud）（出典 7）
- [[concepts/code-review]] — Code Review（GitHub App による PR の自動レビュー）（出典 5）
- [[concepts/compliance-api]] — Compliance API の対象範囲と GA／ベータの状況（出典 3）
- [[concepts/context-engineering]] — コンテキストエンジニアリング（Claude 5 世代）（出典 2）
- [[concepts/cyber-safeguards]] — サイバー・安全策と Cyber Verification Program（出典 16）
- [[concepts/distillation-defenses]] — 蒸留攻撃への対策（preserved thinking、推論抽出の遮断）（出典 5）
- [[concepts/effort]] — effort（思考量の設定）（出典 10）
- [[concepts/enterprise-frontier-safeguards]] — Enterprise Frontier Safeguards（EFS。顧客管理ストレージ、CMEK、自動レビューの opt-in。Claude Code も対応先）（出典 1）
- [[concepts/fast-mode]] — fast mode（出典 10）
- [[concepts/hooks]] — hooks（設定のフック）（出典 6）
- [[concepts/long-running-agent-harness]] — 長時間動くエージェントのハーネス（ループ、ロックによる並列化、テストの設計）（出典 3）
- [[concepts/managed-agents]] — Claude Managed Agents（出典 6）
- [[concepts/mcp]] — MCP（Model Context Protocol）（出典 5）
- [[concepts/mods]] — mods（Claude Code mods）（出典 6）
- [[concepts/oss-scanner]] — OSS Scanner（OSS 向けの無償・opt-in の脆弱性発見サービス）（出典 4）
- [[concepts/projects]] — Projects（作り直された Projects）（出典 3）
- [[concepts/prompt-caching]] — プロンプトキャッシュとセッションの費用（出典 12）
- [[concepts/routines]] — routines（ルーティン）（出典 5）
- [[concepts/sandboxing]] — サンドボックスと隔離（封じ込め）の設計と教訓（出典 5）
- [[concepts/subagents]] — サブエージェント（出典 9）
- [[concepts/unintended-model-actions]] — モデルの意図しない行動と、運用上の安全策（出典 1）

## 分析（analysis）

- [[analysis/opus-5-5-prompting]] — Opus 5.5 に渡すプロンプトの注意点と事例（as of 2026-10-10）
- [[analysis/mods-howto]] — mods の作り方。ファイル構成、hook の書き方、試し方、検証とテスト、配布（as of 2026-10-11）
