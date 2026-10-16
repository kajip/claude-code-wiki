---
type: concept
title: Code Review（GitHub App による PR 自動レビュー）
updated: 2026-10-16
sources:
  - sources/claude-blog/2026-10-15-code-review-is-now-generally-available
  - sources/docs/2026-10-16-code-review
  - sources/claude-dev/2026-10-15-how-the-claude-code-team-does-code-review
---

# Code Review

## 概要

Claude が GitHub の PR を自動でレビューする機能。複数エージェントが差分と周辺コードを調べ、検証を経た指摘をインラインコメントとチェックランで返す（[[sources/docs/2026-10-16-code-review]]）。2026-10-15 に研究プレビューから GA になった（[[sources/claude-blog/2026-10-15-code-review-is-now-generally-available]]）。

## 現状（as of 2026-10-16）

- 段階: 一般提供（GA）。研究プレビューは終了（[[sources/claude-blog/2026-10-15-code-review-is-now-generally-available]]）。
- 提供プラン: Team と Enterprise。GitHub のリポジトリ（GitHub Enterprise Server、データレジデンシー付き Enterprise Cloud を含む）が対象（[[sources/docs/2026-10-16-code-review]]）。
- 非対応: Zero Data Retention、HIPAA 構成、CMEK 利用の組織。BAA の対象外（[[sources/docs/2026-10-16-code-review]]）。
- モード（レビューレベル）: Quick（最速・最安）/ Standard（既定）/ Deep（最も徹底）。Owner が組織の既定を選び、リポジトリごとに上書きできる。モデルの選択肢は無い（[[sources/docs/2026-10-16-code-review]]、[[sources/claude-blog/2026-10-15-code-review-is-now-generally-available]]）。
- 有効化: 管理者（docs では Owner）が設定で有効にし、GitHub App を入れてリポジトリを選ぶ。開発者側の設定は不要（[[sources/claude-blog/2026-10-15-code-review-is-now-generally-available]]）。
- 動作: PR を承認もブロックもしない。チェックラン名は Claude Code Review。リポジトリアクセスは読み取り専用で、コードは実行しない。`@claude review` コメントで手動開始できる（[[sources/docs/2026-10-16-code-review]]）。
- 調整: `REVIEW.md` と `CLAUDE.md`（[[sources/docs/2026-10-16-code-review]]）。
- 有効化の手順（docs）: Owner が Admin settings > Claude Code の **Allow code review** をオンにし、GitHub 連携、Claude GitHub App の導入、リポジトリ選択、**Finish**、テスト PR での確認の順に進む。GitHub 組織の Owner と各リポジトリの write 権限も要る。新規リポジトリの初期値は **After every push**（[[sources/docs/2026-10-16-code-review]]）。
- 実行タイミング（Review runs）: Once after PR creation / After every push / Manual (@claude review)。リポジトリごとに設定。GitHub 組織全体を一括でカバーする設定もあるが、github.com 上の組織で月次支出上限の設定が必須（[[sources/docs/2026-10-16-code-review]]）。
- PR 上の動作: 指摘は 🔴 Important / 🟡 Nit / 🟣 Pre-existing。却下はスレッドの resolve のみ（返信だけでは却下にならない）。チェックランは neutral か skipped で失敗にならない。コマンドは `@claude review`（1回）、`@claude review always`（push 購読）、`@claude review once`。write 権限が必要。ドラフトとフォークは自動対象外（[[sources/docs/2026-10-16-code-review]]）。
- `REVIEW.md` / `CLAUDE.md`: サービスは両方を読み、手元の `/code-review` は `CLAUDE.md` のみ。`REVIEW.md` は PR 自身ではなく base または既定ブランチから読む。保護された既定ブランチのルートファイルでは、重大度の引き下げ、除外、nit の上限が有効。サブディレクトリの `REVIEW.md` は保護条件を満たすときのみ。書式は自由な Markdown（Important の定義、nit の上限、対象外、必ず確認する項目の見出し例が docs にある）（[[sources/docs/2026-10-16-code-review]]）。
- 費用: 定額の1レビュー価格は無く、トークン使用量に応じて usage credits から組織に課金される。docs に単価の数値は無い。月次の支出上限は claude.ai/admin-settings/usage で設定し、Code Review の上限、組織の上限、クレジット残高のいずれかが尽きるとスキップされ、PR に "⚠️ Code review skipped" で始まるコメントが付く。使用量は claude.ai/analytics/code-review（[[sources/docs/2026-10-16-code-review]]）。
- トラブルシューティング: まず **Claude Code Review** チェックランのタイトルを見る（queued / in progress / found no issues / skipped — no new changes / failed / timed out / declined）。失敗は `@claude review` か Re-run で再実行（[[sources/docs/2026-10-16-code-review]]）。
- GA 時点の改善（公開時点の値）: レビュー時間は約20分から6〜10分へ（約3倍速）（[[sources/claude-blog/2026-10-15-code-review-is-now-generally-available]]）。
- Enterprise 向けに $10,000 以上のクレジット（2027-01-15 までに申請、30日で失効、条件あり）（[[sources/claude-blog/2026-10-15-code-review-is-now-generally-available]]）。
- 代替手段: `/code-review`（任意のプラン）、Ultrareview、GitHub Actions / GitLab CI/CD（[[sources/docs/2026-10-16-code-review]]）。
- 社内運用の事例（記事の値、公開時点）: Claude Code チームは、ほとんどの PR を人間最大1人でマージしつつ revert とインシデントを増やさない方針。6〜9月にマージ済み PR は2倍超、差し戻し割合は40%超減少。プレビュー開始時、社内 PR の実質的な指摘付き割合は16%から54%（[[sources/claude-dev/2026-10-15-how-the-claude-code-team-does-code-review]]）。
- 社内のレビュー構成: 指摘は複数エージェントが探し、別グループの投票で残ったものだけ投稿。Important / Nit / Pre-existing のタグ付き。未解決の指摘（バグ・セキュリティ）があるとマージ不可。承認はリスク分類器で不要・1人・2人に分け、エージェントの承認は人間の承認に数えない（[[sources/claude-dev/2026-10-15-how-the-claude-code-team-does-code-review]]）。
- 収束対策（社内値）: 3回で打ち切り、数回後は差分のみ再レビュー。通るまでの平均レビュー回数は2.08から1.32、5回以上かかる割合は8.9%から1.5%（[[sources/claude-dev/2026-10-15-how-the-claude-code-team-does-code-review]]）。
- レビュアーの評価: 過去のインシデントと revert を評価セットにして毎日採点し、ノイズは指摘への反応で計測する（[[sources/claude-dev/2026-10-15-how-the-claude-code-team-does-code-review]]）。
- `REVIEW.md` の書き方（短く、失敗の定義、nit の上限、スキップするパス、ファイルと行の根拠）と導入手順は同記事に詳しい（[[sources/claude-dev/2026-10-15-how-the-claude-code-team-does-code-review]]）。

## 変更履歴

- 2026-10-16 — docs の下位ページ（setup / customize / pull-requests / costs / troubleshooting）を取り込み、有効化手順、`REVIEW.md` の読み込み元、コマンド、費用の仕組み、トラブルシューティングを追記（[[sources/docs/2026-10-16-code-review]]）。
- 2026-10-15 — claude.dev が社内のレビュー運用を公開（[[sources/claude-dev/2026-10-15-how-the-claude-code-team-does-code-review]]）。
- 2026-10-15 — 研究プレビューから GA へ。Team / Enterprise に提供。Quick / Standard / Deep をリポジトリ単位で選べるようにし、速度を約3倍にした（[[sources/claude-blog/2026-10-15-code-review-is-now-generally-available]]）。

## 未解決・矛盾

- 研究プレビュー期の仕様・提供範囲・料金は、wiki に一次資料が無く未確認（プレビュー時の対象プランなど）。
- 解決済み: 費用の仕組み（docs の code-review-costs）は取得した（2026-10-16）。残り: Enterprise クレジットの詳細条件、および1レビューあたりの金額の数値は docs に無く未確認。
- 食い違いは今のところ無し（docs 下位ページ取得後も、記事と docs の値の食い違いは見つからなかった。docs が記事より詳しい点は上記の現状に反映）。ブログは「Admins」、docs は「Owner」と表記（同じ役割を指すと推測）。
- 解決済み: claude.dev「How the Claude Code team does code review」を追記した（2026-10-16、[[sources/claude-dev/2026-10-15-how-the-claude-code-team-does-code-review]]）。
- 記事の社内値（revert 率40%超減、16%から54% など）は自己申告で、母数・測定方法が不明。製品の効果としては断定しない。
- 記事は「Admins が Quick / Standard / Deep を設定」と書き、docs は Owner と表記。同じ役割と推測（上記と同様）。docs の setup は Owner ロール（Claude 組織）と明記しており、docs を現状とする。
- 記事は「PR を承認しない」製品と、社内で低リスク変更を自動チェックのみでマージする運用を区別している。後者は社内運用で、製品機能ではない。
