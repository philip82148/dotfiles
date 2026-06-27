local options = {
    fileencoding = "utf-8", -- エンコーディングをUTF-8に設定
    swapfile = false, -- スワップファイルは作成しない
    helplang = "ja", -- ヘルプファイルの言語は日本語
    hidden = true, -- バッファを切り替えるときに、ファイルを保存しなくても良いように
    number = true, -- 行番号を表示
    wrap = false, -- 画面の右端で改行しない
    ambiwidth = 'double', -- 記号が半角文字と重なる問題を解消。記号を全角文字の幅で表示する
    autoindent = true, -- 新しい行を開業したとき、1つ上の行のインデントを引き継ぐ
    smartindent = true,
    cursorline = true, -- カーソルが存在する行にハイライトを当ててくれます
    tabstop = 2, -- TABキーを押したとき、2文字分の幅をとる
    softtabstop = 2,
    shiftwidth = 2,
    expandtab = true, -- tabstopで指定した数の分の半角スペースが入力
    autoread = true, -- vim以外でファイル変更したときに自動再読み込みする
    showmatch = true, -- 括弧の連携
    matchtime = 1,
    ignorecase = true, -- 大文字無視
    smartcase = true, -- 大文字で検索したら区別をつける
    wrapscan = true -- 検索が末尾までいったら先頭から検索
}
for k, v in pairs(options) do
    vim.opt[k] = v
end
