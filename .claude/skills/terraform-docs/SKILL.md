---
name: terraform-docs
description: Terraform moduleのREADME.mdをterraform-docsと連携した上で生成・更新する
allowed-tools: Read, Write, Edit, Glob
---

# terraform-docs README 執筆

`maoz-terraform-modules` の Terraform モジュール README に、**概要** と **usage** を
一貫した書式で執筆する。新規モジュールの README 作成時、または既存 README の整備時に使う。

## 前提

- (`.github/workflows/terraform-docs.yml`) が `<!-- BEGIN_TF_DOCS -->` 〜
  `<!-- END_TF_DOCS -->` の**マーカー間**に自動注入する。手で書かない・触らない。
- **概要** と **usage** は terraform-docs が生成しない手書き部分。マーカーの**前**に置く。

## 対象の指定（引数）

`$ARGUMENTS` で対象を指定する。

- **あり**: 指定対象**のみ**執筆。`proxmox/lxc` / `proxmox/lxc/README.md` / スペース区切りの
  複数指定を受け付け、`{provider}/{module}/README.md` に正規化する。存在しなければその旨を
  伝え、他モジュールへ広げない。
- **なし**: 全モジュールを走査し、概要 / usage が未整備または `variables.tf` と不整合な
  README を対象とする。判断がつかなければユーザーに確認する。

## フォーマット（唯一の書式基準・既存 README は参考にしない）

```markdown
# {provider}/{module}

{概要: このモジュールが作るものを日本語 1〜3 行で}

## usage

\`\`\`hcl
module "{example}" {
  source = "github.com/maooz4426/maoz-terraform-modules//{provider}/{module}?ref=main"

  # 実在する必須変数のみ（variables.tf の default 無し変数を漏らさない）
  variable_name = "value"
}
\`\`\`

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
```

- `source` は上記形式を厳守（例 `//proxmox/vm?ref=main`）。
- マーカーは末尾に 1 組だけ、間は空にする。

## 手順

1. `$ARGUMENTS` から対象を確定する。
2. 対象の `variables.tf` / `main.tf` / `outputs.tf` を Read し、目的・必須変数・作成リソースを把握する。
3. 概要（日本語 1〜3 行）と usage を上記フォーマットで書く。
4. 既存 README を更新する場合は手書き部分だけ差し替え、マーカーとマーカー間は触らない。

## チェックリスト

- [ ] マーカーが末尾に 1 組だけ
- [ ] usage の変数が `variables.tf` と一致し、必須変数を網羅
- [ ] `source` が規約どおり
- [ ] 概要が日本語で目的を表す
