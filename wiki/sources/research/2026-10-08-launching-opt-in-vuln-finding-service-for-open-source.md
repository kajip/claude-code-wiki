---
type: source
source_id: research
title: Launching an opt-in vulnerability-finding service for open-source software
url: https://www.anthropic.com/research/launching-opt-in-vuln-finding-service-for-open-source
published: 2026-10-08
retrieved: 2026-10-10
version:
tier: primary
review: pending
recheck: weekly
fingerprint: 6ad2da6817cc0a9dd6f9f799f40449c7d674c7418c2b0cf5d3598d3feaeaff55
archive_url:
---

# Launching an opt-in vulnerability-finding service for open-source software

Frontier Red Team の記事（2026-10-08）。

## 要点

- Anthropic が OSS Scanner を開始した。オープンソースのプロジェクトが任意で参加し、最も強いモデルによる定期的なセキュリティスキャンを無償で受けられる。
- 出力はモデルが生成したもので、人のレビューやトリアージを経ない。誤り・無効な報告が混じりうると明記している。高速に受け取れる任意の fast-track として位置づけられ、人が検証した報告を送る既存の CVD（協調的脆弱性開示）は続ける。
- 背景: 過去6か月で候補の脆弱性を 29,000 件超見つけたが、人が確認・トリアージできたのは約 6,000 件で、人手が律速になっている。
- 提供は段階的に見える。数週間、数十のプロジェクトで検証したあと「より多くのプロジェクトに提供する」段階に入った。参加は GitHub リポジトリへの PR による申し込みで、案件ごとに判断される。
- Claude Security（企業向けの一般提供のコードスキャン・パッチ製品）とは役割が別。Claude for OSS は Claude Max 20x を無償で提供する別の取り組みとして紹介されている。

## 具体的な値

- 名称: OSS Scanner（opt-in の脆弱性スキャナ）。着想は Google の OSS-Fuzz。
- 費用: 参加プロジェクトには "at no cost"（無償）。
- 使うモデル: "our strongest models (including Claude Mythos)"。
- 提供の範囲・対象: OSS プロジェクト。適格性は OSS-Fuzz と似た基準で、"critical impact on infrastructure and user security" を持つこと。個別に判断する。
- 申し込み方法: 適格なプロジェクトの core maintainers が、記事内でリンクされた GitHub リポジトリに、標準のプロジェクトテンプレートに沿った PR を出す。追加の案内は extended FAQ にある（リポジトリ名の URL は本文テキストからは取得していない）。
- 各報告の内容: 自己完結した reproducer、脆弱性の説明（可能なら混入時期の bisection 付き）、候補パッチ（あれば）。
- 検証: 専門のペネトレーションテスターが、48 プロジェクトの critical／high の 97 件を確認。85 件（88%）が CVD の基準を満たした。残り 12 件のうち 11 件は実在するが既知の問題かスキャン内の重複で、false positive は 1 件。
- 検証期間の成果: 数十プロジェクトで数百件の報告。複数の脆弱性を連鎖させて unauthenticated remote code execution にできた例がある。
- 規模: 候補 29,000 件超、確認済み約 6,000 件、メンテナの依頼で未検証のまま直接送った報告は約 5,000 件近く。CyberGym で LLM の発見率は昨年初めの 20% 未満から今年は 85% 超。
- 利用者の声: wolfSSL は受け取った 74 件のうち 2 件を除いて有効で、5 件が CVE になった。PostgreSQL、OpenSSL Corporation、HotCRP、curl（直近数年で最悪級の脆弱性を含む）も肯定的。ただし重大度が過大、またはプロジェクトの脅威モデルを誤解した、との指摘もある。
- Claude Security: "our general-access code scanning and patching product"、企業の防御を支援。OSS Scanner は OSS 向けに監査を無償で提供する、と対比している。
- Claude for OSS: "provides free Claude Max 20x subscriptions to help remediate vulnerabilities and improve OSS projects."
- Cyber Verification Program: 適格なセキュリティ専門家向けに、高度なサイバー能力と制限的な classifier の緩和を提供する、と末尾で案内（"our new Cyber Verification Program"）。

## 関連ページ

- [[concepts/oss-scanner]]
- [[concepts/cyber-safeguards]]
- [[sources/anthropic-news/2026-10-08-introducing-the-anthropic-cyber-mission]]
- [[sources/research/2026-09-29-glm-5-3-and-the-spread-of-advanced-cyber-capabilities]]

## 取り込みメモ

- 記事 HTML を curl で取得し本文を抽出した（fingerprint は HTML 全体の sha256）。
- 提供の段階は「beta」などの明示ではなく、「検証後に拡大中」「案件ごとの判断」という記述から判断して `recheck: weekly` とした（推測）。
- 申し込み先 GitHub リポジトリと extended FAQ の URL は、テキスト抽出では得られなかった。
- 関連コンテンツ欄に別の記事 3 件（unintended model actions、sky map、Claude-shaped science）があるが、本件には使っていない。
- Claude Security の提供範囲・価格はこの記事に記載が無い。pricing／docs の要約は確認していない。
