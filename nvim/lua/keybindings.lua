-- クリップボードをシステムと同期
vim.opt.clipboard:append({"unnamed", "unnamedplus"})

-- LeaderキーをSpaceに設定 (キーマップ定義より前に書く必要があります)
vim.g.mapleader = " "

-- =============================================================================
-- 2. 共通マッピング (Normal & Visual Mode)
-- =============================================================================
-- ※ vim.keymap.set でモードに {"n", "v"} を指定し、重複を排除
-- ※ デフォルトで remap = false (noremap と同等)

-- [ページ移動] 大文字 J / K で半画面スクロール
vim.keymap.set({"n", "v"}, "J", "<C-d>")
vim.keymap.set({"n", "v"}, "K", "<C-u>")

-- [行内移動] 大文字 L / H で行末 / 行頭へ移動
vim.keymap.set({"n", "v"}, "L", "$")
vim.keymap.set({"n", "v"}, "H", "^")

-- [対応するカッコへの移動] 大文字 M で % の挙動
vim.keymap.set({"n", "v"}, "M", "%")

-- [コメントアウト] 行・選択範囲のコメント切り替え
vim.keymap.set({"n", "v"}, "<Leader>c", "gc", {
    remap = true
})

-- [インデント] インデント調整（調整後もビジュアルモードの選択状態を維持）
vim.keymap.set({"n", "v"}, ">", ">gv")
vim.keymap.set({"n", "v"}, "<", "<gv")

-- [コード整形] ファイル全体または選択範囲をLSPでフォーマット
vim.keymap.set({"n", "v"}, "<Leader>f", function()
    vim.lsp.buf.format({
        async = true
    })
end)

-- [その他の操作] エディタを閉じる / 検索ハイライト消去
vim.keymap.set({"n", "v"}, "<Leader>w", ":bd<CR>")
vim.keymap.set({"n", "v"}, "<Leader>z", ":noh<CR>")

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
-- [改行] Shift + Enter で直上に空行を挿入してノーマルモードを維持
vim.keymap.set("n", "<S-Enter>", "O<Esc>")

-- [改行をなくす] Ctrl + j で下の行を連結
vim.keymap.set("n", "<C-j>", "J")

--- ビジュアルモード専用 (Visual Mode Only) ---
-- <Leader>j でノーマルモードに戻る
vim.keymap.set("v", "<Leader>j", "<Esc>")

-- [ペーストでレジスタを汚さない]
vim.keymap.set("v", "p", '"_dP')

-- =============================================================================
-- 4. Neovim 拡張・プラグイン関連設定
-- =============================================================================

-- 【Highlighted Yank】 ヤンク時のハイライト (Neovim標準の機能で実現)
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 150
        })
    end
})
