---
type: source
source_id: engineering
title: Building a C compiler with a team of parallel Claudes
url: https://www.anthropic.com/engineering/building-c-compiler
published: 2026-02-05
retrieved: 2026-10-10
version:
tier: primary
review: pending
recheck: none
fingerprint: sha256:44719d575dadb0fcc14bc4f1c8ed3d47154e5221e8ba8c63bb4ac5cedc5e3ebc
archive_url:
---

# Building a C compiler with a team of parallel Claudes

## 要点

- 著者は Safeguards チームの Nicholas Carlini。複数の Claude インスタンスが、人の介在なしに共有コードベースで並列に動く方式を「agent teams」と呼び、16 エージェントに Rust 製の C コンパイラを一から書かせた（公開時点の実験）。
- 結果は、約 2,000 回の Claude Code セッション、API 費用は約 $20,000、約 100,000 行のコンパイラ。Linux 6.9 を x86、ARM、RISC-V でビルドできた。
- ハーネスは単純なループ（タスクが終われば次を取る）。並列化は、各エージェントが Docker コンテナで動き、git の bare リポジトリを共有し、`current_tasks/` にテキストファイルを置いてタスクをロックする方式。オーケストレーション用のエージェントは使っていない。
- 学びの中心は環境設計。ほぼ完全なテスト、Claude 向けに書いた出力（コンテキストを汚さない、時間感覚の欠如への対処）、並列化しやすい作業の分け方（GCC をオラクルにする）、役割の分担。
- 限界も明記されている。16 ビット x86 のコード生成や、アセンブラとリンカは未完成、生成コードの効率は GCC の最適化なしより低い。著者は完全自律開発のリスクにも触れ、検証されていないソフトウェアの出荷に懸念を示している。

## 具体的な値

- 構成: 16 エージェント、約 2 週間、約 2,000 セッション、入力 2 billion トークン、出力 140 million トークン、費用は $20,000 弱（Opus 4.6、公開時点）。
- 成果: 約 100,000 行、Rust 標準ライブラリのみに依存。クリーンルーム（開発中にインターネットなし）。Linux 6.9（x86、ARM、RISC-V）、QEMU、FFmpeg、SQLite、postgres、redis をコンパイル。GCC torture test suite を含む多くのテストスイートで 99%。Doom もコンパイルして実行できた。
- モデルの推移（著者の評価）: 以前の Opus 4 系は機能するコンパイラをほとんど作れず、Opus 4.5 は大きなテストスイートに通るが実プロジェクトは不可、Opus 4.6 で Linux をビルド可能。
- ループの例（原文のスクリプト）: `claude --dangerously-skip-permissions -p "$(cat AGENT_PROMPT.md)" --model claude-opus-X-Y`。コンテナ内で実行するよう注意書きがある。ログは `agent_logs/agent_${COMMIT}.log`。
- 同期: bare リポジトリを `/upstream` にマウントし、各エージェントは `/workspace` にクローン。`current_tasks/parse_if_statement.txt` のようなファイルでロック。マージ衝突は頻発するが Claude が解消する。
- テスト出力の工夫: 出力は数行に抑えて詳細はファイルへ。エラーは `ERROR` と理由を同じ行に書き grep できるようにする。集計は事前計算。`--fast` オプションで 1% または 10% のランダムサンプルを実行（エージェントごとに決定的、VM 間ではランダム）。
- Linux カーネルでの詰まり: 全エージェントが同じバグに当たり互いの変更を上書きした。対策は GCC を既知の正しいコンパイラとして使い、ファイルの一部だけを Claude のコンパイラで処理する方式。のちに delta debugging で、組み合わせでのみ失敗するファイル対を探した。
- 役割分担の例: 重複コードの統合、コンパイラ自体の性能、生成コードの効率、Rust 開発者の観点での設計批評、ドキュメント。
- 限界: 16 ビット x86 は 66/67 オペコードプレフィックスで出力できるが 60kb 超で、Linux の 32k 制限を超えるため GCC を呼び出す。アセンブラとリンカは自前だが不安定で、デモ動画は GCC のものを使用。新機能や修正が既存機能を壊しがち。

## 関連ページ

- [[concepts/long-running-agent-harness]]
- [[concepts/subagents]]
- [[concepts/agent-evals]]

## 取り込みメモ

- 取得は curl（生 HTML）。title と canonical URL が対象と一致することを確認した。
- 記事の `Copy` などの表示要素は取り除いて読んだ。コード、動画、図は未確認（ソースコードの公開先 URL は本文のテキストから取れなかった）。
- ページに指示文は無かった。
- モデル名（Opus 4.6 など）と数値はすべて 2026-02-05 時点。現行モデルでの再現は確認していない。
