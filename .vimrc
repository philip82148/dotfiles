" =============================================================================
" 1. 基本設定 (General Settings)
" =============================================================================
" クリップボードをシステムと同期 (vim.useSystemClipboard)
set clipboard+=unnamed,unnamedplus

" 検索結果をハイライト表示 (vim.hlsearch)
set hlsearch

" 行番号を相対表示にする (editor.lineNumbers: "relative")
set number
set relativenumber

" LeaderキーをSpaceに設定 (vim.leader)
let mapleader = "\<Space>"


" =============================================================================
" 2. 共通マッピング (Normal & Visual Mode)
" =============================================================================
" ※ noremap を使うことで、ノーマル・ビジュアル両モードに同時に適用し重複を排除します。

" [ページ移動] 大文字 J / K で半画面スクロール (Ctrl + d / u)
noremap J <C-d>
noremap K <C-u>

" [行内移動] 大文字 L / H で行末 / 行頭へ移動
noremap L $
noremap H ^

" [対応するカッコへの移動] 大文字 M で % の挙動
noremap M %


" =============================================================================
" 3. モード個別マッピング (Mode Specific Settings)
" =============================================================================

" --- インサートモード (Insert Mode) ---
" jj でノーマルモードに戻る
inoremap jj <Esc>
" ;; で補完を起動 (Vim標準のキーワード補完 <C-n> を割り当て)
inoremap ;; <C-n>


" --- ノーマルモード専用 (Normal Mode Only) ---
" [undo/redo] 大文字 U でリドゥ (Vim標準の <C-r> にマッピング)
nnoremap U <C-r>

" [削除でレジスタを汚さない] x や s で削除した文字をヤンクしない
nnoremap x "_x
nnoremap s "_d
nnoremap S "_D
nnoremap ss "_dd

" [改行] Enterで直下に空行を挿入してノーマルモードを維持
nnoremap <Enter> o<Esc>

" [改行をなくす] Ctrl + j で下の行を連結 (Vim標準の J の挙動)
nnoremap <C-j> J

" [その他の操作] エディタを閉じる / 検索ハイライト消去
nnoremap <Leader>w :bd<CR>
nnoremap <Leader>z :noh<CR>

" [コード整形] Vim標準の全体自動インデントを割り当て
nnoremap <Leader>f gg=G


" --- ビジュアルモード専用 (Visual Mode Only) ---
" <Leader>j でノーマルモードに戻る
vnoremap <Leader>j <Esc>

" [ペーストでレジスタを汚さない] 選択部分に貼り付けた際に、上書きされたテキストをヤンクしない
vnoremap p "_dP

" [インデント] インデント調整後も選択状態を維持する(gv)
vnoremap > >gv
vnoremap < <gv


" =============================================================================
" 4. プラグインが必要な設定 (Optional Plugin Settings)
" =============================================================================
" 【Highlighted Yank】 ヤンク時のハイライト
" machakann/vim-highlightedyank プラグインを導入すると有効になります
" let g:highlightedyank_highlight_duration = 150

" 【EasyMotion】 fキーで独自のEasyMotionを起動していた設定
" easymotion/vim-easymotion プラグインを導入すると有効になります
" map f <Plug>(easymotion-bd-w)
