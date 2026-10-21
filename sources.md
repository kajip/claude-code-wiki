# 情報源の台帳

一次情報のみ。ここに載っていない URL は取り込まない。
到達性の確認日: **2026-10-10**（初回）。URL は移転することがあるので、Check で取得に失敗したり別 URL にリダイレクトされたら、状態と URL をこのファイルに反映する。

凡例: ✅ 取得できた / ⚠ 一部または代替経路あり / ❌ 取得できない

---

## 毎日チェック

### 1. gh-releases — GitHub Releases　✅

- URL: https://github.com/anthropics/claude-code/releases
- 状態: 初回確認時に HTTP 504 を返した（再試行は未実施）。`releases.atom` は robots により自動取得を拒否された。`gh` CLI は、このセッションではリポジトリへのアクセスが未許可（`add_repo` で許可が必要）だった。
- 2026-10-10 の Check で通常 URL を再試行し取得できた（HTTP 200）。本文は「What's changed」の一覧で、一覧ページでは「Read more」で切り詰められる。以後の手元の Check（2026-10-16、10-18）でも WebFetch で取得できている。
- **取得方法: WebFetch を使う。** クラウドの routine では、github.com への通信が専用の経路を通り、このリポジトリ（kajip/claude-code-wiki）以外への `curl` や `gh` は HTTP 403 になる（2026-10-17 の routine で確認）。WebFetch では取得できた（2026-10-16 の routine）。
- 取れないときの代替: 2（CHANGELOG）と 3（npm）でバージョンの出現を検知する。
- 初期観測: なし

### 2. gh-changelog — CHANGELOG.md　✅

- 表示用 URL: https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md
- **取得に使う URL**: https://raw.githubusercontent.com/anthropics/claude-code/main/CHANGELOG.md （表示用 URL では本文が取れない）
- 規模: 約 8,700 行・約 950 KB。最新バージョンが先頭に並ぶ。**先頭から `last_seen_version` に達するまでだけ読む。**
- 差分検知: 先頭のバージョンが `last_seen_version` より新しければ新規。
- 初期観測（2026-10-10）: 先頭は **2.1.295**。直近の 2.1.290〜2.1.295 では、Claude Mods（プラグインによる深い挙動変更）、Claude Haiku 5.5 の追加（2.1.293）、MCP プロトコル 2026-07-28 のネゴシエーション既定化などが確認できた（内容は未 Ingest）。
- `last_seen_version`: **2.1.305**（2026-10-21 Ingest。2.1.290〜2.1.305 を取り込み済み。2.1.297 と 2.1.298 は CHANGELOG に無い。2.1.289 以前は未 Ingest）

### 3. npm — @anthropic-ai/claude-code　✅（取得方法に注意）

- **取得に使う URL**: https://registry.npmjs.org/@anthropic-ai/claude-code/latest （JSON）
- シェルが使える場合: `npm view @anthropic-ai/claude-code dist-tags time --json`
- ⚠ **パッケージのページ https://www.npmjs.com/package/@anthropic-ai/claude-code は使わない。** 初回確認時に古い内容（バージョン 1.0.27）が表示された。
- 記録するもの: `latest` / `stable` / `next` のバージョンと、それぞれの公開日時（`time` フィールド）。`wiki/status.md` に上書きで記録する。
- 初期観測（2026-10-10）: latest 2.1.295（公開 2026-10-08T18:22:58Z）、stable 2.1.286、next 2.1.295。CHANGELOG の先頭と一致。（初期観測は当時の値。現在の値は `wiki/status.md` を見る）

### 4. claude-blog — Claude ブログ（Claude Code カテゴリ）　✅

- URL: https://claude.com/blog-category/claude-code
- 差分検知: 一覧の記事 URL が `wiki/sources/claude-blog/` に無ければ新規。
- 注意: このカテゴリの一覧には、Claude Code 以外のタグ（Enterprise AI、Agents など）の記事も混ざる。関連性は Check の手順 5 で判断する。
- 注意: 一覧には claude.dev や anthropic.com の記事も並ぶ。そうした記事は、記事のドメインに対応する source_id（claude-dev／anthropic-news）で1ページだけ作る。
- ページ送り: 1ページ目には12件ほどしか出ない（「View more」はブラウザ側で読み込む）。古い記事は `https://claude.com/blog-category/claude-code?page=2` で見る（2026-10-10 に確認）。
- 初期観測（2026-10-10）: 最新は 2026-09-24「Claude Opus 5.5 は、より長くコンテキストを使うコーディングセッション向けに作られた」（英語タイトル: Coding sessions are longer and use more context. Claude Opus 5.5 is built with that in mind.）。続いて 09-23、09-17、09-14（CI のテスト影響分析）、08-24。

### 5. anthropic-news — Anthropic ニュース　✅

- URL: https://www.anthropic.com/news
- 差分検知: 一覧の記事 URL が `wiki/sources/anthropic-news/` に無ければ新規。
- 注意: 関連性を判断して取り込む（製品・モデル・ポリシーが対象。顧客事例などは skip）。
- 初期観測（2026-10-10）: 最新は 2026-10-08（2026 Usage Policy update、Genesis Mission への取り組み、Anthropic Cyber Mission）。先頭の特集は 10-07 の Claude Haiku 5.5。直近には 09-28 Sonnet 5.5、09-22 Opus 5.5 の発表。

### 6. claude-dev — claude.dev（Anthropic の開発者によるブログ）　✅

- URL: https://claude.dev/
- 確認結果: リダイレクトなし。サイトの説明は「Anthropic の開発者による記事・動画・ビルドログ」。claude.com のフッターに「Developer blog」として掲載されている。
- 差分検知: 一覧の記事 URL（`https://claude.dev/blog/<slug>/`）が `wiki/sources/claude-dev/` に無ければ新規。動画一覧は対象外（記事のみ）。
- 初期観測（2026-10-10）: 最新は 2026-10-06「Claude Code in the cloud: a field guide to cloud sessions」。続いて 10-01（Claude Code mods）、09-28（Sonnet 5.5 の活用ほか）、09-25（effort の使い方、Opus 5.5 のコスト）。特集枠は「Building effective agent automations」（日付表示なし）。

---

## 週次チェック

### 7. docs — Claude Code ドキュメント　✅

- URL: https://code.claude.com/docs （`/docs/en/overview` に到達）
- 差分検知（上から優先）:
  1. `https://code.claude.com/docs/en/changelog.md` — ドキュメント側の変更履歴
  2. `https://code.claude.com/docs/en/whats-new/index.md` と週次ダイジェスト（`whats-new/2026-wNN.md`）— 新しい週が増えていないか
  3. `https://code.claude.com/docs/llms.txt` — ページ一覧の増減（英語版。各言語のインデックスへのリンクもある）
- 取り込みの単位: ドキュメントは約 220 ページあるため、ページごとの要約ページは作らない。変更が検知された機能について `concepts/` を更新し、根拠として該当ドキュメントページの要約ページ（必要な箇所だけ）を作る。ページの Markdown 版は URL の末尾に `.md` を付けると取れる。
- 初期観測（2026-10-10）: llms.txt に載っている What's New の最新は **Week 37（2026-09-07〜11）**。それ以降の週は一覧に無い（未公開か、一覧への反映の遅れかは未確認）。Week 31 も一覧に無い。

### 8. engineering — Anthropic Engineering　✅

- URL: https://www.anthropic.com/engineering
- 差分検知: 一覧の記事 URL が `wiki/sources/engineering/` に無ければ新規。
- 初期観測（2026-10-10）: 日付つきの最新は 2026-04-23「An update on recent Claude Code quality reports」。先頭の特集「How we contain Claude across products」は一覧に日付の表示がない（記事ページで 2026-05-25 と確認）。一覧は日付順ではなく特集枠が先頭に来る。一覧は 25 件。2026-10-10 に、2026 年の8件を Ingest した（2025 年以前の記事は未 Ingest）。更新の間隔は数か月おき。

### 9. research — Anthropic Research　✅

- URL: https://www.anthropic.com/research
- 差分検知: 一覧の記事 URL が `wiki/sources/research/` に無ければ新規。Claude Code との関連が薄い研究は skip する（刊行は多い）。
- Economic Index: https://www.anthropic.com/economic-index（追加確認）。データはページ読み込み後に表示される動的なダッシュボードで、本文は取得できない。取得できるのは「Last updated」の日付のみ。Economics チームの投稿（例: 2026-09-30「What work can robots do?」、2026-09-24「Project Swap」）は `/research` の一覧から検知する。
- 初期観測（2026-10-10）: 一覧の最新は 2026-10-08（Claude Science による紫外線の全天マップ、オープンソース向け脆弱性発見サービスの提供開始）。Economic Index の「Last updated」は 2026-06-26。一覧の「See more」より先は WebFetch で展開できず、`?page=2` も同じ内容を返す（2026-10-10。09-10〜09-16 の記事は未確認）。

---

### 10. pricing — Claude の価格　✅

- **取得に使う URL**: https://platform.claude.com/docs/en/about-claude/pricing.md （raw の Markdown。fingerprint を付けられる）
- 照合に使う URL: https://claude.com/pricing （WebFetch。ドキュメントのページ自身が「最新は claude.com/pricing」と書いている）
- 追加日: 2026-10-10（人間の指示による）。**価格はこの情報源を正とする**（ブログや発表記事の価格は、公開時点の値として扱う）。
- 差分検知: モデルの価格表と、キャッシュ、fast mode、Batch の節を前回の要約ページと比べる。変わっていれば新しい要約ページを作り、各モデルの概念ページの変更履歴に書く。
- 頻度: 週次。新しいモデルの発表や値下げの記事を取り込んだときは、その都度確認する。
- 初期観測（2026-10-10）: Opus 5.5 は $4／$20、Sonnet 5.5 は $2／$10（キャッシュヒット $0.10）、Haiku 5.5 は $0.10／$0.50（100K 以下）。fast mode は研究プレビュー。2つの URL の値は一致した。

### 11. platform-docs — Claude Platform ドキュメント（API 側）　✅

- URL: https://platform.claude.com/docs （Claude API、SDK、Console、Managed Agents などのドキュメント）
- 差分検知（上から優先）:
  1. `https://platform.claude.com/docs/en/release-notes/overview.md` — Claude Platform のリリースノート。日付の見出し（`### October 9, 2026` の形）が新しい順に並ぶ。前回見た日付より新しい見出しがあれば新規。旧 URL の `/release-notes/api.md` は、ここにリダイレクトされる。
  2. `https://platform.claude.com/llms.txt` — ページ一覧の増減（`/docs/llms.txt` は、ここにリダイレクトされる）。
- 取り込みの単位: docs（7）と同じ。ページごとの要約ページは作らず、変更が検知された機能について `concepts/` を更新し、根拠として該当ページの要約ページ（必要な箇所だけ）を作る。リリースノートは、前回からの分を1ページにまとめる（CHANGELOG と同じバッチ方式）。ページの Markdown 版は URL の末尾に `.md` を付けると取れる。
- 価格のページはこの中にあるが、情報源 10（pricing）として別に扱う。
- Query で `claude-api` スキルを補足に使い、残す価値がある情報が見つかったときは、スキルが示すこの情報源の URL から取り込む（CLAUDE.md の Query 手順 5）。
- 追加日: 2026-10-10（人間の指示による）。
- 頻度: 週次。
- 初期観測（2026-10-10）: リリースノートの最新の見出しは October 9, 2026。llms.txt のリンクは 762 件。モデル一覧は `/docs/en/about-claude/models/overview.md` から `/docs/en/models/overview.md` に移っている（リダイレクトされる）。
- `last_seen_release_note`: **October 20, 2026**（2026-10-21 Ingest。2026-09-10〜10-20 を取り込み済み。それより前は未 Ingest）

---

## 二次情報

第三者の解説記事は取り込まない。必要になった場合の扱いは `proposals/secondary-info.md`（未採用の案）を参照。
