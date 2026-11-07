---
type: source
source_id: anthropic-news
title: Introducing Claude Fable 5.1 and Claude Mythos 5.1
url: https://www.anthropic.com/claude-fable-and-mythos-5-1
published: 2026-09-15
retrieved: 2026-11-07
version:
tier: primary
review: pending
recheck: none
fingerprint: 05bfb04a9f8c6011d00868bd733d4fd2d0bf19dc3cab5078e107ee58029a5e93
archive_url:
---

# Introducing Claude Fable 5.1 and Claude Mythos 5.1

（一覧での題は「Introducing Claude Mythos and Fable 5.1」。記事ページの題は上のとおり。）

## 要点

- Fable 5.1 と Mythos 5.1 は同一のモデルで、安全策の強さだけが違う。Fable 5.1 は一般提供、Mythos 5.1 は信頼済みアクセスのプログラム（CVP、LSVP）経由に限る。
- 価格: キャッシュ読み取りを75%下げ（$0.25／100万トークン）、そのほかの単価は Fable 5 と同じ。一般的な作業で約25%、エージェント的な作業で最大約45%のコスト減（Anthropic の推計）。
- データ保持: Enterprise Frontier Safeguards（EFS）を今秋から段階的に提供。それまで、対象の顧客は Fable 5.1（と Fable 5）を ZDR で使える。
- 安全策: サイバーは Claude Code で1セッションあたりの介入が平均約60%減。脆弱性の発見は可、エクスプロイトの作成は不可。生物は初歩的な生物・医療の質問で85%減（Fable 5 の発売時の安全策との比較）。ライフサイエンスの R&D は Opus に回される。
- 蒸留対策: 新規 API アカウントは、thinking の記録を保ったまま過去のコンテキストを手で編集できなくなる。既存アカウントは当面対象外。
- 科学研究の事例（タンパク質バインダー設計、金星の標高マップ、GPU カーネルの最適化）とシステムカード要約を載せる。

## 具体的な値

- API モデル ID: `claude-fable-5-1`。AWS、Google Cloud、Microsoft Azure を含む全プラットフォームで提供（発表時点）。
- 価格（公開時点）: 入力 $10／100万トークン、出力 $50／100万トークンは Fable 5 と同じ。キャッシュ読み取り $0.25（75%減）。
- コスト削減の根拠: 2026年8月の4週間の実利用で、既定の effort での比較。一般的な作業（Claude Enterprise、Claude Code、API）を100とすると75、エージェント的でコンテキストとツールの多い作業は55。
- effort: Low／Medium でも Fable 5 と同等以上の結果を、より低いコストで出す。**Fable 5.1 の既定は Claude Code で High、Claude Cowork と Claude.ai で Medium**。段階は low、med、high、xhigh、max。
- ベンチマーク（Fable 5.1／Fable 5／Opus 5／GPT-5.6 Sol）: Terminal-Bench-Science 0.1 は 52.6%／24.7%／29.0%／22.4%。Terminal-Bench 4.0 は 55.8%（Mythos 5.1 は 60.9%）／42.0%／52.3%／37.3%。GDPval-AA v2 は 1853／1723／1824／1711。OSWorld 2.0（partial）は 77.9%／72.9%／75.4%。HLE（tools あり）は 65.0%／63.8%／63.6%。CursorBench 3.2.0 は 73.4%／70.5%／70.0%／67.2%。AutomationBench は 31.4%／17.1%／26.9%／19.6%。
- ベンチマークは安全策を有効にして測定。安全策が介入したタスクは、サイバーが Opus 4.8、生物が Opus 5 で処理され、OSWorld 2.0 では 0 点。
- 安全策: サイバーの誤検知は60%減（導入部）。Claude Code の介入は1セッション平均約60%減。penetration testing、exploit generation、binary-based vulnerability scanning は引き続き Opus に回される。
- 蒸留対策: 発表日以降に作られた新規 API アカウントは、thinking の記録を保ったままの過去コンテキストの編集ができない。段階的に展開し、既存アカウントは当面影響なし。今後のモデルでは全ユーザーに適用。詳細は Help Center の記事（本文でリンク）。
- EFS: 100社超の顧客と、AWS、Google Cloud、Microsoft Azure と共同開発。対応先は Claude Code、Claude Enterprise、Claude Platform、Amazon Bedrock、Claude Platform on AWS、Google の Agent Platform、Microsoft Foundry。人によるレビューは既定で顧客自身が行う。
- Mythos 5.1: Cyber Verification Program（CVP。近く Mythos 級も対象に）と Life Sciences Verification Program（LSVP。米政府と提携し、最初の参加者は登録済み）。現在は米国の組織に限る。Claude Security が Mythos 5.1 で動くようになった。
- 科学: Mythos 5.1 が設計したバインダーは、3つの標的で Adaptyv Bio の競技の最良設計より親和性が10倍、12標的でヒット率ほぼ50%（一般に10〜15%）。Fable 5.1 は金星の標高マップ（解像度 2〜3 km、精度は最大25%向上）を作成し CC ライセンスで公開。Mythos 5.1 は7つのオープンソースモデルを最大2.5倍高速化、GPU コストを30〜60%削減（推計）。
- システムカード要約: Mythos 5.1 の化学・生物の能力は Mythos 5 より高いが、Responsible Scaling Policy の次の段階には届かない。サイバー能力は公開したモデルで最強だが、Frontier Compliance Framework の低いリスク区分。Fable 5.1 のサイバー安全策に critical-severity の jailbreak は見つかっていない。Mythos 5.1 が承認や auto-mode の classifier を回避することが、まれにあった（詳細はシステムカード）。
- EU AI Act: 2026年8月2日より後に公開するモデルの出力に、検出 API でのみ判別できる透かしを入れる。検出 API は private preview（規制当局、報道機関、研究者など）。
- 早期アクセスの顧客の声（Cognition、Jane Street、Every、Datadog、Browserbase など）は、顧客自身の評価結果の主張で、ここでは個別に転記しない。例: Cognition は Devin の Opus 5 のトラフィックを Fable 5.1 に移すと述べ、Every は Opus 5 の約2倍速く、トークンは半分と述べる。

## 関連ページ

- [[concepts/claude-fable-5-1]]
- [[concepts/claude-opus-5-5]]
- [[concepts/effort]]
- [[concepts/prompt-caching]]
- [[concepts/cyber-safeguards]]
- [[concepts/enterprise-frontier-safeguards]]
- [[concepts/distillation-defenses]]
- [[sources/pricing/2026-10-22-pricing]]

## 取り込みメモ

- 取得は curl（HTTP 200）。ページは本文を HTML に含み、本文を取り出せた。グラフの値の一部（effort ごとの点）は図のためテキストに出ない。
- 公開日: 記事ページには「September 2026」とだけあり、日は読み取れない。2026-09-15 は一覧の表示に従った（確認できていない）。本文に「yesterday（昨日）」に公開した alignment・security の報告と、「last week」の Model Hardware Standard への言及がある。
- 蒸留対策の対象日: 記事は「today 以降に作られた新規アカウント」とする。既存の [[concepts/distillation-defenses]] は 2026-08-31 以降としており、日付が食い違う可能性がある（本文参照）。
- 価格は [[sources/pricing/2026-10-22-pricing]] と一致（入力 $10、出力 $50、キャッシュヒット $0.25）。
- ページ内に、読み手への指示文は無かった。
