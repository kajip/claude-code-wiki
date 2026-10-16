---
type: source
source_id: engineering
title: "Scaling Managed Agents: Decoupling the brain from the hands"
url: https://www.anthropic.com/engineering/managed-agents
published: 2026-04-08
retrieved: 2026-10-10
version:
tier: primary
review: ok
recheck: none
fingerprint: aa5c593f123293ce8523fe9060fe3f3a07d0dc5af334bedac025d7bd734262db
archive_url:
---

# Scaling Managed Agents: Decoupling the brain from the hands

## 要点

- Managed Agents は Claude Platform 上でロングホライズンのエージェントを動かすホステッドサービスで、ハーネスが将来変わっても安定するインターフェースを軸に設計されている。
- エージェントの部品を session（追記専用のイベントログ）、harness（Claude を呼びツール呼び出しを振り分けるループ）、sandbox（コード実行環境）に仮想化し、互いに影響なく差し替えられるようにした。
- 当初は全部を1つのコンテナに入れていたが、コンテナが「ペット」になり、落ちるとセッションを失い、デバッグも困難だった。そこで brain（Claude + harness）を hands（sandbox とツール）と session から切り離した。
- 認証情報は sandbox から到達できない場所（vault、または git remote への埋め込み）に置き、プロンプトインジェクションでトークンを奪われる構造をなくした。
- コンテナを必要なときだけ tool call で起動する構成にした結果、公開時点で p50 TTFT が約 60%、p95 が 90% 超短縮した。

## 具体的な値

- インターフェース: `execute(name, input) → string`、`provision({resources})`、`wake(sessionId)`、`getSession(id)`、`emitEvent(id, event)`、`getEvents()`（位置によるスライス取得）。
- TTFT: 「p50 TTFT dropped roughly 60% and p95 dropped over 90%」（公開時点の値）。
- 例: Claude Sonnet 4.5 は context limit が近づくと作業を早く切り上げる「context anxiety」を示し、ハーネスに context reset を足して対処したが、Claude Opus 4.5 では挙動が消え、reset は不要になった。
- 認証: Git はリポジトリのアクセストークンを sandbox 初期化時の clone に使い、ローカルの git remote に組み込む（エージェントはトークンに触れない）。カスタムツールは MCP を使い、OAuth トークンは vault に保管。専用プロキシがセッションに紐づくトークンから vault の資格情報を取得して外部サービスを呼ぶ。harness は資格情報を知らない。
- 著者: Lance Martin、Gabe Cemaj、Michael Cohen。

## 関連ページ

- [[concepts/managed-agents]]
- [[concepts/prompt-caching]]（harness 側のコンテキスト整理でキャッシュヒット率を高める、という言及のみ）

## 取り込みメモ

- 半年前（2026-04-08）の設計思想の記事。API 名・インターフェース名は説明用で、現行の公開 API 名と一致するかは未確認（推測：概念的な表記）。現行仕様は platform-docs を優先する。
- 記事は Managed Agents のベータ状態や価格には触れていない。
- 記事中に Claude Code は「優れたハーネスの一例」として触れられ、Managed Agents はそれを含む任意のハーネスを載せられる meta-harness と位置づけられている。
- ページ内に指示文は見つからなかった。HTML から本文を抽出して読んだ（fingerprint は生 HTML の sha256）。
