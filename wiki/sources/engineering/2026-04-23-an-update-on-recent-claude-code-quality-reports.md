---
type: source
source_id: engineering
title: An update on recent Claude Code quality reports
url: https://www.anthropic.com/engineering/april-23-postmortem
published: 2026-04-23
retrieved: 2026-10-10
version: v2.1.116（3件すべて解消した版）
tier: primary
review: pending
recheck: none
fingerprint: 0f9a0d03e0025589850bb2c4a151b7cca3cb01d86d0973be1231c42d99b3c8f0
archive_url:
---

# An update on recent Claude Code quality reports

## 要点

- 「Claude の応答が悪くなった」という報告を調べた結果、Claude Code、Claude Agent SDK、Claude Cowork に影響した3つの別々の変更が原因だった。API と推論層は影響を受けていない。3件とも 2026-04-20（v2.1.116）までに解消。
- 変更1: 既定の reasoning effort を high から medium に下げた（3/4）。知能が下がったと不評で、4/7 に戻した。
- 変更2: 1時間以上アイドルだったセッションの古い thinking を消す最適化（3/26）。バグで毎ターン実行され続け、物忘れや繰り返し、キャッシュミスによる使用量の急減を招いた。4/10 に修正。
- 変更3: 冗長さを抑えるシステムプロンプトの一文（4/16）。コーディング品質を下げ、4/20 に取り消した。
- 再発防止として、公開ビルドの社内利用の拡大、Code Review の改善、システムプロンプト変更時のモデル別 eval・ablation・段階的ロールアウトを挙げている。4/23 に全購読者の使用上限をリセット。

## 具体的な値

- 影響モデル: 変更1と2は Sonnet 4.6、Opus 4.6。変更3は Sonnet 4.6、Opus 4.6、Opus 4.7。
- 変更1: 3月4日に Claude Code の既定 effort を high → medium。4月7日に戻した。以後の既定は Opus 4.7 が `xhigh`、ほかのモデルは `high`（公開時点の値）。変更は `/effort`。製品側が選んだ既定値が Messages API の `effort` パラメータとして送られる。対策として、起動時の通知、インラインの effort セレクタ、`ultrathink` の復活を行ったが、多くのユーザーは medium のままだった。
- 変更2: 3月26日。`clear_thinking_20251015` API ヘッダーと `keep:1` を使用。本来は1回だけ消すはずが、閾値を一度超えた後は毎ターン「直近の reasoning ブロックだけ残す」になった。ツール実行中の追加メッセージでは、現在のターンの reasoning も失われた。v2.1.101 で修正（4月10日）。発見まで1週間以上。
- 変更2の再現を妨げた要因: メッセージキューに関する社内限定のサーバー側実験と、thinking の表示方法の変更。
- 変更3: 追加された文は「keep text between tool calls to ≤25 words」「final responses to ≤100 words」の趣旨（制限は、ツール呼び出しの間のテキストが25語以下、最終回答が100語以下）。数週間の社内テストでは eval に回帰がなかったが、後の ablation で、より広い eval の1つが Opus 4.6 と 4.7 の両方で3%低下。4月20日のリリースで取り消し。
- 調査中の Code Review の後方検証: 必要なリポジトリを文脈として渡すと Opus 4.7 は変更2のバグを見つけ、Opus 4.6 は見つけなかった。複数リポジトリを文脈にする対応を進める。
- 再発防止: 社内スタッフの公開ビルド利用を増やす、Code Review の改善版を顧客に提供、システムプロンプト変更ごとのモデル別 eval、行ごとの ablation、レビュー・監査用の新ツール、CLAUDE.md にモデル固有の変更をそのモデルに限定する指針を追加、知能とトレードオフになる変更には soak 期間・広い eval・段階的ロールアウト。
- 4月23日に全購読者の使用上限をリセット。`/feedback` コマンドの報告が原因特定に役立った。説明の場として @ClaudeDevs（X）を新設し、GitHub にも同じ更新を載せる。

## 関連ページ

- [[concepts/claude-code-quality-incidents]]
- [[concepts/effort]]
- [[concepts/prompt-caching]]

## 取り込みメモ

- curl で記事ページの HTML を取得し、本文を抽出して読んだ（fingerprint は HTML の sha256）。
- 半年前の記事。モデル名（Opus 4.6/4.7、Sonnet 4.6）、バージョン、既定 effort は公開時点の値。現在の既定 effort は別の出典を参照（[[concepts/effort]]）。
- 「≤25 words」の文は短く言い換えて記載した。ページ内に読み手への指示文は見つからなかった。
