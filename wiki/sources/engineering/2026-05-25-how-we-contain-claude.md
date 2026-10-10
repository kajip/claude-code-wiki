---
type: source
source_id: engineering
title: How we contain Claude across products
url: https://www.anthropic.com/engineering/how-we-contain-claude
published: 2026-05-25
retrieved: 2026-10-10
version:
tier: primary
review: pending
recheck: none
fingerprint: 2060610df611652e8da07359112dd7ee4e16302a40c516471101ca41700c47ef
archive_url:
---

# How we contain Claude across products

## 要点

- エージェントの危険は「失敗の起きやすさ」と「被害の最大幅（blast radius）」の積で、前者はモデルと safeguards で下がるが後者は権限が広がるほど増える。本記事はその上限を抑える方法を扱う。
- 抑え方は2つ。人が監督する（承認ダイアログ）か、できることを制限する（封じ込め: サンドボックス、VM、egress 制御）。承認は疲れで形骸化するので、環境側の封じ込めを先に設計し、モデル側は補助とする。
- 3製品で隔離の型が違う。claude.ai は gVisor の使い捨てコンテナ、Claude Code は OS レベルのサンドボックス＋人の承認、Cowork はローカル VM。ユーザーが bash を判断できるかで隔離の強さを合わせる。
- 見落としたリスクの事例: 信頼ダイアログ前の設定読み込み、ユーザー自身が注入経路になる直接 prompt injection、許可ドメイン（api.anthropic.com）経由の流出、VM が EDR を遮ること。
- 自前で作った部品（カスタム proxy など）が最も弱く、hypervisor・seccomp・gVisor などの標準部品は持ちこたえた、と総括している。

## 具体的な値

以下は公開時点（2026-05-25）の値。
- ユーザーは権限プロンプトの約 93% を承認（テレメトリ）。
- OS レベルのサンドボックス（macOS は Seatbelt、Linux は bubblewrap）: 読み取り可、書き込みはワークスペース内、ネットワークは既定で拒否。権限プロンプトを 84% 削減。ランタイムは OSS 化。
- 経験者は新規ユーザーの約2倍の頻度で auto-approve し、実行中の割り込みも多い。
- auto mode: overeager な挙動の約 83% を実行前に捕捉。脚注: 無害なコマンドの約 0.4% をブロック、危険な行動の約 17% が通過。サンドボックス内の多層防御の一層であり代替ではない。
- Gray Swan Agent Red Teaming（prompt injection）: Claude Opus 4.7 の攻撃成功率は単発で約 0.1%、100回の適応的試行後で約 5〜6%。
- Claude Code のリファレンス devcontainer は、承認なしの無人実行のために用意されている。
- 信頼ダイアログ前の脆弱性: 2025年中頃〜2026年1月に報告された3件。`.claude/settings.json` のフックが「Do you trust this folder?」の前に実行され得た。修正は、プロジェクト内設定の解析・実行を信頼の承諾後に遅らせること。
- 2026年2月の社内 red-team: ユーザーに貼らせた悪意あるプロンプトで `~/.aws/credentials` を読み、エンコードして外部へ POST。25回中24回成功。有効な防御は egress 制御とファイルシステム境界だけ。
- claude.ai: gVisor コンテナ、サーバー側のみ、ファイルシステムは会話単位で使い捨て。
- Cowork（初版は full-VM mode）: Apple Virtualization framework（macOS）、HCS（Windows）。選んだワークスペースと `.claude` フォルダだけをマウント。認証情報はホストの keychain に置き、ゲストに入れない。後に agent loop を VM の外へ移し（host mode）、コード実行だけ VM 内に残した。ローカル MCP サーバーも VM の外へ移した。
- Cowork のマウントモード: read-only、read-write、read-write-no-delete。symlink の解決はパス検証より先に行う。管理者は MDM 設定の mount-path allowlist で制御できる。
- 許可ドメイン経由の流出: Cowork の egress allowlist が api.anthropic.com を通し、攻撃者のキーで Files API へアップロードされた（第三者の報告）。対策は VM 内の中間者 proxy で、VM 自身のセッショントークン付きのリクエストだけ通し、server-side fetch を可能にするヘッダーを遮断する。
- EDR が VM 内を見られない問題への現行の緩和策: pull 型の OTLP エクスポートで事後にイベントログを取得（ライブ監視ではない）。
- 今後の課題として挙げたもの: 永続メモリ汚染（CLAUDE.md、マウントしたワークスペース等）、マルチエージェントでの信頼の昇格、エージェントの ID。

## 関連ページ

- [[concepts/sandboxing]]
- [[concepts/auto-mode]]
- [[concepts/hooks]]
- [[concepts/cloud-sessions]]
- [[sources/engineering/2026-03-25-claude-code-auto-mode]]
- [[sources/engineering/2026-04-08-scaling-managed-agents]]

## 取り込みメモ

- 取得した HTML の title と canonical URL は対象と一致した。本文は HTML から抽出して読んだ。図は文字として取れていない（キャプションと比較表の文字列のみ）。
- 公開日 2026-05-25 は依頼で指定されたもの。ページ本文からは日付を確認していない。
- 約4か月前の記事。数値と製品の構成は公開時点のもので、現行の docs（サンドボックス、Cowork）はまだ取り込んでいないため未確認。
- 記事は Claude Mythos Preview を「2026年4月に出荷するには blast radius が高すぎると判断した」例として挙げている。この wiki の他の出典での扱いは未確認。
- ページ内に、読み手への指示文は見つからなかった。
