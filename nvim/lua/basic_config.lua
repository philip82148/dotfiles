-- =============================================================================
-- 1. 基本設定 (General Settings)
-- =============================================================================
-- オプションの一括設定
local options = {
    fileencoding = "utf-8", -- エンコーディングをUTF-8に設定
    swapfile = false, -- スワップファイルは作成しない
    helplang = "ja", -- ヘルプファイルの言語は日本語
    number = true, -- 行番号を表示
    relativenumber = true, -- 行番号を相対表示にする
    wrap = false, -- 画面の右端で改行しない
    ambiwidth = "double", -- 記号を全角文字の幅で表示（半角との重なり解消）
    autoindent = true, -- 改行時に1つ上の行のインデントを引き継ぐ
    smartindent = true, -- スマートインデントを有効化
    cursorline = true, -- カーソルが存在する行をハイライト
    tabstop = 2, -- TABキーを押したときの幅（2文字分）
    softtabstop = 2, -- 編集操作でのTABの幅
    shiftwidth = 2, -- 自動インデント等の幅
    expandtab = true, -- TABを半角スペースに展開
    autoread = true, -- 外部でファイル変更されたら自動再読み込み
    showmatch = true, -- 閉じ括弧の入力時に対応する括弧をハイライト
    matchtime = 1, -- 括弧マッチの表示時間（0.1秒単位）
    ignorecase = true, -- 検索時に大文字小文字を無視
    smartcase = true, -- 大文字が含まれる場合は区別して検索
    wrapscan = true, -- 検索が末尾までいったら先頭に戻る
    hlsearch = true -- 検索結果をハイライト表示
}

-- optテーブルを適用
for k, v in pairs(options) do
    vim.opt[k] = v
end
