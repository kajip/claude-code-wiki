---
type: source
source_id: claude-blog
title: Auto mode is now the default in Claude Code for Pro, Max, and Team plans
url: https://claude.com/resources/articles/auto-mode-default-in-claude-code
published: 2026-08-07
retrieved: 2026-10-16
version:
tier: primary
review: pending
recheck: none
fingerprint: df2d52e206f5e22cd31a268595af62f57e8bb970962778b0db7ea4b7b36cbc93
archive_url:
---

# Auto mode is now the default in Claude Code for Pro, Max, and Team plans

## 要点

- 2026-08-14 以降、Pro、Max、Team の新しいセッションは auto mode で始まる。既定を自分で別に設定済みの人には、切り替えを尋ねる1回限りのプロンプトが出る場合がある。既定を固定（pin）していれば変更なし。
- 分類器のトークン上乗せ分（tool call ごとに少量）は、Pro、Max、Team の Claude Code ユーザーには記事の公開日（2026-08-07）から課金しない。
- Enterprise、Claude API、Claude Platform on AWS、Bedrock、Google Cloud の Agent Platform、Foundry では、公開時点では opt-in のまま。「翌月中」に既定化し分類器の課金も止める計画。Enterprise 管理者は managed settings で先に既定にできる。
- 安全性の根拠として、1,053人の有償テスターの実験、Apollo Research の赤チーム、Trajectory Labs による prompt injection 評価、実セッション分析を提示。いずれも公開時点・Anthropic 側の主張。
- 新機能として、hard deny、データの取り扱いルール、git push／PR の宛先確認、破壊的 git 操作前の git status 参照、API 側の injection probe を紹介。
- 顧客事例（Adobe、Nuro、Gusto、Garner Health）と社内で防いだ3件の事例。末尾で、リスクを排除するものではなく、本番インフラの重大な変更は自分で確認することを推奨。

## 具体的な値

**提供・課金（公開時点）**
- 既定化の開始: 2026-08-14（Pro、Max、Team の新規セッション）。Enterprise ほかは「coming month」に予定。
- モード切替: CLI は Shift+Tab、desktop app はモード dropdown。
- 管理者設定: `defaultMode`（組織の既定を固定）、`disableAutoMode`（無効化）。記事の表記で、docs の正式キーは `permissions.disableAutoMode: "disable"`（[[sources/docs/2026-10-10-permission-modes]]）。
- 連続3回、またはセッション中に合計20回ブロックされると手動承認に戻る。

**安全性の数値（記事の主張、公開時点）**
- 承認率: 権限プロンプトの 97% が承認される。計画（plan）の承認では 39% が却下、個別の権限要求の却下率は 3%。
- 設定の実態（2026-06 時点）: アクティブな CLI ユーザーの 49.5% が Bash の allow ルールを作成（5% は任意のシェルコマンドを許可、43% は `Bash(python:*)`、`Bash(node:*)` 等のインタープリタルール）。62% が `bypassPermissions` か「don't ask again」を使用。対話セッションの 25% が bypass permissions で開始。
- 1,053人の実験: 危険なコマンドを人間は 13.6%（143/1,053）止め、auto mode は 89%（937/1,053）。auto mode だけが止めたのが 800件、人間だけが止めたのが 6件。人間の阻止率は序盤約 17%、50回以上のプロンプト後は約 5%。テストは研究用の環境で、承認しても実害は出ない設計。
- 実セッション（2026-05〜06、安全パイプラインがフラグした分、データ利用に opt-in したアカウントのみ）: 本番級（深刻度7以上）でユーザーが明示していない有害行為を含む割合は、手動承認 6.3%、auto mode 2.4%。
- Apollo Research（2週間のパイロット、合成攻撃）: 分類器の見逃し率 12% → 7%。保留した攻撃セットでは、以前の見逃しの約半分を捕捉し、以前捕捉していたものの約 2% を見逃すようになった。7% は実トラフィックの見逃し率ではないと明記。
- Trajectory Labs（2026-07-17 時点の公開版、Claude Code v2.1.205 と Codex v0.144.5、72シナリオ×10回）: auto mode の Claude Fable 5、Opus 5、Sonnet 5 に対し 720回の攻撃は全て失敗。最新モデルの `bypassPermissions` での平均攻撃成功率 0.09%。比較対象の GPT-5.6 Sol は Codex の Auto-review で 5.83%、Full Access で 19.03%。ブラウザ連携は評価用の薄いラッパーで、公式のブラウザ拡張の防御は未評価。
- 生産性: Teams と Enterprise の導入者で、auto mode ユーザーの PR 数が約 25% 多い。

**新機能・挙動（公開時点）**
- 広すぎる allow ルール（`python:*` のような任意コード実行相当）は auto mode 中は退避され、設定ファイルは変更されず、別モードに戻れば再び有効。それ以外の権限ルールは分類器より先に評価される。
- Hard denies: データ流出（コードや秘密情報の外部送信）は分類器が承認しない領域。実行するには auto mode を抜けるか自分で実行。設定でルールを追加できる。
- git push／PR の宛先が public、private、trusted のどれかを実行前に確認。
- `git reset --hard` など作業内容を捨てうるコマンドの前に、分類器が git status を参照。
- 外部コンテンツ（Web ページ、ファイル、ツール出力）を API 側の probe が injection について検査し、疑わしければ結果が共有される前に警告を Claude のコンテキストに追加。

**顧客事例**
- Adobe（Adobe.com の商品・販促ページ、90か国以上・30言語以上）、Nuro（夜間の研究エージェント）、Gusto（mid-May 以降のセッションの約 10% に分類器の拒否）、Garner Health（550人に managed settings で既定配布）。
- Anthropic 社内でも既定。防いだ例: 公開コード共有サイトへのレポート公開、約2000 pod への一括プロセス kill、読み取り専用の課金権限の依頼に対するアカウントルートの管理者ロール付与。

## 関連ページ

- [[concepts/auto-mode]]
- [[sources/engineering/2026-03-25-claude-code-auto-mode]]
- [[sources/docs/2026-10-10-permission-modes]]
- [[sources/docs/2026-10-10-auto-mode-config]]

## 取り込みメモ

- 日付は記事ページの `article:published_time`（2026-08-07）と本文の Date 表示で確認。一覧の日付と一致。
- fingerprint は curl で取得した記事 HTML の sha256。本文は HTML から抽出して読んだ。図表（グラフ）の画像内の数値は読んでいない。
- 記事の冒頭要約は「will soon run」と書く一方、本文は「We're making auto mode the default」。公開日時点では 2026-08-14 の開始は未来。実際に開始したかは記事では確認できない（docs の v2.1.283 以降の記載を参照）。
- 分類器の課金停止の扱いは pricing では確認していない（未確認）。
- ページ内に、エージェントへの指示文は見つからなかった。
