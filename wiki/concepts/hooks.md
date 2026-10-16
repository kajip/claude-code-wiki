---
type: concept
title: hooks（設定のフック）
updated: 2026-10-16
sources:
  - sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296
  - sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301
  - sources/claude-dev/2026-10-01-getting-started-with-claude-code-mods
  - sources/claude-dev/2026-10-06-claude-code-in-the-cloud
  - sources/engineering/2026-05-25-how-we-contain-claude
---

# hooks（設定のフック）

## 概要

イベントごとにシェルコマンドなどを動かす仕組み。JSON を stdin／stdout でやりとりする。mods と違い、イベントの書き換えや UI の描画はできない（[[sources/claude-dev/2026-10-01-getting-started-with-claude-code-mods]]）。→ [[concepts/mods]]

## 現状（as of 2026-10-16）

- `UserPromptSubmit` フックは、skill／カスタムスラッシュコマンドの展開より前に走る。ブロックすれば、埋め込みシェルコマンドも止まる。skill 自身の frontmatter の `UserPromptSubmit` フックは、呼び出したプロンプトの次から走る（2.1.299）（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。
- `PreToolUse`／`PermissionRequest` フックの `updatedInput` は Claude 自身の入力と同様に検証される。未知のキーは捨て、ツールが拒む入力は呼び出しを拒否（2.1.300）（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。
- Windows で、シェル未設定の `PreToolUse`／`PermissionRequest` フックが Git for Windows 無しのとき、通さず（fail open）でなく拒否する（2.1.299）。プラグインフックでブロックできる操作は、フックに渡せない・答えが返らないときに拒否する（2.1.299）（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。
- Cowork クラウドの auto mode では、`PermissionRequest` フックはシェルコマンドとサブエージェントを承認できない。allow 内の `setMode` は無視される（2.1.299、2.1.300）（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。
- plan mode が、`PreToolUse` フックや mod の `tool.check` が allow した書き込みを実行してしまう問題を修正（2.1.299）（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）。

- コマンドフックと HTTP フックの `onFailure: "block"`: 起動しない、タイムアウトした、想定外の終了コードだった、のどれかのときに操作を止める（2.1.295）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- フックの出力にある `<system-reminder>` タグは、Claude に渡す前にエスケープされる（2.1.292）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- 長い出力は切り詰めてログに残される（2.1.290）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- `--debug` で、フックのコマンド、プラグイン、結果、かかった時間が記録される（2.1.296）（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）。
- cloud session では、SessionStart フックで `npm install` などを動かす。`CLAUDE_CODE_REMOTE` でクラウドかどうかを判定する（[[sources/claude-dev/2026-10-06-claude-code-in-the-cloud]]）。
- セキュリティ上の注意（公開時点の記述）: プロジェクトの `.claude/settings.json` に書かれたフックは、かつて信頼ダイアログの前に実行され得た。修正は、プロジェクト内設定の解析・実行を信頼の承諾後に遅らせること。現行の挙動は docs で未確認（[[sources/engineering/2026-05-25-how-we-contain-claude]]）。→ [[concepts/sandboxing]]

## 変更履歴

- 2026-10-14〜10-15 — 2.1.299〜2.1.300: `UserPromptSubmit` の実行順、`updatedInput` の検証、Windows での fail open の修正など（[[sources/gh-changelog/2026-10-16-v2-1-299-to-2-1-301]]）
- 2026-10-10 — 2.1.296: managed settings の `PreToolUse` フックが `"continue": false` で拒否してもターンが終わらなかった問題を修正（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-10-09 — 2.1.295: `onFailure: "block"` を追加（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-10-07 — 2.1.292: **Security**: PreToolUse フックの承認が、UNC パスからの読み込みで許可の確認を飛ばしていた問題を修正（[[sources/gh-changelog/2026-10-10-v2-1-290-to-2-1-296]]）
- 2026-05-25 — 2025年中頃〜2026年1月に報告された3件の脆弱性（信頼ダイアログ前にフックが実行される等）が修正済みと説明された。修正バージョンは記事に無い（[[sources/engineering/2026-05-25-how-we-contain-claude]]）

## 未解決・矛盾

- （なし）
