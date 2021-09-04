# SKK-JISYO.capitalization

特徴的な表記をもつ単語を収録したSKK辞書です。

## 辞書ファイルの作成

次のコマンドを実行すると `SKK-JISYO.capitalization` ファイルが作成されます。

```
bundle config --local path 'vendor/bundle'
bundle install
make
```

## ライセンス

ref: [COPYING.md](./COPYING.md)

次のファイルは[クリエイティブコモンズ 表示 - 継承 4.0 国際 ライセンス](https://creativecommons.org/licenses/by-sa/4.0/) (CC BY-SA 4.0) で提供されます。

* `SKK-JISYO.capitalization`
* `SKK-JISYO.capitalization.utf8`
* `dict` ディレクトリ以下の全てのファイル
  * `dict/jawiki-latest.xml` is a derivative of
    "[jawiki-latest-pages-articles.xml.bz2](https://dumps.wikimedia.org/jawiki/latest/)" by Wikimedia Foundation,
    used under [CC BY-SA 3.0](https://creativecommons.org/licenses/by-sa/3.0/).

その他のプログラムは MIT ライセンス ([LICENSE-MIT.txt](./LICENSE-MIT.txt)) で提供されます。
