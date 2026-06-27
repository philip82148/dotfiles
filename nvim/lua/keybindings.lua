-- =============================================================================
-- 1. 基本設定 (General Settings)
-- =============================================================================
-- クリップボードをシステムと同期
vim.opt.clipboard:append({"unnamed", "unnamedplus"})

-- 検索結果をハイライト表示
vim.opt.hlsearch = true

-- 行番号を相対表示にする
vim.opt.number = true
vim.opt.relativenumber = true

-- LeaderキーをSpaceに設定 (キーマップ定義より前に書く必要があります)
vim.g.mapleader = " "

-- =============================================================================
-- 2. 共通マッピング (Normal & Visual Mode)
-- =============================================================================
-- ※ vim.keymap.set でモードに {"n", "v"} を指定し、重複を排除します。
-- ※ デフォルトで remap = false (noremap と同等) になります。

-- [ページ移動] 大文字 J / K で半画面スクロール
vim.keymap.set({"n", "v"}, "J", "<C-d>")
vim.keymap.set({"n", "v"}, "K", "<C-u>")

-- [行内移動] 大文字 L / H で行末 / 行頭へ移動
vim.keymap.set({"n", "v"}, "L", "$")
vim.keymap.set({"n", "v"}, "H", "^")

-- [対応するカッコへの移動] 大文字 M で % の挙動
vim.keymap.set({"n", "v"}, "M", "%")

-- [インデント] インデント調整後も選択状態を維持する
vim.keymap.set({"n", "v"}, ">", ">gv")
vim.keymap.set({"n", "v"}, "<", "<gv")

-- =============================================================================
-- 3. モード個別マッピング (Mode Specific Settings)
-- =============================================================================

--- インサートモード (Insert Mode) ---
-- jj でノーマルモードに戻る
vim.keymap.set("i", "jj", "<Esc>")
-- ;; で補完を起動
vim.keymap.set("i", ";;", "<C-n>")

--- ノーマルモード専用 (Normal Mode Only) ---
-- [undo/redo] 大文字 U でリドゥ
vim.keymap.set("n", "U", "<C-r>")

-- [削除でレジスタを汚さない] x や s で削除した文字をヤンクしない
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "s", '"_d')
vim.keymap.set("n", "S", '"_D')
vim.keymap.set("n", "ss", '"_dd')

-- [改行] Enterで直下に空行を挿入してノーマルモードを維持
vim.keymap.set("n", "<Enter>", "o<Esc>")

-- [改行をなくす] Ctrl + j で下の行を連結
vim.keymap.set("n", "<C-j>", "J")

-- [その他の操作] エディタを閉じる / 検索ハイライト消去
vim.keymap.set("n", "<Leader>w", ":bd<CR>")
vim.keymap.set("n", "<Leader>z", ":noh<CR>")

-- [コード整形] 全体自動インデント
vim.keymap.set("n", "<Leader>f", "gg=G")

--- ビジュアルモード専用 (Visual Mode Only) ---
-- <Leader>j でノーマルモードに戻る
vim.keymap.set("v", "<Leader>j", "<Esc>")

-- [ペーストでレジスタを汚さない]
vim.keymap.set("v", "p", '"_dP')

-- =============================================================================
-- 4. Neovim 拡張・プラグイン関連設定
-- =============================================================================

-- 【Highlighted Yank】 ヤンク時のハイライト (Neovim標準の機能で実現)
-- プラグインなしで動作します。ハイライト時間を150msに設定
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 150
        })
    end
})

-- 【EasyMotion】 プラグイン依存の設定例
-- もし flash.nvim や leap.nvim、hop.nvim などのNeovim製プラグインに移行する場合は
-- 各プラグインの記法に合わせてキーマップを書き換えてください。
-- 以下は従来の vim-easymotion を lazy.nvim 等で読み込んでいる場合の記述例です：
-- vim.keymap.set("", "f", "<Plug>(easymotion-bd-w)")
--
