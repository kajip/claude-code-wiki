---
type: source
source_id: claude-blog
title: Run Claude Code sessions on your own compute
url: https://claude.com/resources/articles/run-claude-code-sessions-on-your-own-compute
published: 2026-08-06
retrieved: 2026-10-16
version:
tier: primary
review: pending
recheck: weekly
fingerprint: d59496d404e4b2cd2eb567eece9d32af4e4dac97cd629c6847588c8a78446d8a
archive_url:
---

# Run Claude Code sessions on your own compute

## 要点

- self-hosted environments が public beta になった。Web、モバイル、デスクトップ、routine から始めたセッションを、自社ネットワーク内のインフラで動かせる。
- ほとんどの企業にはホスト版を強く推奨している。self-hosted は、ネットワーク・ツール・コンプライアンス上の要件でエージェントの実行を自社管理下に置きたいチーム向けで、構築と保守に専任のエンジニアが要る。
- 採用理由は3つ: 内部サービス／DB／レジストリへのネットワークアクセス、コンパイラや社内 CLI を事前に入れられるカスタマイズ性、ソースコードとビルド成果物を自社管理下に置けるコンプライアンス。
- データの扱い: リポジトリの checkout、ビルド成果物、シークレット、セッションが作成・変更したファイルは自社インフラに残る。会話（プロンプト、応答、ツール結果）は推論のため Anthropic に送られ、transcript も保存される（どの面からでもセッションを再開できるようにするため）。
- 仕組み: 常駐プロセスの runner がセッションを拾い、セッションごとに Claude Code プロセスを起動する。runner は Fixed（台数固定）と On-demand（orchestrator が待機中のセッションに応じて runner を起動・停止）の2モード。
- Remote Control とは別物: Remote Control は開発者本人のマシン上のセッションを手元の端末から続ける仕組みで、そのマシンが止まると終わり、実行ユーザーに紐づく。self-hosted は platform チームが運用する共有インフラで、誰でも使える。

## 具体的な値

- 提供段階: public beta。Claude Team と Enterprise プラン。デフォルトはオフ。ZDR の組織では使えない。
- runner のモード: Fixed／On-demand（orchestrator が runner を起動・停止）。
- 1つの runner が複数セッションを扱えるが、各セッションは専用の checkout で動き、開発者・アカウント間で分離される。
- 全対応サーフェスのセッションが同じ environment にルーティングされる。
- 運用側の作業: runner イメージの構築・保守、runner の更新、On-demand では orchestrator の運用。
- フィードバック先: GitHub または Anthropic のアカウントチーム。

## 関連ページ

- [[concepts/cloud-sessions]]
- [[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]]
- [[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]

## 取り込みメモ

- ブラウザのタブタイトルは「Self-hosted environments for Claude Code」だが、記事の見出しは依頼どおり「Run Claude Code sessions on your own compute」。日付 August 6, 2026 は記事ページで確認済み（一覧と一致）。
- 記事は2分の短い紹介で、セットアップ手順やコマンド、設定名は書かれていない（docs へのリンクのみ）。docs の self-hosted ページは wiki にまだ要約が無く、仕様・提供範囲の照合は未実施。
- 顧客の引用が1件あるが、要約には含めていない。
- ページ内に指示文は無かった。
