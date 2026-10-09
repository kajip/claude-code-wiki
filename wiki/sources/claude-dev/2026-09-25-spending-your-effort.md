---
type: source
source_id: claude-dev
title: "Using Claude Code: Spending your effort"
url: https://claude.dev/blog/spending-your-effort/
published: 2026-09-25
retrieved: 2026-10-10
version:
tier: primary
review: ok
recheck: none
fingerprint:
archive_url:
---

# Using Claude Code: Spending your effort

## 要点

- effort は「タスクにどれだけ計算を使わせたいか」の目安。上げると、判断と検証を自分で進める度合いが増える。
- 目安: low は手早いやりとり、medium は普段の開発、high は検証が大事な作業や既存コードのバグ修正、max は難しい問題を完全に任せるとき。
- 推奨の流れ: 仕様を渡して足りない点を聞かせる → low で実装 → low で見直し → high で検証とテスト。
- effort を上げると、見落とした境界条件による失敗は減る。ただし、やり方そのものが間違っている失敗は直らない。

## 具体的な値

- 段階: low、medium、high、xhigh、max
- コマンド: `/effort`（会話の途中でも変えられる）
- 例: 仕様のあいまいなフィットネスアプリは low で1.5分、medium で4分、high で11分、max で67分。
- Fable 5.1（370試行）: low で140件合格（トークンの中央値 73k）、max で214件合格（中央値 222k）。

## 関連ページ

- [[concepts/effort]]

## 取り込みメモ

- 各モデルや各サービスでの既定の effort は、この記事には書かれていない。
- 数値は社内の実行（1タスク5試行）によるもので、公開のリーダーボードとは一致しないことがあると注記されている。
