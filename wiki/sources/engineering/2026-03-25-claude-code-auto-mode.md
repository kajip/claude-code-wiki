---
type: source
source_id: engineering
title: "How we built Claude Code auto mode: a safer way to skip permissions"
url: https://www.anthropic.com/engineering/claude-code-auto-mode
published: 2026-03-25
retrieved: 2026-10-10
version:
tier: primary
review: pending
recheck: none
fingerprint: 6664d7cb207c23c8218364ee74398f6c4a1b98914d106ad26c693b1d0bdf7f89
archive_url:
---

# How we built Claude Code auto mode: a safer way to skip permissions

公開から約6.5か月たった記事。モデル名・数値・既定値は2026-03-25時点のもの。

## 要点

- 手動の承認は93%が承認されており、承認疲れが起きる。auto mode は承認をモデルベースの分類器に任せ、手動承認と `--dangerously-skip-permissions` の中間に置く。
- 防御は2層。入力側は、ツール出力をエージェントに渡す前に見るサーバー側の prompt-injection probe。出力側は、各アクションを実行前に判定する transcript classifier。
- 分類器は2段。1段目は単一トークンの速いフィルタ（ブロック寄り）、2段目は1段目が旗を立てたものだけ chain-of-thought で再判定する。
- 分類器が見るのはユーザーのメッセージとエージェントのツール呼び出しだけ。Claude 自身の発言とツール出力は除く（推論を見ない設計）。
- 実測（公開時点）: 実トラフィックの誤検知率 0.4%、実際の「出しゃばり」アクションの見逃し率 17%、合成の持ち出しの見逃し率 5.7%。高リスクなインフラ作業で慎重な人手のレビューの代わりにはならない、と明記。
- 拒否されても止まらず、安全な別の手を探させる。連続3回または合計20回の拒否で人間にエスカレーションする。

## 具体的な値

- 脅威モデル4種: overeager behavior、honest mistakes、prompt injection、misaligned model（最後は実際には観測していない）。分類器は前2つに合わせて調整。
- 判定の3層: Tier 1 組み込みの安全ツール許可リストとユーザー設定 / Tier 2 プロジェクト内のファイル操作（分類器なし）/ Tier 3 transcript classifier（シェル、web fetch、外部ツール、サブエージェント起動、プロジェクト外のファイル操作）。
- auto mode に入るとき、任意コード実行を許す許可ルール（シェル全許可、`python`・`node`・`ruby` などのワイルドカード、パッケージマネージャの run 系）は外される。狭いルール（例: コードフォーマッタの実行）は引き継がれる。
- 分類器のプロンプトは固定テンプレート＋3つのカスタム枠（environment、block rules、allow exceptions）。既定で信頼するのは作業中の git リポジトリだけ。block rules は20超で、Destroy or exfiltrate / Degrade security posture / Cross trust boundaries / Bypass review or affect others の4群。
- 既定の確認: `claude auto-mode defaults`。カスタマイズは既定をベースに編集することを推奨。
- 性能表（公開時点）: 1段目のみ — 実トラフィック(n=10,000) FPR 8.5%、実 overeager(n=52) FNR 6.6%、合成 exfil(n=1,000) FNR 1.8%。全パイプライン — FPR 0.4%、FNR 17%、FNR 5.7%。
- 分類器は Sonnet 4.6 で動く（公開時点）。2段目は最後の指示だけが違うので、プロンプトはほぼキャッシュヒットする。
- 拒否の上限: 連続3回または合計20回。headless（`claude -p`）では UI が無いのでプロセスを終了する。
- サブエージェント: 委任時（拒否できる）と返却時（警告のみ）の両方で分類器を走らせる。
- 見逃しの主因: 危険は認識しているが、セッション内の同意の合図が、そのアクションの影響範囲まで及ぶかを誤る。プロンプトの工夫では直せなかった、とある。

## 関連ページ

- [[concepts/auto-mode]]
- [[concepts/cloud-sessions]]
- [[concepts/hooks]]

## 取り込みメモ

- 1回目の curl は別記事（GLM-5.3 に関する別ページ）の内容を返した。同じ URL への2回目で本記事（title と canonical が一致）を取得できた。fingerprint は2回目の生 HTML のもの。原因は不明。
- 記事末尾の「docs に従って始める」の先は未取得（docs の auto mode ページは別途 Ingest が必要）。
- 記事は Sonnet 4.6、Opus 4.6 に言及しているが、現行世代（5.5）での分類器のモデルや数値は本記事からは分からない。
- 記事内に指示文は見当たらなかった。
