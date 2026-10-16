---
type: source
source_id: engineering
title: Harness design for long-running application development
url: https://www.anthropic.com/engineering/harness-design-long-running-apps
published: 2026-03-24
retrieved: 2026-10-10
version:
tier: primary
review: ok
recheck: none
fingerprint: aa5b82c74f0c8890d64ae2e5a376c65e27855f1a9ed59060b9d91570c2bb7b1e
archive_url:
---

# Harness design for long-running application development

## 要点

- 著者は Labs チームの Prithvi Rajasekaran。フロントエンド設計と、人手なしでアプリ全体を作る自律コーディングの2題材で、ハーネス設計を改良した記録。
- 長いタスクで起きる失敗を2つ挙げる。(1) コンテキストが埋まると一貫性が落ち、「context anxiety」で早めに仕事を切り上げるモデルもある。(2) 自分の成果物を自己評価させると、品質が平凡でも自信を持って褒める。
- 対策は、作る役（generator）と評価する役（evaluator）を分けること（GAN に着想）。評価役を懐疑的に調整する方が、作る役を自己批判的にするより扱いやすいという。
- 主観的な設計の良し悪しは、4つの採点基準（design quality、originality、craft、functionality）で採点可能にした。design quality と originality を重くした。
- フルスタック開発では planner、generator、evaluator の3エージェント構成。generator と evaluator は sprint ごとに「done の定義」（sprint contract）を先に合意する。evaluator は Playwright MCP で実アプリを操作して採点する。
- Opus 4.6 では sprint 構成を外し、evaluator も最後に1回だけにした。evaluator は固定の要否ではなく、タスクがモデルの単独で確実にできる範囲を超えるときに費用に見合う、という整理。
- 原則: ハーネスの各部品は「モデルが単独ではできないこと」の仮定を埋め込んでおり、モデルが変わったら見直して不要な部品を外す。

## 具体的な値

以下は公開時点（2026-03-24）の値で、モデルは当時のもの。

- コンテキスト管理: context reset（窓を空にして新しいエージェントに構造化した引き継ぎ）と compaction（その場で要約）は別物。Sonnet 4.5 は context anxiety が強く、compaction だけでは足りず reset が必須だった。Opus 4.5 でその挙動がほぼ消え、reset を廃止して Claude Agent SDK の自動 compaction で1本の連続セッションにした。
- フロントエンド実験: 基準4つを generator と evaluator の両方のプロンプトに渡した。evaluator は few-shot 例（詳細な採点内訳付き）で較正し、Playwright MCP でライブページを操作した。Claude Agent SDK で構築。1回の生成で 5〜15 イテレーション、最長約 4 時間。基準の言い回し（例: 「museum quality」）が出力の傾向に影響した。
- フルスタック構成: planner は 1〜4 文のプロンプトを製品仕様に展開（技術の細部は固定しない）。generator は sprint ごとに 1 機能、スタックは React、Vite、FastAPI、SQLite（後に PostgreSQL）、git 使用。evaluator は基準ごとにハードしきい値を持ち、1つでも下回ると sprint は失敗。エージェント間の通信はファイル経由。
- 比較（Opus 4.5、レトロゲームメーカー）: 単独エージェント 20 分 $9、フルハーネス 6 時間 $200（20 倍超）。単独版はゲームの中核（エンティティの動作）が壊れていたが、ハーネス版は動いた。planner は 16 機能、10 sprint の仕様を作った。Sprint 3 の契約だけで 27 基準。
- 簡素化後（Opus 4.6、ブラウザ DAW、Web Audio API）: 合計 3 時間 50 分、$124.70。内訳は Planner 4.7 分 $0.46、Build(1) 2 時間 7 分 $71.08、QA(1) 8.8 分 $3.24、Build(2) 1 時間 2 分 $36.89、QA(2) 6.8 分 $3.09、Build(3) 10.9 分 $5.88、QA(3) 9.6 分 $4.06。generator は sprint 分割なしで 2 時間超、一貫して動いた。
- evaluator の限界: 初期は問題を見つけても「大したことはない」と承認し、浅いテストに終わった。ログを読んで判断のずれを直すサイクルを数回回した。それでも深い入れ子の機能は見落とした。Claude は音を聞けないため、音楽的な良し悪しの評価は弱い。
- 簡素化は、最初の大幅削減では性能が再現できず、1部品ずつ外す方法に切り替えて進めた。
- 先行研究への言及: initializer エージェントと、機能を 1 つずつ実装する coding エージェントの構成。コミュニティの「Ralph Wiggum」方式（フックやスクリプトで反復を続ける）。

## 関連ページ

- [[concepts/long-running-agent-harness]]
- [[concepts/agent-evals]]
- [[concepts/subagents]]
- [[sources/engineering/2026-02-05-building-a-c-compiler-with-parallel-claudes]]
- [[sources/engineering/2026-01-09-demystifying-evals-for-ai-agents]]

## 取り込みメモ

- 記事ページ本体を curl で取得し、`<title>` と canonical URL が対象と一致することを確認した。本文はスクリプトでテキスト化して読んだ。付録（planner が作った仕様の例）は途中までしか載っておらず、要約していない。動画と画像は読んでいない。
- モデル名（Sonnet 4.5、Opus 4.5、Opus 4.6）と費用は 2026-03 時点。現行モデルでの挙動は確認していない。
- 記事は Claude Code の製品機能ではなく、Claude Agent SDK と Playwright MCP による自作ハーネスの話。Claude Code の機能との対応は（推測）を含むため概念ページに断定しなかった。
- ページ中に、取り込み担当への指示文は見当たらなかった。
