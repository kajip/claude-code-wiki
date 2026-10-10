# Index

最終更新: 2026-10-10（要約 40・概念 25）

## 状態

- [[status]] — Claude Code の最新バージョンなどのスナップショット

## 要約ページ（sources）

ID ごとに新しい順。形式: `- [[sources/<id>/<日付>-<slug>]] — 1行要約（公開日）`

### gh-changelog
- [[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]] — 2.1.290〜2.1.296。mods の API、Claude apps gateway、MCP 2026-07-28 の既定化、Haiku 5.5 の追加、セキュリティ修正（2026-10-10）

### claude-blog
- [[sources/claude-blog/2026-10-08-dashboards-and-motion]] — Dashboards と Motion（ベータ）。Docs、Slides、Design の GA（2026-10-08）
- [[sources/claude-blog/2026-10-01-customize-claude-code-with-mods]] — mods の発表。sec-default、管理者による制御（2026-10-01）
- [[sources/claude-blog/2026-09-30-claude-for-government-ga]] — Claude for Government の GA（FedRAMP High）。Claude Code CLI は early access（2026-09-30）
- [[sources/claude-blog/2026-09-24-opus-5-5-built-for-longer-coding-sessions]] — 長くなるセッションとキャッシュ。利用の傾向の数値（2026-09-24）
- [[sources/claude-blog/2026-09-23-prepare-for-ai-driven-code-modernization]] — モダナイゼーションの6段階。code-modernization プラグイン（2026-09-23）
- [[sources/claude-blog/2026-09-17-projects-redesigned]] — 作り直した Projects（ベータ）。スレッドは cloud session（2026-09-17）
- [[sources/claude-blog/2026-09-14-agentic-coding-is-straining-ci]] — エージェントによるコーディングで CI の負荷が増え、テスト選択サービスを作り直した社内の事例（2026-09-14）

### anthropic-news
- [[sources/anthropic-news/2026-10-08-introducing-the-anthropic-cyber-mission]] — Cyber Mission。OSS Scanner、CIDP（2026-10-08）
- [[sources/anthropic-news/2026-10-08-2026-usage-policy-update]] — Usage Policy の改定（11月12日施行）（2026-10-08）
- [[sources/anthropic-news/2026-10-07-introducing-claude-haiku-5-5]] — Haiku 5.5 の発表。Haiku 4.5 より約75%安い。Sonnet 5.5 のキャッシュ読み取りを値下げ（2026-10-07）
- [[sources/anthropic-news/2026-10-06-expanding-the-cyber-verification-program]] — CVP の拡大。3段階のアクセス、Glasswing を統合（2026-10-06）
- [[sources/anthropic-news/2026-09-28-introducing-claude-sonnet-5-5]] — Sonnet 5.5 の発表。30%以上速く、最大30%安い（2026-09-28）
- [[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]] — Opus 5.5 の発表。Fable 5.1 と同程度の性能で、Opus 5 より約40%安い（2026-09-22）

### claude-dev
- [[sources/claude-dev/2026-10-08-building-effective-agent-automations]] — Managed Agents（ベータ）で定期実行するエージェントの参考実装（2026-10-08）
- [[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]] — cloud sessions の手引き。コマンド、環境、制限、セキュリティ（2026-10-06）
- [[sources/claude-dev/2026-10-01-getting-started-with-claude-code-mods]] — mods の作り方（2.1.287 以降）。API、テスト、配布（2026-10-01）
- [[sources/claude-dev/2026-09-28-building-with-claude-sonnet-5-5]] — Sonnet 5.5 の仕様と移行。between_tools、Claude Code での既定（2026-09-28）
- [[sources/claude-dev/2026-09-28-automating-eval-design-and-hillclimbing]] — /claude-api build-eval と hillclimb（2026-09-28）
- [[sources/claude-dev/2026-09-25-what-a-task-costs-on-opus-5-5]] — Opus 5.5 のタスク単価。キャッシュ、コマンド、推奨（2026-09-25）
- [[sources/claude-dev/2026-09-25-spending-your-effort]] — effort の使い分けと計測の結果（2026-09-25）
- [[sources/claude-dev/2026-09-23-how-we-made-claude-ai-faster]] — Claude Tag を使って claude.ai を3倍速くした事例（2026-09-23）
- [[sources/claude-dev/2026-09-22-getting-the-most-out-of-opus-5-5]] — Opus 5.5 の使い方。止まる条件、フラグが付いたときの対応、fast mode（2026-09-22）

### docs
- [[sources/docs/2026-10-10-claude-projects]] — Projects の提供範囲、ローカルでのスレッド実行、上限（公開日不明。取得 2026-10-10）
- [[sources/docs/2026-10-10-prompt-caching]] — effort を変えたときのキャッシュの扱い（公開日不明。取得 2026-10-10）

### engineering
- [[sources/engineering/2026-05-25-how-we-contain-claude]] — 封じ込めの設計（claude.ai の gVisor、Claude Code の OS サンドボックス、Cowork の VM）と、見落とした4件のリスク（2026-05-25）
- [[sources/engineering/2026-04-23-an-update-on-recent-claude-code-quality-reports]] — 2026年3〜4月の品質低下の原因3件（effort の既定、thinking を消すバグ、冗長さを抑えるプロンプト）と再発防止（2026-04-23）
- [[sources/engineering/2026-04-08-scaling-managed-agents]] — Managed Agents の設計。brain・hands・session を分離し、認証情報を sandbox から隔離（2026-04-08）
- [[sources/engineering/2026-03-25-claude-code-auto-mode]] — auto mode の設計。2層の防御と2段の分類器。公開時点の FPR は 0.4%（2026-03-25）
- [[sources/engineering/2026-03-24-harness-design-long-running-apps]] — generator と evaluator を分けた3エージェントのハーネス設計と、モデルの更新に伴う簡素化（2026-03-24）
- [[sources/engineering/2026-02-05-infrastructure-noise]] — 評価のインフラノイズ。資源の設定だけで Terminal-Bench 2.0 が最大 6 ポイント変わる（2026-02-05）
- [[sources/engineering/2026-02-05-building-a-c-compiler-with-parallel-claudes]] — 16 並列の Claude（agent teams）が Rust 製の C コンパイラを作った実験と、ハーネスの設計の学び（2026-02-05）
- [[sources/engineering/2026-01-09-demystifying-evals-for-ai-agents]] — エージェント評価の用語、3種の採点器、pass@k と pass^k、作り方の8段階（2026-01-09）

### research
- [[sources/research/2026-10-09-investigating-unintended-model-actions]] — 評価と社内利用で見つかった、Claude の意図しない行動の4分類と対策（ライブ接続の停止、自動遮断など）（2026-10-09）
- [[sources/research/2026-10-08-launching-opt-in-vuln-finding-service-for-open-source]] — OSS Scanner の開始。OSS 向けに無償・opt-in で定期スキャンを提供。申し込みは GitHub の PR（2026-10-08）
- [[sources/research/2026-10-01-claude-shaped-science]] — Schwartz のゲスト寄稿。Claude Code の複数セッションとバックグラウンドのサブエージェントで、多分野の計算を進めた実践談（2026-10-01）
- [[sources/research/2026-09-29-glm-5-3-and-the-spread-of-advanced-cyber-capabilities]] — GLM-5.3 の分析。回避しやすい安全策と、Claude の API 側の対策、防御側へのアクセス方針（2026-09-29）

### platform-docs
- [[sources/platform-docs/2026-10-10-prompt-caching]] — Claude API の prompt caching。effort と thinking の変更でのキャッシュ無効化、モデル別の最小長（公開日不明。取得 2026-10-10）
- [[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]] — Claude Platform のリリースノート（09-10〜10-09）。5.5 世代のモデル、Managed Agents、compaction on demand、Sonnet 4.5 の廃止予告（2026-10-09）

### pricing
- [[sources/pricing/2026-10-10-pricing]] — Claude API の価格表。キャッシュの倍率、fast mode、Batch（公開日不明。取得 2026-10-10）

## 概念ページ（concepts）

形式: `- [[concepts/<slug>]] — 1行要約（出典数）`

- [[concepts/agent-evals]] — エージェントの評価（evals）（出典 5）
- [[concepts/auto-mode]] — auto mode（権限の自動判定）（出典 5）
- [[concepts/claude-api-skill]] — claude-api スキル（出典 5）
- [[concepts/claude-apps-gateway]] — Claude apps gateway（出典 1）
- [[concepts/claude-code-quality-incidents]] — Claude Code の品質低下の報告と原因（2026年3〜4月）（出典 1）
- [[concepts/claude-haiku-5-5]] — Claude Haiku 5.5（出典 5）
- [[concepts/claude-opus-5-5]] — Claude Opus 5.5（出典 8）
- [[concepts/claude-sonnet-5-5]] — Claude Sonnet 5.5（出典 7）
- [[concepts/claude-tag]] — Claude Tag（Claude in Slack）（出典 3）
- [[concepts/cloud-sessions]] — cloud sessions（Claude Code in the cloud）（出典 4）
- [[concepts/cyber-safeguards]] — サイバー・安全策と Cyber Verification Program（出典 12）
- [[concepts/effort]] — effort（思考量の設定）（出典 9）
- [[concepts/fast-mode]] — fast mode（出典 7）
- [[concepts/hooks]] — hooks（設定のフック）（出典 4）
- [[concepts/long-running-agent-harness]] — 長時間動くエージェントのハーネス（ループ、ロックによる並列化、テストの設計）（出典 3）
- [[concepts/managed-agents]] — Claude Managed Agents（出典 4）
- [[concepts/mcp]] — MCP（Model Context Protocol）（出典 2）
- [[concepts/mods]] — mods（Claude Code mods）（出典 3）
- [[concepts/oss-scanner]] — OSS Scanner（OSS 向けの無償・opt-in の脆弱性発見サービス）（出典 4）
- [[concepts/projects]] — Projects（作り直された Projects）（出典 3）
- [[concepts/prompt-caching]] — プロンプトキャッシュとセッションの費用（出典 10）
- [[concepts/routines]] — routines（ルーティン）（出典 2）
- [[concepts/sandboxing]] — サンドボックスと隔離（封じ込め）の設計と教訓（出典 2）
- [[concepts/subagents]] — サブエージェント（出典 7）
- [[concepts/unintended-model-actions]] — モデルの意図しない行動と、運用上の安全策（出典 1）

## 分析（analysis）

- [[analysis/opus-5-5-prompting]] — Opus 5.5 に渡すプロンプトの注意点と事例（as of 2026-10-10）
