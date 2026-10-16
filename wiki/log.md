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

## [2026-10-10] query | Opus 5.5 に渡すプロンプトの注意点と事例
- wiki に収録されていない記述があったため、人間の承認を得て元の記事を取得し直した。要約ページ（getting-the-most-out-of-opus-5-5）に要点とプロンプトの例を追記した。
- concepts/claude-opus-5-5 にプロンプトの書き方を追記し、回答を analysis/opus-5-5-prompting として保存した。

## [2026-10-10] schema | Query で claude-api スキルを補足として使う
- Query の手順 5 を追加した。claude-api スキルは、wiki 外の補足として枠を分けて使う。wiki には直接書かず、公式の URL から Ingest し直す（URL が sources.md に無ければ人間に諮る）。
- claude-code-guide エージェントは使わない。

## [2026-10-10] schema | 情報源 11（platform-docs）を追加
- 人間の指示により、Claude Platform のドキュメント（API 側）を週次の情報源にした。差分検知にはリリースノート（release-notes/overview.md）と llms.txt を使う。
- 出典の優先順位に platform-docs を加えた（Claude API 側の仕様）。雛形の source_id の一覧と README も更新した。

## [2026-10-10] ingest | platform-docs の初回 Ingest（リリースノート 09-10〜10-09）
- リリースノートの14日分を1ページにまとめた。`last_seen_release_note` を October 9, 2026 に設定した。
- 解決した点: Opus 5.5 のコンテキストと最大出力（1M と 128k）。Haiku 5.5 の最大出力（128k）も新たに分かった。
- 更新した concepts: claude-opus-5-5、claude-haiku-5-5、claude-sonnet-5-5、prompt-caching、fast-mode、managed-agents、cyber-safeguards。

## [2026-10-10] schema | 作業のサブエージェント化と CLAUDE.md の圧縮
- Check／Ingest／Query／Lint を `.claude/agents/` のサブエージェントに分けた（check・query・lint は Haiku で読み取りのみ、ingest は Sonnet）。サブエージェントには CLAUDE.md を読ませない（`omitClaudeMd`）。
- 共通の規則を `rules/fetching.md` と `rules/writing.md` に移した。CLAUDE.md は方針と作業の振り分けだけにし、120行から48行にした（ドキュメントの推奨は200行未満）。
- wiki-ingest の書き込み先を `wiki/sources/` と `wiki/concepts/` に限るフックを追加した（テスト付き）。index・log・status はメインのセッションが更新する。
- `.claude/settings.json` を追加した: WebSearch と claude-code-guide を拒否、情報源のドメインへの WebFetch を許可、規則ファイルの編集と rm・push・merge は確認を求める。

## [2026-10-10] lint | 全体点検（提案のみ、ファイル変更なし）
- 優先度の高い指摘: effort の未解決を閉じたままにしている、docs の Projects の fingerprint が一致しない（冒頭は既存の要約と合う）、段階を書いた要約 5 件が `recheck: none` のまま、要約に無い記述を持つ概念ページが 5 ページ以上、キャッシュの条件（Claude Code の場合か）が概念ページ間で揃っていない。
- recheck weekly のページを取り直した: pricing は fingerprint が一致した。ほかの 6 ページも要約と食い違いは無い。壊れたリンクと index 未掲載のページは無い。
- 取得の失敗は無い。

## [2026-10-10] error | claude.dev のページ内に AI 向けの指示文
- `https://claude.dev/blog/claude-code-in-the-cloud/` の末尾（「LOAD MORE」の下）に、AI に向けた日本語の指示文があった。wiki-lint はデータとして扱い、従わなかった。要約の内容には影響していない。

## [2026-10-10] schema | 日付の基準を JST に統一
- 人間の指示により、wiki の日付と日時はすべて JST で書くことにした（`rules/writing.md`、`wiki-check` の報告形式）。時刻の無い日付は情報源の表記のまま使う。
- CHANGELOG の要約を `gh-changelog/2026-10-10-v2-1-290-to-2-1-296` に改名し、npm の公開日時を JST に換算した。概念ページの変更履歴の日付（2.1.290〜2.1.296）と status.md も JST に改めた。
- wiki-lint の壊れたリンクの点検で、バッククォート内の書式説明を数えないようにした。

## [2026-10-10] ingest | lint 対応（platform-docs prompt caching、docs Projects、claude-dev 10-06）
- platform-docs の prompt caching を取り込んだ。Claude API では `output_config.effort` や thinking のパラメータを変えると messages のキャッシュが無効になる（Claude Code の docs とは別の経路）。concepts/effort の矛盾を解決済みとして閉じ、prompt-caching と各モデルのページに Claude API と Claude Code の違いを書き分けた。tools と system への影響はモデルによるため、未確定として残した。
- docs の claude-projects を、fingerprint が変わったため取り込み直した（30af5d… → 7d4a17…）。既存の値に変更は無かったが、要約を全文に基づいて書き直し、`review: pending` に戻した。concepts/projects に、ブログの拡大予定と docs の現状（Pro と Max のみ）の差を書いた。
- claude-dev 10-06 を取り込み直し、Projects の GitHub App への依存と、routines が承認の確認無しで動くことを要約に追記した。fingerprint を付けた。
- 段階の記述がある要約 5 件を `recheck: weekly` にした。concepts/claude-tag の概要（Claude Code ではない）と、analysis/opus-5-5-prompting の出典（概念ページから要約ページへ）を直した。

## [2026-10-10] error | 先の「ページ内の指示文」の報告は誤検知の疑い
- claude-dev 10-06 を curl で取り直したところ、報告された日本語の指示文は生の HTML に無かった。文面は lint が WebFetch に渡した問いと同じ形で、WebFetch の加工結果を見誤ったものと見られる（推測）。

## [2026-10-10] check | engineering と research（初回）
- engineering: 一覧の 25 件はすべて未取り込み。特集「How we contain Claude across products」の公開日は 2026-05-25。取り込み対象 21 件、境界 2 件。
- research: 未取り込みの対象 3 件（10-09 Investigating unintended model actions、10-08 OSS 向け脆弱性発見サービス、09-29 GLM-5.3 とサイバー能力の拡散）、境界 1 件（10-01 Claude-shaped science）。「See more」より先は未確認。

## [2026-10-10] skip | engineering と research の対象外
- engineering: Designing AI-resistant technical evaluations（採用の選考の話）、Introducing Contextual Retrieval（RAG の手法）。
- research: The missing map of the sky、What work can robots do?、What do you want from AI?、How Claude is uplifting biomolecular modeling、Measurements for understanding the pace of AI development、Project Swap、Yes, Claude can do Nine Loops、Scenarios for our Economic Future（いずれも Claude Code との関係が薄い）。

## [2026-10-10] ingest | engineering 8件と research 4件（初回）
- 人間の指示により、engineering は 2026 年の8件、research は4件を取り込んだ。系統ごとに概念ページを分け、並行して取り込んだ。新しいページは `review: pending`。
- 新しい概念ページ: agent-evals、auto-mode、claude-code-quality-incidents、long-running-agent-harness、oss-scanner、sandboxing、unintended-model-actions。
- engineering/2026-04-08-scaling-managed-agents: concepts/managed-agents に「設計思想（公開時点）」を追加。記事の関数名が現行 API と一致するかは未確認。
- research/2026-09-29-glm-5-3-…: `wiki/sources/research/` を新設。concepts/cyber-safeguards に API 側の回避耐性と防御側へのアクセス方針を追加。
- engineering/2026-01-09-demystifying-evals-for-ai-agents: 新しい概念ページ agent-evals を作った。モデル名と数値は公開時点の値として扱った。
- engineering/2026-03-25-claude-code-auto-mode: 新しい概念ページ auto-mode を作った。分類器のモデルと数値は公開時点の値で、5.5 世代でも同じかは未確認（docs の auto mode ページは未 Ingest）。
- engineering/2026-02-05-infrastructure-noise: concepts/agent-evals に、実行環境の資源設定がスコアに与える影響を追記した。
- engineering/2026-04-23-an-update-on-recent-claude-code-quality-reports: 新しい概念ページ claude-code-quality-incidents を作った。concepts/effort と prompt-caching の変更履歴に、公開時点の値として追記した。
- research/2026-10-08-launching-opt-in-vuln-finding-service-for-open-source: 新しい概念ページ oss-scanner を作った（3つの資料に出てくるため）。真陽性率が Cyber Mission の発表（90% 超の見込み）と食い違うため、未解決に残した。
- engineering/2026-05-25-how-we-contain-claude: 新しい概念ページ sandboxing を作った。auto-mode、hooks、cloud-sessions を更新した。docs のサンドボックスのページは未 Ingest のため、現行との照合はしていない。
- engineering/2026-02-05-building-a-c-compiler-with-parallel-claudes: 新しい概念ページ long-running-agent-harness を作った。subagents と agent-evals に1行ずつ追記した。モデル名と数値は公開時点（Opus 4.6）の値。
- research/2026-10-09-investigating-unintended-model-actions: 新しい概念ページ unintended-model-actions を作った。cyber-safeguards と oss-scanner を更新した。記事が触れる夏のインシデント（7/30、9/9）は未 Ingest。
- engineering/2026-03-24-harness-design-long-running-apps: long-running-agent-harness、agent-evals、subagents を更新した。現行モデルでも記事の前提が成り立つかは未確認として残した。
- research/2026-10-01-claude-shaped-science: subagents と long-running-agent-harness に実践例を1行ずつ追記した（一人称の実践談で、docs では未確認）。
- 古い記事のモデル名と数値は「公開時点の値」として扱い、概念ページの現状を上書きしていない。

## [2026-10-10] error | engineering の取得で別の記事が返った
- engineering の auto mode の記事を curl で取ると、1回目は別の記事（research の GLM-5.3）が返った。2回目で正しい記事を取れた（title と canonical で確認）。原因は分からない。
- 以後の取り込みでは、生 HTML の title と canonical を確かめた。ほかの記事では一致した。

## [2026-10-10] ingest | docs の auto mode とサンドボックス
- 人間の指示により、docs の auto-mode-config、sandboxing、permission-modes を取り込んだ（permission-modes は auto mode 本体の仕様が載るため追加した）。
- docs/2026-10-10-auto-mode-config: concepts/auto-mode を docs の仕様で更新した（提供範囲、設定キー、CLI、優先順位）。既定の block rules は一部を確かめ、全文は `claude auto-mode defaults` で見る前提。分類器のモデルと数値は設定ページに記載が無い。
- docs/2026-10-10-sandboxing: concepts/sandboxing の現状を docs に基づいて書き直した。記事（2026-05-25）の記述は docs と矛盾せず、「公開時点」として残した。記事の数値（プロンプト 84% 減など）は docs に記載が無い。
- docs/2026-10-10-permission-modes: concepts/auto-mode の未解決を docs で閉じた。分類器の既定は Sonnet 5（engineering の記事の Sonnet 4.6 は公開時点の値）。対応プランと対応モデル、既定でブロックするもの、critical paths を反映した。`claude -p` で拒否が上限に達したときの挙動は、記事（終了する）と docs（作業を続ける）で食い違うため、docs を採った。
- サンドボックスと auto mode の組み合わせ（コマンドごとのホストの審査、v2.1.271 以降）を auto-mode に追記した。FPR などの性能の数値は docs に記載が無く、未解決に残した。

## [2026-10-10] query | mods の作り方
- concepts/mods、claude-dev と claude-blog の mods 記事（2026-10-01）、CHANGELOG v2.1.290〜296 をもとに回答した。いずれも review: ok。
- 不足: plugin.json の全フィールド、hooks.json とモジュールのコード例、`$` API の引数。取り込み候補は docs の mods overview（https://code.claude.com/docs/en/plugins/mods/overview）。

## [2026-10-10] ingest | docs の mods
- 人間の指示により、docs の Mods（plugins/mods 配下の overview、create、events、api、reference、test、admin、interface、troubleshoot）と plugins の manifest-reference、publish を取り込んだ。reference は v2.1.290 時点。
- 追加: sources/docs/2026-10-10-mods。更新: concepts/mods（plugin.json、register の例、`$` の API、テスト、型定義、ディレクトリ構成、組み込み mod、管理者設定、公開手順）。
- 食い違い: claude-dev の記事（2026-10-01）にあるイベント `session.usage` が docs の一覧に無い。近いのは `session.measure` と `$.session.usage()`。docs を現状とし、concepts/mods の未解決に残した。
- 版の差: 記事は 2.1.287 以降とするが、docs は Desktop のみ 2.1.286 以降。
- 未取得: interface と troubleshoot の細部、申請の審査の中身（claude.com 側）。

## [2026-10-11] query | mods の作り方を analysis に保存
- 人間の指示により、docs の mods 取り込み後の内容で analysis/mods-howto を作った。出典は docs/2026-10-10-mods を主に、claude-dev と claude-blog の記事、CHANGELOG v2.1.290〜296。

## [2026-10-11] check | 毎日チェック 1〜6
- gh-releases、gh-changelog: 新規なし（最新 2.1.296）。gh-releases の通常 URL は今回取得できた。
- npm: latest／next 2.1.296、stable 2.1.287（status.md の値と同じ）。
- claude-blog: 新規なし（Block の事例は 10-10 に skip 済み）。
- anthropic-news: 新規なし。台帳に無い 2026-09-01「Developing Enterprise Frontier Safeguards with our customers」を検出（初回 Ingest の範囲外）。
- claude-dev: 台帳に無い 2026-07-24「The new rules of context engineering for Claude 5 generation models」を検出（初回 Ingest の範囲外）。一覧の LOAD MORE より古い記事は未確認。
- 取得の失敗、ページ内の指示文: なし。

## [2026-10-11] ingest | 初回範囲より前の記事2件
- 台帳に無い記事を Check で検出し、取り込んだ。初回 Ingest（直近約1か月）の範囲外だが、人間の了承を得て残した。
- claude-dev/2026-07-24-new-rules-of-context-engineering-claude-5: concepts/context-engineering を新規作成。concepts/claude-opus-5-5 にリンクを追加。記事の対象は Opus 5 と Fable 5 で、5.5 世代への適用は推測として書いた。
- anthropic-news/2026-09-01-enterprise-frontier-safeguards: concepts/enterprise-frontier-safeguards を新規作成。concepts/cyber-safeguards に追記。公開日はページ表示の Sep 1, 2026（メタデータは JST で 09-02 08:31）。docs 側の EFS 設定は未確認。

## [2026-10-16] check | 毎日チェック 1〜6
- gh-releases、gh-changelog、npm: 新規 2.1.299〜2.1.301。latest／next 2.1.301、stable 2.1.292。2.1.297 と 2.1.298 は CHANGELOG・npm ともに無い。
- claude-blog: 新規 2026-10-15「Code Review is now generally available」。?page=2 に初回範囲より前の Claude Code 関連記事 8件（2026-08-06〜08-24）を検出。
- anthropic-news: 新規 3件（10-15 independent evaluators、10-14 US midterms、10-14 Singapore office）。
- claude-dev: 新規 2026-10-15「How the Claude Code team does code review」。
- 取得の失敗、ページ内の指示文: なし。
## [2026-10-16] skip | Anthropic opens Singapore office and signs MOU with the Government of Singapore | 拠点開設と MOU
## [2026-10-16] skip | The AI-native SDLC playbook | 初回範囲より前の手引き。人間の判断で見送り
## [2026-10-16] skip | The Claude Code guide for startups | 初回範囲より前の手引き。人間の判断で見送り
## [2026-10-16] skip | How an Anthropic field marketer uses Claude Code to send weekly personalized updates to every sales rep | 初回範囲より前の社内事例。人間の判断で見送り

## [2026-10-16] ingest | 2.1.299〜2.1.301、Code Review、anthropic-news 2件
- gh-changelog/2026-10-16-v2-1-299-to-2-1-301: mods、mcp、prompt-caching、hooks、sandboxing、claude-tag、claude-apps-gateway を更新。非互換の可能性: MCP の allow ルールが名前で指したサーバーだけに効くようになった（2.1.299）。`last_seen_version` を 2.1.301 に更新。
- claude-blog/2026-10-15-code-review-is-now-generally-available、docs/2026-10-16-code-review、claude-dev/2026-10-15-how-the-claude-code-team-does-code-review: concepts/code-review を新規作成。研究プレビュー期の仕様は一次資料が無く未確認。docs は概要ページのみ取得。
- anthropic-news/2026-10-15-an-update-on-independent-evaluators: 概念ページは作らず（Claude Code と無関係で単一の資料）。
- anthropic-news/2026-10-14-2026-us-midterms: concepts/cyber-safeguards に選挙の誤用対策を追記。
## [2026-10-16] ingest | claude-blog の過去分5件（2026-08-06〜08-14）
- 人間の了承を得て、初回範囲より前の記事のうち仕様に関わる5件を取り込んだ。
- 2026-08-07 auto mode 既定化、2026-08-07 auto mode の本番運用: concepts/auto-mode を更新。既定化の範囲は docs（v2.1.283 以降は全プラン）を現状とし、記事の値は公開時点として残した。分類器の課金停止が今も有効かは未確認。
- 2026-08-06 self-hosted environments: concepts/cloud-sessions を更新。docs の self-hosted ページとは未照合。
- 2026-08-11 Compliance API: concepts/compliance-api を新規作成（platform-docs のリリースノートと統合）。M365 アドインの GA 時期の食い違いを未解決に残した。
- 2026-08-14 セッションの費用: prompt-caching、effort、fast-mode、subagents、context-engineering を更新。「`/effort` でキャッシュが壊れる」は docs を現状として解決済みで閉じた。
## [2026-10-16] schema | レビュー待ちの一覧ページを追加
- 人間の了承を得て `review-queue.base` を追加した。Obsidian の Bases で、`sources/` のうち review が ok でないページを取得日の新しい順に表示する。index の「状態」からリンクした。

## [2026-10-16] query | Code Review の使い方
- concepts/code-review、docs/2026-10-16-code-review、claude-blog と claude-dev の 2026-10-15 の記事をもとに回答した。いずれも review: pending。
- 不足: docs の下位ページ（setup、customize、pull-requests、troubleshooting、costs）、レベルの選び方、費用の単価、クレジットの条件。

## [2026-10-16] ingest | docs の Code Review 下位ページ
- 人間の指示により、docs の code-review の下位5ページ（setup、customize、pull-requests、costs、troubleshooting）を取得し、sources/docs/2026-10-16-code-review に統合した。URL は llms.txt で確認した。
- concepts/code-review を更新（有効化手順、`REVIEW.md` の読み込み元、`@claude review` 系のコマンド、費用と月次の支出上限、トラブルシューティング）。記事との食い違いは無し。
- 未確認: 1レビューあたりの単価（docs に数値なし）、Enterprise のクレジット条件。未取得: code-review-local、ultrareview、github-actions、github-enterprise-server。

## [2026-10-16] schema | Git の運用を GitHub Flow の簡略版に変更
- 人間の指示により、Git-Flow をやめ、`main` だけを使う運用にした。wiki の取り込みとレビューは `main` に直接コミットし、規則と設定の変更だけを短命のブランチと PR で行う。CLAUDE.md に「Git の運用」節を追加した。
- `develop` ブランチを手元と GitHub から削除した（`main` にマージ済み）。

## [2026-10-16] schema | クラウドの routine による毎日の自動実行の手順
- 人間の指示により `rules/daily-routine.md` を追加した。routine は `claude/daily-<日付>` のブランチで Check と Ingest を行い、PR を作る。迷うもの（過去分、関係の薄いもの）は取り込まず「保留」として PR に挙げる。
- CLAUDE.md の Git の運用に、routine の例外（ブランチと PR、マージは人間）を追記した。予定を組むのは運用の段階どおり 2026-10-24 以降。それまでは手動で1回ずつ試す。

## [2026-10-16] ingest | docs の routines と cloud sessions
- 人間の質問（routine の料金）に答えるため、docs の routines、claude-code-on-the-web、cloud-environments、web-quickstart と settings の該当節を取り込んだ。sources/docs/2026-10-16-routines-and-cloud-sessions を作成し、concepts/routines と concepts/cloud-sessions を更新した。
- 要点: 実行はサブスクリプションの利用枠を消費し、VM の別料金は無い。スケジュール実行は1時間あたり100回（アカウント）など。push 先はプロンプトで変えられる。既定の環境（Trusted）の許可リストに claude.dev は無い（cloud-environments の Default allowed domains で確認）。
- docs に記載なし: ask ルールの無人実行での扱い、同時実行数、1回の実行時間の上限。

## [2026-10-16] check | 毎日チェック 1〜6（routine）
- gh-releases、gh-changelog、npm: 新規なし（最新 2.1.301。latest／next 2.1.301、stable 2.1.292）。status.md の値と同じ。
- claude-blog、anthropic-news、claude-dev: 新規・過去分なし（一覧の記事はすべて登録済みか skip 済み）。anthropic-news と claude.dev は「See more」「Load more」より先は未確認。
- 取得の失敗、ページ内の指示文: なし。

## [2026-10-17] schema | routine が確認のルールで止まる問題への対処
- 2026-10-16 の試しの実行で、routine が `Bash(git push *)` の ask ルールで止まった。docs（permission-modes）のとおり、ask ルールはどのモードでも自動では通らない。
- `Bash(git push *)` と `Edit(/sources.md)` の ask ルールを、リポジトリの設定から手元だけの `.claude/settings.local.json` に移した。
- routine の push は、環境変数 `WIKI_ROUTINE` があるときだけ働くフック `.claude/hooks/routine-guard.sh` で、`claude/` のブランチの単独の push に絞った。GitHub の道具も読み取りと PR 作成だけにした。テストは `tests/test-routine-guard.sh`。
- 手順書に、巡回の二度手間をしないこと、PR を作ったら見張らずに終えることを足した。
