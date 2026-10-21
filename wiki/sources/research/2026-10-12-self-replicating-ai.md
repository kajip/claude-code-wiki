---
type: source
source_id: research
title: AI models may be capable of self-replicating without access to a datacenter
url: https://www.anthropic.com/research/self-replicating-ai
published: 2026-10-12
retrieved: 2026-10-21
version:
tier: primary
review: pending
recheck: none
fingerprint: 48e71fec9b59938c8b683495582edcd35c24841d03be8b9f0edbf3c768343368
archive_url:
---

# AI models may be capable of self-replicating without access to a datacenter

Frontier Red Team の記事（著者 William Zhou、Daniel Freeman。分野は Safety evaluations／Cybersecurity／Agents）。URL のスラッグは `self-replicating-ai` だが、ページの題は上記。fingerprint は記事ページの生 HTML の sha256。

## 要点

- 小さなモデルは、スマートオーブンや無名ブランドの Android TV ボックスのような商用 IoT 機器で自己複製できるようになるまで、あと数か月かもしれないという見立て。中央に止める場所が無く止めにくいが、複製は遅い（倍加に数日）。評価では、9B モデルが試した9種のハードウェアのうち8種で推論サーバーを立ち上げた。
- 30B 以下のモデルは複製の個々の手順の多くをすでにこなせるが、通しでつなぐとミスが出る。簡略化した評価では GLM-5.2 以上が通しの複製に成功。小型モデルが過去の改善ペースで伸びれば、2026年末までにこの水準に届くと見積もる。
- 焦点は、あまり測られてこなかった「侵入先での推論の立ち上げ」。複製を、標的探索・実行権の獲得・推論の立ち上げ・新ホストからの継続の4段階に分け、前2段（exploit）は先行研究に任せて簡略化した。
- 適応（ARA の A）も調べた。子の世代がメモを引き継ぐと推論立ち上げの成功率は上がった（45% → 61〜84%）。一方、強いモデルへの助言は小型モデルを助けなかった。
- 防御側の論点: ISP のフロー監視で検知しやすい、Mirai の事例では隔離と通知が有効、メーカーの既定パスワード規制。記事は、遅い複製は、より速く強い複製の前触れ（bellwether）になり得ると結ぶ。
- Claude Code や Anthropic 製品の仕様変更に関する記述はない（Claude は複製の対象ではなく、助言役として Opus 4.8 を試しただけ）。

## 具体的な値

- 実機デモ: Gemma4-26B-A4B を、約55ドルの無名 Android TV ボックス15台（各 4GB RAM、4bit 量子化、pipeline parallel）に分散し、0.39 tokens/s。32k コンテキストでの未最適化の平均は約0.3 tok/s。
- 目安: 4GB・4bit なら 9B モデルは4台以上、26B モデルは10台以上。
- 推論立ち上げ（Llama3.1-8B を各ハードで提供）: Qwen3.5-9B は Jetson Nano から Mac、RTX 4090 まで可能。9種中8種（9B）。使った harness は Pi coding agent 上の Memento（失敗した方針に固執するのを避けるため、一定時間ごとに新しいインスタンスがメモと作業場所を引き継ぐ。1.5時間／回、合計6時間）。
- 8ノードの GCP VPC（redroid = Android 15 エミュレータ、認証なしの ADB ポート）での通し複製: オープンウェイトのうち GLM-5.2 のみが成功（5試行中4回で8/8、1回で7/8）。exploit を自明にしているので上限値。複製ツリーの追加実験は17ノード（8＋8＋中継1）。3B モデルでも約半数に到達。
- 小型モデルの伸び: 30B 以下のオープンウェイトの最良モデルで +13.7 ECI／年（R² 0.95）。GLM-5.2 を水準とすると2026年末。
- 速度: 32k ウィンドウ1つに Gemma4-26B-A4B は 27.3〜31.8時間、Qwen3.5-9B は 10.9時間。推論立ち上げ全体は約2.6〜4.7ウィンドウで、前者 71〜150時間、後者 28〜51時間。
- 規模の試算: Kimwolf（200万台超、主に Android TV）相当なら 15台×1組で約13.3万レプリカ、合計約 80k tokens/s。H100 の約40台分（H100 は 1.95k tok/s と仮定）。
- 適応: Qwen3.5-9B を6世代、メモを継承。成功率は第1世代 45% から後の世代で 61〜84%（20系統）。
- 助言: Qwen3.5-9B に Opus 4.8 を tool call または自動の助言で与えても有意な改善なし。助言用に強化学習で訓練しても同様。
- エッジアクセラレータ（Appendix D）: Jetson AGX Orin 64GB が Qwen3-30B-A3B を 76.7 tok/s、AGX Thor が 226 tok/s。NVIDIA 系 IoT は約90製品系列・約950万台、H100 換算で 9,000〜35,000（到達可能な分はその1桁以上少ないと推定）。
- 防御: Mirai 対応では、ISP の隔離と通知で14日以内に感染の92%を解消（通知なしは74%）。英国市場では既定の IoT パスワードが不適合。
- スピアフィッシング（Appendix E）: 小型モデルは人間基準に補正すると「very poor」〜「poor」。ソーシャルエンジニアリングは大型モデルの役割になりそうだと見る。
- 脅威モデル4種: 小型モデルのホスト侵害型（本稿の対象）、大型・データセンター型（フロンティア型とオープンウェイト型）、API 認証情報を盗む型。実際は混成の群れが最悪のケースとする。

## 関連ページ

- [[concepts/autonomous-replication]]
- [[concepts/cyber-safeguards]]
- [[concepts/unintended-model-actions]]
- [[sources/research/2026-09-29-glm-5-3-and-the-spread-of-advanced-cyber-capabilities]]

## 取り込みメモ

- 取得は curl（HTTP 200）。生 HTML を本文テキストに変換して読んだ。図表（モデル×ハードウェアの表、グラフ）は画像や動的要素で、数値の多くは読めていない。表の個別値は未取り込み。
- 依頼文の題「Self-replicating AI」はスラッグ由来で、実際の題は上記（確認）。
- 記事は、評価に使った具体的なチップ名は「リスクや脆弱性の源ではない」と注記している。
- 「Opus 4.8」は記事の表記のまま。wiki の他ページに Opus 4.8 の独立ページは無く、cyber-safeguards に fallback 先としての言及がある。
- ページ内に、読み手への指示文は見つからなかった。
