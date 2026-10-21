---
type: source
source_id: anthropic-news
title: Strengthening our defenses against distillation attacks
url: https://www.anthropic.com/news/distillation-defenses
published: 2026-10-12
retrieved: 2026-10-21
version:
tier: primary
review: pending
recheck: none
fingerprint: 28c77ce92863b485816c9dc82b1ccaea9bf6eda063e09a3d74db6189c569d178
archive_url:
---

# Strengthening our defenses against distillation attacks

## 要点

- 蒸留攻撃（不正なアカウント網で Claude の能力を大量に抜き取り、別モデルに写す行為）への新しい対策で、蒸留者が集めたデータ量が約 90〜99% 減ったという初期の証拠がある。
- 蒸留者が最も欲しがるのは Claude の推論（thinking）の記録。対策は推論に近づけなくすることに集中している。最初の対策は推論の要約表示で、効果はあったが、能動的な抽出と、数十万の不正アカウントを持つプロキシ網で回避された。
- 新しい対策は3つ。(1) 推論の行き先の制御（preserved thinking、古いモデルから読めなくする、Sonnet 5.5 では推論記録を依頼した組織だけが読める）。(2) 2段の classifier による抽出の遮断。(3) 繰り返しの試行を難しくする（利用上限の厳格化、アカウント停止、遮断された依頼への課金再開）。
- トレードオフがある。preserved thinking により一部の開発者は連携の修正が必要になり、classifier は 0.1% 未満の正常な依頼を誤って遮断し、その分も課金される。
- 効果が続くかは未確定で、高度で粘り強い回避の試みはまだ見ていないと述べている。他のモデル開発者とプラットフォームにも対策を求めている。

## 具体的な値

- 効果: 蒸留者が抜き取った推論トークンは classifier 導入後、導入前の 1/10〜1/100 以下。日によっては測れないほど少ない。データ収集量の減少は約 90〜99%（初期の証拠）。
- 要約の効果（Opus 4.8 の記録で学習した事前学習済み Claude を SWE-bench Verified で評価）: 全文の記録 80.4%、要約のみ 71.8%。
- classifier: 2段階。bioweapons 向けの安全策とほぼ同程度の頑健さ、誤検知率 0.1% 未満。対象は Claude Sonnet 5.5、Claude Opus 5 と 5.5、Claude Fable 5 と 5.1。今後の同種のモデルにも使う予定。
- preserved thinking: 2026-08-31 以降に作られた新規 API アカウントは、Claude の過去のコンテキストを編集できない。Claude Fable 5.1 と Claude Opus 5.5 で導入。
- 推論の読み取り: 弱い対策の古いモデルから、これらのモデルの推論を読めないようにした。Claude Sonnet 5.5 では、推論記録を依頼した組織だけが読める。
- 課金: 2026-09-24 から、応答前に安全策で遮断された依頼への課金を再開。対象は誤検知率が 0.1% 未満の分野（蒸留を含む）。
- 新たに塞いだ手口の例: 以前の推論を別の言語に翻訳させる、回答とともにタグの中に書き出させる。
- アカウント停止: 蒸留に関連する数万のアカウントを停止。蒸留の開始から 2 時間未満で止めた例が多い。
- 攻撃の規模（過去の報告）: 2月の報告で1つの網が同時に 20,000 超の不正アカウントを管理。ある研究所が 12,000 件の異なる誘導リクエストを試した（9月の報告）。
- 事例: Zhipu は GLM-5.3 の開発で米国モデルのサイバー能力を蒸留。Claude Fable 5 を狙ったが、サイバー安全策で攻撃が劣化したため、古い Claude モデルと他社のモデルに切り替えた。CAISSI は GLM-5.3 を公開済みのオープンウェイトで最もサイバー能力が高いと評価。Moonshot の Kimi への依頼が Claude に秘密裏に転送されていた事例もある。

## 関連ページ

- [[concepts/distillation-defenses]]
- [[concepts/cyber-safeguards]]
- [[sources/research/2026-09-29-glm-5-3-and-the-spread-of-advanced-cyber-capabilities]]
- [[sources/anthropic-news/2026-09-22-introducing-claude-opus-5-5]]
- [[sources/anthropic-news/2026-09-28-introducing-claude-sonnet-5-5]]
- [[sources/platform-docs/2026-10-09-release-notes-2026-09-10-to-10-09]]

## 取り込みメモ

- 記事ページ本体を curl で取得（HTTP 200）。本文を抽出して要約した。記事内の図表は画像で、キャプションのみ確認した。
- ページ内に、読み手への指示文はなかった。
- Claude Code への影響（セッション中のアカウント切り替え、コンテキストの編集を伴う運用など）は記事に書かれていない。Sonnet 5.5 の発表記事（thinking は作ったアカウントに結び付く）との対応は推測にとどまる。
- 「Claude Fable」「Opus 4.8」などの名称は記事の表記のまま。
