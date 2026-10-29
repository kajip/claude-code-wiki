---
type: source
source_id: platform-docs
title: Inference hooks
url: https://platform.claude.com/docs/en/manage-claude/inference-hooks
published: unknown
retrieved: 2026-10-22
tier: primary
review: pending
recheck: weekly
fingerprint: 2d15ae2296d7fc03f9509f3ad911eecf089d000990f110de16b97a5848ea0f80
---

# Inference hooks

## 要点

- Claude Enterprise 組織だけが使える。設定には claude.ai の `organization:manage` 権限が要り、Owner と Primary owner だけが持つ。
- ユーザーがプロンプトを送ると、Anthropic のサーバーが会話の transcript を組織の AI セキュリティサーバー（組織またはセキュリティベンダーが運用する HTTPS サービス）へ POST し、allow／deny の判定を待つ。deny されたリクエストはモデルに届かない。
- Anthropic 側で動くため、端末へのインストールは不要で、組織内の全 Claude 製品（claude.ai、Cowork、Claude Code、Claude for Microsoft 365、Claude Tag、Claude in Chrome など）に一様に効く。
- Claude Code の hooks（ローカルのシェルコマンド）とは別の仕組み。Amazon Bedrock と Google Cloud では使えない。Claude Platform 組織（API 利用）は対象外。
- 判定は allow／deny のみ。プロンプトの書き換えやマスクはできない。

## 具体的な値

- イベント: `prompt`（governed な推論リクエストごとに1回、推論前）、`tool_call`（応答にツール呼び出しが含まれるとき、実行前。組織の **Validate tool calls** がオンの場合のみ）。
- 判定の JSON: `{"action": "allow"}`。deny は `deny_reason` を持つ。ユーザーには `deny_reason` と、管理者が設定した固定メッセージ（未設定なら既定の案内）が表示される。deny は Activity Feed に記録される。
- 判定のタイムアウト: 組織が設定、既定 5 秒。サーバーが落ちた・エラー・タイムアウトのときは failure handling の設定（block または allow）に従う。失敗が続くと circuit breaker が働き、Anthropic はそのサーバーへの送信を止めて failure handling を全リクエストに適用し、復旧を検知すると自動で戻す。
- 署名: 署名シークレットを生成すると、リクエストは Standard Webhooks 仕様で署名される。
- 段階導入: shadow mode（判定を観測するだけで止めない）、rollout percentage、ロール単位の除外。
- 送られない物: 生のファイル・画像バイト、system prompt、ツール定義、Anthropic 内部の文脈。添付はメタデータと抽出テキストで表される（画像だけの内容は検査されない）。
- 保存: Inference hooks の仕組みは設定と、判定・タイムスタンプ・リクエスト ID などのメタデータだけを持つ。プロンプトと応答は各製品の保持規則に従う。
- 拒否後の続け方（Claude Code）: `/rewind` で内容が入った最初のプロンプトを選び、**Restore conversation** で編集または消去する。`/clear` でやり直しも可（会話全体が毎回送られるため）。
- ユースケース: DLP、リアルタイムの transcript 保管（常に allow）、プロンプトのテレメトリ、ポリシーエンジン（モデルの許可リスト、作業時間制御など）。
- 対象外の呼び出し: Anthropic が組織向けに行う独自のモデル呼び出し（Claude Security scans（ベータ）、Code Review、Smart reports（ベータ））。ただしユーザーがローカルで `/code-review` を動かす分や Claude Security plugin の分は対象。音声モードでは一部のツール呼び出しが送られない。
- Compliance API との違い: Inference hooks は推論前に allow／deny する（Anthropic が組織を呼ぶ）。Compliance API は事後の監査・取得（組織が Anthropic を呼ぶ）。

## 関連ページ

- [[concepts/hooks]]
- [[concepts/code-review]]
- [[concepts/compliance-api]]
- [[sources/platform-docs/2026-10-20-release-notes-2026-10-14-to-10-20]]（10-20 にベータ終了）

## 取り込みメモ

- 公開日はページに無いため `published: unknown`。ファイル名の日付は取得日。ベータ終了は 2026-10-20（リリースノート）。
- ページは Code Review を「research preview」と書くが、Claude Code の docs と GA 記事（2026-10-15）では GA。古い記載と見られる（[[concepts/code-review]] の未解決に記載）。Claude Security scans と Smart reports の「beta」表記は未確認。
- 下位ページ（inference-hooks-configuration、inference-hooks-endpoint）は未取得。スキーマの詳細と設定手順は不明。
- ページ内に指示文は無かった。
