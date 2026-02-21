# dotfiles

設定ファイル管理リポジトリです。シンボリックリンクで `$HOME` に展開します。

## セットアップ

```bash
git clone <リポジトリURL> ~/dotfiles
bash ~/dotfiles/setup.sh
```

## ファイルの追加

1. `~/dotfiles/` にファイルを置く
2. `setup.sh` の `DOT_FILES` 配列に追加する
3. `bash setup.sh` を再実行する
