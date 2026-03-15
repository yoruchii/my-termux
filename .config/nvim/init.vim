" =============================================================================
" FUNDAMENTAL SETTINGS
" =============================================================================
set nocompatible
set encoding=utf-8
set number                                               set wrap                                                 set smartindent
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set updatetime=300                                       set signcolumn=yes            " Selalu tampilkan kolom tanda agar tidak geser
set laststatus=2
set showtabline=2             " Selalu tampilkan tabline
set noshowmode                " Mode tidak perlu tampil karena sudah ada di lightline
set cursorline                " Sorot baris aktif
set termguicolors             " Wajib aktif untuk warna yang akurat

if has('clipboard')
  set clipboard+=unnamedplus
endif

syntax on
filetype plugin indent on

" =============================================================================
" SHORTCUTS
" =============================================================================
let mapleader = " "
nnoremap <S-s> :w<CR>
nnoremap <S-q> :q<CR>
nnoremap <S-Q> :q!<CR>

" Navigasi Tab
nnoremap <S-P> :tabprevious<CR>
nnoremap <S-N> :tabnext<CR>
nnoremap <S-G> :tabnew<CR>
nnoremap <S-f> :Telescope find_files<CR>

" =============================================================================
" PLUGIN MANAGER
" =============================================================================
call plug#begin()

" UI & Icons
Plug 'itchyny/lightline.vim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'morhetz/gruvbox'

" Coding Helpers
Plug 'mattn/emmet-vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/indentLine'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'windwp/nvim-autopairs'
Plug 'akinsho/toggleterm.nvim', { 'tag': '*' }

call plug#end()

" ============================================================================
" COLORSCHEME & HIGHLIGHT CUSTOMIZATION
" =============================================================================
colorscheme gruvbox

" Custom warna
highlight LineNr guifg=#8ec07c
highlight CursorLineNr guifg=#ebdbb2 gui=bold
highlight Visual guibg=#665c54
" highlight Normal guibg=NONE    " Jika ingin background transparan mengikuti terminal

" =============================================================================
" LIGHTLINE CONFIG (Statusline & Tabline)
" =============================================================================
" Catatan: Pastikan pakai Nerd Font di terminal agar icon/panah muncul
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'filetype' ] ]
      \ },
      \ 'tabline': {
      \   'left': [ [ 'tabs' ] ],
      \   'right': [ [ 'my_text' ] ]
      \ },
      \ 'component': {
      \   'my_text': ' Yoru'
      \ },
      \ 'tab_component_function': {
      \   'filename': 'LightlineTabname',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

" =============================================================================
" TELESCOPE, TREESITTER CONFIG DLL
" =============================================================================
lua << EOF
require('nvim-treesitter').setup {
  highlight = { enable = true },
}

local actions = require("telescope.actions")
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ["<C-t>"] = actions.select_tab,
      },
    },
  }
}
EOF

let g:user_emmet_mode='a'

 " Indent Line
let g:indentLine_char = '¦'

 " Colorizer
lua << EOF
require'colorizer'.setup({
  '*'; -- Target semua filetype
}, {
  RGB      = true,         -- #RGB hex codes
  RRGGBB   = true,         -- #RRGGBB hex codes
  names    = true,         -- "Name" codes like Blue
  RRGGBBAA = true,        -- #RRGGBBAA hex codes
  rgb_fn   = true,        -- CSS rgb() and rgba() functions
  hsl_fn   = true,        -- CSS hsl() and hsla() functions
  css      = true,        -- Enable all CSS features
  css_fn   = true,        -- Enable all CSS functions
  mode     = 'background', -- Set the display mode ke background
})
EOF

 " Fungsi untuk menerapkan icon di lightline
function! LightlineTabname(n) abort
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let _filename = expand('#' . buflist[winnr - 1] . ':t')
  let _extension = expand('#' . buflist[winnr - 1] . ':e')

  " Ambil ikon menggunakan Lua dari nvim-web-devicons
  let icon = luaeval("require('nvim-web-devicons').get_icon('" . _filename . "', '" . _extension . "', { default = true })")

  " Jika file tidak ada namanya, tampilkan [No Name]
  let name = _filename !=# '' ? _filename : '[No Name]'

  return icon . ' ' . name
endfunction

" Autopairs
lua << EOF
require("nvim-autopairs").setup {}
EOF

" Toggle Terminal
lua << EOF
require("toggleterm").setup{
  open_mapping = [[<S-T>]],   -- shortcut buka tutup (SHIFT + T)
  direction = "float",        -- floating terminal
  float_opts = {
    border = "curved"         -- border style
  }
}
EOF
