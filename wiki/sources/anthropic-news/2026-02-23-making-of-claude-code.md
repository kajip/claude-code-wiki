---
type: source
source_id: anthropic-news
title: The Making of Claude Code
url: https://www.anthropic.com/features/making-of-claude-code
published: 2026-02-23
retrieved: 2026-11-07
version:
tier: primary
review: pending
recheck: none
fingerprint: 41b3234618027930fb534953270891126149f29c86c3e047d48ec3ff34ffeae8
archive_url:
---

# The Making of Claude Code

## 要点

- Claude Code の開発経緯を、Anthropic の関係者（Ben Mann、Boris Cherny、Sid Bidasaria、Cat Wu、Shauna Kravec ら）と外部ユーザー（Ramp、Bun の創業者など）の証言で綴った特集記事。製品仕様の記事ではなく、公開時点（2026-02）の回想・談話集。
- 前史: 2022年に最初のコーディングアシスタント（VS Code 拡張）と RL によるエージェント学習があり、社内 CLI ツール「clide」（bash tool なし。Haiku を100並列で fan out する機能あり）を経て、2024年9月にBoris Cherny が Labs チームで「Claude CLI」を試作した。
- Claude CLI は2024年12月の約2週間のスプリントで中核機能（バグ報告、ログインフロー等）が作られ、2025年2月に research preview として公開、同時に Claude Code へ改名された。初期は PR・レビュー制限なし、自動更新とユーザーメトリクスで修正を即配信した。
- 転機は Claude 4 系モデルと、サブスクリプション提供の組み合わせだったと Boris Cherny が述べている（「モデルの革新」と「ビジネスモデルの革新」）。
- 利用実態の談話: 初期は全 permission request を読んでいたが、今は多くのユーザーが auto-accept している（Cat Wu）。Cherny 自身のコードは2025年2月に約10%、5月に30〜40%、2025年冬に100%が Claude Code 製とのこと。

## 具体的な値

- 2024年1月: Ben Mann が Labs チームを開始。2024年9月: Boris Cherny が Labs に参加し Claude CLI を試作（約2日の作業）。
- 2024年8月: Sid Bidasaria が Labs 参加。2024年10月: Cherny がエンジニア増員を要請。2024年12月: 正式承認後、6〜7人が加わり約2週間のスプリント。
- 2025年2月: research preview として公開、Claude CLI から Claude Code へ改名（Alex Isken が命名を提案）。
- 2022年春: 初期のコーディングアシスタントの外部ユーザーは約100人。
- 2025年（時期不明、記事は 8〜9月と推測の形で言及）: Bun で Claude Code 禁止の議論があった（Jarred Sumner の回想）。
- 「88 commits」を1日で書いた（Cherny の談話）。Shauna Kravec は12個の Claude を並行利用。
- 具体的なコマンド・設定キー・価格・プラン名の記載は無し。

## 関連ページ

- [[concepts/auto-mode]]（auto-accept に関する談話の背景。現行仕様は同ページと docs 側を正とする）
- [[concepts/mcp]]（Labs の一部が MCP チームになったとの言及のみ）

## 取り込みメモ

- 記事ページは Next.js の埋め込みデータ（CMS の rich text）から本文を取り出した。ターミナル風 UI のため通常の HTML 本文は無い。fingerprint は curl で取得した HTML 全体の sha256。文字化け（アポストロフィ等）は抽出時のもので、記事の意味には影響しない。一部の本文はリンク／画像要素のため欠落しており、固有名詞が空に見える箇所がある（例: 公開時の動画・ロゴ等）。
- 公開日 2026-02-23 は依頼文（一覧での表示）による。記事ページ本体からは公開日を読み取れなかった（推測を含まないが未確認）。
- 食い違いの確認: 現行仕様と矛盾する記述は無し。ただし「多くのユーザーが auto-accept」は2026-02時点の談話で、auto mode の現行仕様は [[concepts/auto-mode]] と docs を優先する。概念ページは更新していない（新規の概念も作っていない）。
- ページ内に AI への指示文は見つからなかった。
