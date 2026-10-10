---
type: source
source_id: engineering
title: Quantifying infrastructure noise in agentic coding evals
url: https://www.anthropic.com/engineering/infrastructure-noise
published: 2026-02-05
retrieved: 2026-10-10
version:
tier: primary
review: pending
recheck: none
fingerprint: sha256:b99eb63c3a6720f2727a864b7f5e7cf29839bfccf37c4115dd5c2e85dd3d5192
archive_url:
---

# Quantifying infrastructure noise in agentic coding evals

## 要点

- SWE-bench や Terminal-Bench のようなエージェント型コーディング評価では、実行環境（CPU・RAM などの割り当てと強制の仕方）が結果に影響する。インフラ設定だけで、上位モデル間のリーダーボード差を超える差が出うる。
- Terminal-Bench 2.0 を Google Kubernetes Engine で動かすと公式リーダーボードと点数が合わなかった。原因は、タスクごとの資源指定を「保証量」と「強制終了の上限」の両方に同じ値で使っていたこと。一時的なスパイクで OOM kill が起き、インフラ起因のエラーが最大6%のタスクで出た。
- 資源の余裕を 1x（厳格）から無制限まで6段階に変えて比較した。3x まではインフラエラーが減るだけでスコアはノイズの範囲。3x を超えると、重い依存関係の導入などエージェントが新しい手段を取れるようになり、評価が測るものそのものが変わる。
- SWE-bench でも同方向の効果があったが、大きさは小さい。時間帯による合格率の変動も経験的に観察されている（正式な定量化はなし）。
- 推奨: 保証量と上限をタスクごとに別々に指定・報告する。リーダーボードの差が3ポイント未満なら、評価設定が文書化され揃うまで懐疑的に見る。

## 具体的な値

- 公開時点（2026-02）の値。使ったモデルは「Anthropic の Claude モデル」とだけ書かれ、具体名は記事に無い。
- Terminal-Bench 2.0 で、資源が最も多い設定と最も少ない設定の差は 6 ポイント（p < 0.01）。
- インフラエラー率: 厳格（1x）5.8% から無制限 0.5% まで単調に低下。1x から 3x で 5.8% → 2.1%（p < 0.001）。
- 1x〜3x のスコア変動はノイズの範囲（p=0.40）。3x〜無制限でインフラエラーはさらに 1.6 ポイント減、スコアは約 4 ポイント上昇。1x に対する総上昇は +6 ポイント（p < 0.01）。
- 資源で成功率が大きく伸びたタスクの例: `rstan-to-pystan`、`compile-compcert`。`bn-fit-modify` は、重いデータサイエンス系ライブラリを入れる戦略だと厳しい制限下でインストール中に OOM になり、標準ライブラリだけで実装する軽い戦略なら通る。
- SWE-bench の追加実験: RAM を基準の最大 5x まで変更、227 問 × 各10サンプル。5x は 1x より 1.54 ポイント高い。
- 他モデルへの一般化: 複数の Anthropic モデルで方向は同じで大きさは異なる。Claude 以外も同傾向に見えるが厳密には未検証。
- 推奨の目安: Terminal-Bench 2.0 では、タスク指定の 3x を上限にするとインフラエラーが約3分の2減り、スコア上昇はノイズ内に収まる。倍率はベンチマークごとに異なるため報告する。
- 二項分布の素朴な信頼区間は 1〜2 ポイント。中程度の資源設定間のばらつきは 2 ポイント弱、両極端では 6 ポイント。
- 他の変動要因（例示）: クラスタの健全性、ハードウェア仕様、並行度、egress 帯域、API レイテンシ（時間帯）。公開用の評価は複数回・複数日に実行して平均化するとよい。

## 関連ページ

- [[concepts/agent-evals]]
- [[sources/engineering/2026-01-09-demystifying-evals-for-ai-agents]]

## 取り込みメモ

- 記事ページ本体の HTML を curl で取得し、fingerprint を付けた。本文は HTML から抽出した。ページ内に指示文は無かった。
- 記事は Claude Code の機能を扱わない。評価基盤の話であり、モデル名の記載が無いため、現行モデルとの比較はできない。
