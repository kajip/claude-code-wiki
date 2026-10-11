---
type: source
source_id: research
title: GLM-5.3 and the spread of advanced cyber capabilities
url: https://www.anthropic.com/research/glm-5-3-and-the-spread-of-advanced-cyber-capabilities
published: 2026-09-29
retrieved: 2026-10-10
version:
tier: primary
review: ok
recheck: none
fingerprint: ddc3519832f9f79d3d793065d0c66f0756deb62a23bf059310681979cb6c9e47
archive_url:
---

# GLM-5.3 and the spread of advanced cyber capabilities

Frontier Red Team の記事（Policy 分類）。fingerprint は記事ページの生 HTML の sha256。

## 要点

- Zhipu AI（Z.ai）のオープンウェイトモデル GLM-5.3 は、エンドツーエンドのエクスプロイトを自律的に作れる。意味のある安全策なしで公開された点が、他の同等モデルと違うと評価している。
- GLM-5.3 の安全策は単純な手法で回避できた（シミュレーション試験で 64%〜100%）。同じ手法は安全策付きの Claude モデルには通じなかった。
- Claude 側の理由として、(1) 欺瞞的なプロンプトは Claude の安全策が遮断した、(2) Anthropic API では thinking の prefill ができない、(3) 重みが公開されないので abliteration できない、の3点を挙げている。
- 防御側へのアクセス方針: 防御者は敵対者と同等以上のフロンティアモデルを使えるべきだとし、Claude のサイバー能力を、安全にできる範囲でできるだけ多くの防御者へ広げる作業を進めていると述べる。審査済みの防御者は trusted access programs 経由で、より高性能なモデル（記事中の表記は Claude Mythos 5.1）を使える。
- 政府に対し、GLM-5.3 の後継を含む高性能モデルの安全性試験の実施を求める。
- 能力面は NIST CAISI（2026-09-17 公開）の評価とおおむね一致するという。

## 具体的な値

- 背景: Claude Mythos Preview は5か月前に発表され、Project Glasswing 経由の限定公開で、信頼された防御者が重要ソフトウェアの脆弱性を 10,000 件超見つけた。
- CAISI の評価: GLM-5.3 は「the most cyber-capable open-weight model released to date」で、CAISI のサイバーベンチマーク集計で米国のフロンティアに約4か月遅れ。
- ExploitBench（Chrome の V8 の既知脆弱性）: GLM-5.3 は 410 回中 50 回、Claude Mythos Preview は 410 回中 56 回でエンドツーエンドのエクスプロイトに成功。
- 社内 Binary Exploitation ベンチマーク（OSS-Fuzz 由来、100 タスク）: 制御フロー奪取の成功率は GLM-5.3 が 4%、Mythos Preview が 6%。Claude Opus 4.6 と GLM-5.2 は 0。
- 人間専門家との試験: GLM-5.3 が1日（人の注意は1時間未満）でブラウザの JS エンジンの未知の脆弱性を複数見つけ、連鎖させて任意ファイル読み取りのエクスプロイトにした（メンテナへ報告済み）。GLM-5.3-Flash は CVE-2026-11645 などの N-day から、PAC を回避する ARM64 向けのエクスプロイト連鎖を人の注意20分＋モデルの作業8時間で作成。Zhipu の API 価格で $20.40。
- abliteration: GLM-5.3 で約 2,200 GPU 時間（約 $4,400。経験のあるチームなら約 600 時間、$1,200 と推定）、Flash は約 600 時間。拒否率は 90% 超から JailbreakBench 約 3%、HarmBench 約 2%、StrongREJECT 12%。GPQA-Diamond は同等、CyberGym は数ポイント低下。
- 回避手法と関与率（シミュレーション環境、各50サンプル）: 「自律レッドチームエージェント」という偽の設定 64%、thinking の prefill 92%、abliteration 100%。安全策付きの Claude モデルはすべて 0%。
- 比較対象に Kimi K3（Moonshot AI）と DeepSeek V4.1-Flash も図に含まれる。
- 関連して言及された取り組み: Patch the Planet、OSS Scanner（記事末の関連コンテンツ）。

## 関連ページ

- [[concepts/cyber-safeguards]]
- [[sources/anthropic-news/2026-10-06-expanding-the-cyber-verification-program]]
- [[sources/anthropic-news/2026-10-08-introducing-the-anthropic-cyber-mission]]

## 取り込みメモ

- 図（Figure 1〜6）は画像で、本文とキャプションのみ読んだ。
- 「Claude Mythos 5.1」「trusted access programs」が CVP の段階とどう対応するかは記事に書かれていない。wiki の既存ページとの対応は未確認（推測しない）。
- シミュレーションは実コードを実行しない疑似環境で、著者自身が実環境の再現として不完全と注記している。
- ページ内に指示文は無かった。
