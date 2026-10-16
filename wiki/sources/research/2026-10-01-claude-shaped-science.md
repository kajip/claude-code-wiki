---
type: source
source_id: research
title: Claude-shaped science
url: https://www.anthropic.com/research/claude-shaped-science
published: 2026-10-01
retrieved: 2026-10-10
version:
tier: primary
review: ok
recheck: none
fingerprint: sha256:bb4a32d7334b19c56fe15f90b90b9f88e62447d5d6e5f277a5c5f1cf6abe9e14
archive_url:
---

# Claude-shaped science

Science カテゴリ。Matthew Schwartz 教授（物理学）のゲスト寄稿。Schwartz は執筆時 Anthropic の visiting researcher だが、BootLoops は Anthropic のプロジェクトではなく Schwartz 個人が所有・保守する（記事の開示欄）。

## 要点

- 主張: 現在の LLM は「科学者」としては手取り足取りが必要で、人の望む科学と AI の得意なこととの間に「インピーダンス不整合」がある。そこで、AI の強みに合う「Claude-shaped」な問題を探す方針に切り替えた。
- 成果: 正確な計算のためのオープンソースのツールキット BootLoops（LLM 用のハーネス）を Claude と作った。素粒子の散乱振幅から始め、生態学、集団遺伝学、経済学、言語学など多分野へ広げた。専門家の助言で「技術的には正しいが退屈」な結果を、分野が関心を持つ問いへ向け直した。
- Claude Code の使い方（本ページの中心）: プロジェクトごとに別の Claude Code セッションを立て、全体を束ねる「マスターセッション」が他を調整し、計算資源を割り当て、結果を検証する。各セッションは計算をバックグラウンドのサブエージェントに任せ、途中結果は各フォルダの markdown に残す。
- サブエージェントを使う理由のひとつは、Fable 5 の分類器（classifier）によるブロック。サブエージェントに分けると、ブロックはセッション全体ではなく1つのエージェントだけを止める。
- 失敗の型: 長い計算を力任せに回す（新しいツールを作れば数分で済むのに）、compaction で文脈が失われる、完了を早まって宣言する、時間見積もりが当てにならない、結論が誤る。対策として、計画ファイルの定期的な整理、厳格な成功基準、自分でプロットを見る、がある。
- 見通し: 科学の進歩は実世界のデータを取って確かめるループで進み、AI はそのループの中に入るが、ループを一点に畳むわけではない。

## 具体的な値

- 規模: 3か月で 36 本の原稿、18 分野、共著者 19 人、候補の問題は約 400（技術詳細の節）。
- 実行環境: Claude Code のセッションを Google Cloud の仮想マシン上のターミナルで動かし、共著者の好みに応じて GitHub と Overleaf のリポジトリに接続。
- セッションの役割分担: プロジェクトごとのセッション／調整用のマスターセッション／執筆用／GitHub リポジトリ・ツールのマニュアル・BootLoops のサイト作成用／各ツールのコードの作成と検証用／敵対的な査読者として結果を再点検するセッション。
- 中間結果の置き場: 各フォルダの markdown ファイル。
- BootLoops への組み込み: 「protocol skills」などのプロトコルとツール（compaction 対策を含む）。同梱ソフトの例として ACTUARY、NUMKIN。サイトは bootloops.ai、コードは GitHub 上で公開。任意のモデルで使える。
- Claude Science のような商用ハーネスでも、これらの問題の一部は解決済みとされる。
- 使用モデル: 夏に Claude Fable 5 の公開後に試した（記事の表記は「Fable 5」）。前年12月の実験は Claude Opus 4.5（強い大学院生を20倍の速さで）。
- 科学の成果の数字（要点のみ）: 楕円積分 30 件（既知の再現 15、新規 15）。BCI（Barro Colorado Island）の樹種構成は中立理論の許す 4.5 倍速く変化。1000 Genomes の 5.7 billion 組の近接変異から遺伝子変換の証拠。経済学の AI data editor は 4,452 本の論文の複製パッケージ（約 30,000 ルーチン）を移植。言語学の AccStack は 6,072 言語。
- Schwartz の運用上のコツ: 「Done, with one asterisk」は未完了のことが多い／成功基準を厳格に（「証明されていない補題は不可」）／常にプロットを自分で見る／結論を納得するまで説明させる／センス（何が面白いか）は人が与える／成果が出たらさらに上を求める／力任せの計算（grind）に注意。

## 関連ページ

- [[concepts/cyber-safeguards]]（分類器によるブロック）
- [[concepts/subagents]]
- [[concepts/long-running-agent-harness]]
- [[sources/research/2026-10-09-investigating-unintended-model-actions]]（同じサイトの関連記事として記事末に掲載）

## 取り込みメモ

- 取得: curl で生 HTML を取得。title は「Claude-shaped science \ Anthropic」、canonical は対象 URL と一致を確認。本文を抽出して要約した。
- 科学の中身は要点のみ。Claude Code 以外の分野別成果（地球科学、ゲノミクス、宇宙論など）は省略した。
- 記事の「Fable 5」は wiki の他ページの「Fable 5.1」と別表記。同じモデルを指すかは記事から分からない（推測せず、別表記のまま記録）。
- ページ内に読み手への指示文は見当たらなかった。
- 記事は一人称の実践談で、仕様の保証ではない。サブエージェントと分類器の挙動は、docs で確認できていない（Claude Code docs の既存要約は未照合）。
