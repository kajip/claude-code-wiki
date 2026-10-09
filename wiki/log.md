# Log

追記のみ。書式は `## [YYYY-MM-DD] 種別 | 件名`。日付は日本時間。

## [2026-10-10] schema | 初期化

- llm-wiki の方針で wiki を新規作成。raw 層は持たず、情報源の URL を唯一の原本とする。
- 第三者の解説記事は取り込まない。二次情報の扱いは `proposals/secondary-info.md`（未採用の案）。

## [2026-10-10] check | 情報源の到達性確認（初回）

- ✅ 取得できた: gh-changelog（raw URL）、npm（registry API）、claude-blog、anthropic-news、claude-dev、docs、engineering、research
- ⚠ gh-releases: 504 を1回確認。releases.atom は robots により拒否。`gh` CLI はセッション未許可。CHANGELOG と npm で代替検知。
- ⚠ npm のパッケージページは古い内容（1.0.27）を表示。registry API を使う。
- 追加確認: Economic Index（動的ダッシュボード。取得できるのは「Last updated: 2026-06-26」のみ）。
- Ingest は未実施。初期観測は `sources.md` に記録。

## [2026-10-10] check | daily 巡回（1〜6）
- gh-releases: 取得成功（HTTP 200）。最新 v2.1.296。sources.md の状態を ✅ に更新。
- gh-changelog / npm: 新版 2.1.296（npm 公開 2026-10-09T16:58Z）。stable は 2.1.286→2.1.287 に更新。status.md を上書き。
- claude-blog: 一覧に 2026-10-08 の記事2件（Block の事例、dashboards-and-motion）が出現。
- anthropic-news / claude-dev: 初回観測からの新着なし。
- 未 Ingest。wiki/sources が空のため、取り込み範囲を人間に確認中。

## [2026-10-10] ingest | 初回 Ingest（直近約1か月分、B案）
- gh-changelog: 2.1.290〜2.1.296 を1ページにまとめた。`last_seen_version` を 2.1.296 に設定。
- anthropic-news: 6件（Opus 5.5／Sonnet 5.5／Haiku 5.5、Usage Policy、CVP、Cyber Mission）。
- claude-blog: 6件（dashboards-and-motion、mods、Government GA、Opus 5.5 とコンテキスト、modernization、projects-redesigned）。claude.dev と anthropic.com への相互リンクは、それぞれの source_id で1ページにした。
- claude-dev: 9件（2026-09-22〜10-08。特集「Building effective agent automations」は記事ページで 2026-10-08 と確認）。
- concepts: 18ページを新規作成。全ページ review: pending。
- 範囲外: claude-blog の 2026-09-14（CI のテスト影響分析）は一覧の上位に出ず、未取得。
## [2026-10-10] skip | How Block orchestrates Claude Fable across thousands of pull requests | 顧客事例
## [2026-10-10] skip | Barclays scales Claude to upgrade operations and improve client experience | 顧客事例
## [2026-10-10] skip | Building on our commitment to American scientific discovery | 科学政策で Claude Code と無関係
## [2026-10-10] skip | Anthropic invests $100 million to train 10,000 engineers... | 人材育成への投資
## [2026-10-10] skip | Claude discovers a novel enzyme system with CRISPR-like repeats | 無関係な研究
## [2026-10-10] skip | The Situation Report | 特集記事で無関係
## [2026-10-10] skip | Partnering with Accenture on embedded evaluation | 提携の発表
## [2026-10-10] skip | Introducing the Life Sciences Verification Program | 生命科学向けで Claude Code との関連が薄い

## [2026-10-10] ingest | 人間のレビューへの対応（価格、docs、09-14 の記事）
- pricing: 人間の指示で `sources.md` に情報源 10（pricing）を追加した。価格ページの raw を取得し、claude.com/pricing と照合した（5.5 世代の値は一致）。Sonnet 5.5 のキャッシュヒット $0.10 を確認した。
- docs: prompt-caching と claude-projects の必要な節を取り込んだ。effort とキャッシュの食い違い、Projects の提供範囲の食い違いを、docs の記述で解決済みとして閉じた。
- claude-blog: 2026-09-14「Agentic coding is straining CI…」を取り込んだ（`?page=2` で発見）。
- anthropic-news: Usage Policy の施行日を 2026-11-12 に確定した（人間の確認による）。
- 更新した concepts: prompt-caching、effort、projects、fast-mode、claude-opus-5-5、claude-sonnet-5-5、claude-haiku-5-5、claude-tag。
## [2026-10-10] skip | Working at the frontier: How Balyasny Asset Management evaluates and governs Claude Fable 5 | 顧客事例
## [2026-10-10] skip | T. Rowe Price brings more of Claude to its investment process | 顧客事例
## [2026-10-10] schema | 出典の優先順位、CHANGELOG の published、日付の補い方、日付不明ページのファイル名
- Ingest 手順 4: 価格は pricing、仕様と提供範囲は docs を正とする。記事の値は公開時点の値として扱う。
- CHANGELOG の `published` は、バッチ内で最新の版の npm 公開日時を使う。
- 本文で年が省略された日付は、記事の公開年で補ってよい（取り込みメモに書く）。
- `published: unknown` のページは、ファイル名の日付に取得日を使う。
- templates/source-page.md の source_id の一覧に pricing を追加した。
