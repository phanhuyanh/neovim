call plug#begin('~/.config/nvim/plugins')

" Common plugs
Plug 'vim-airline/vim-airline'
Plug 'ludovicchabant/vim-gutentags'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive' 
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/fzf', { 'build': './install --all', 'merged': 0 }
Plug 'junegunn/fzf.vim', { 'depends': 'fzf' }
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ervandew/supertab'
Plug 'chriskempson/base16-vim'
Plug 'APZelos/blamer.nvim'
Plug 'leafOfTree/vim-vue-plugin'

" Elixir plugs
Plug 'elixir-editors/vim-elixir'
Plug 'mhinz/vim-mix-format'
Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}

" Js/Ts plugs
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'maxmellon/vim-jsx-pretty'

call plug#end()

let mapleader = " "

" Settings for vim mix format
let g:mix_format_on_save = 1

" Settings for Vim Airline
let g:airline_powerline_fonts = 1
set hidden
let g:Powerline_symbols = 'fancy'
let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#tab_nr_type = 1

" Settings for NERDTree
let NERDTreeIgnore = ['\.beam$', '_build', 'node_modules', 'deps']
let NERDTreeAutoDeleteBuffer = 1 " Auto delete buffer when files/folders are deleted by NERDTree
let NERDTreeQuitOnOpen = 1 " Auto close NERDTree when open a file
let NERDTreeMinimalUI = 1
map <leader>\ :NERDTreeToggle<CR>

" Enable Git blamer
let g:blamer_enabled = 1
let g:blamer_delay = 500
let g:blamer_relative_time = 1

" Config Vue plugin
let g:vim_vue_plugin_config = { 
      \'syntax': {
      \   'template': ['html'],
      \   'script': ['javascript'],
      \   'style': ['css', 'sass', 'scss', 'less'],
      \},
      \'full_syntax': [],
      \'initial_indent': [],
      \'attribute': 0,
      \'keyword': 0,
      \'foldexpr': 0,
      \'debug': 0,
      \}

" Settings for Coc
" show hints/documentations
nnoremap <silent>? :call CocAction('doHover')<CR>

" Global clipboard
if empty($SSH_CONNECTION) && has('clipboard')
 set clipboard^=unnamed                " Use vim global clipboard register
 if has('unnamedplus') || has('nvim')  " Use system clipboard register
   set clipboard^=unnamedplus
 endif
endif

" Setup for ripgrep, fzf
" To show preview in fashion way, you need to install bat - a cat alternative
" programe
let $FZF_DEFAULT_OPTS='
            \ --color=fg:#9CA3AF,bg:#1F2937,hl:#FBBF24
            \ --color=fg+:#ffffff,bg+:#6B7280,hl+:#f57900
            \ --color=info:#afaf87,prompt:#d7005f,pointer:#cc0000
            \ --color=marker:#DB2777,spinner:#af5fff,header:#729fcf'

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --smart-case --color=never --ignore-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

"Restore cursor to file position in previous editing session
""http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
"set viminfo='10,\"100,:20,%,n~/.viminfo
" :help last-position-jump
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Settings for Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"
autocmd FileType javascript let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" Settings for gutentags
set statusline+=%{gutentags#statusline()}

" Settings for auto-pairs
let g:AutoPairsMultilineClose = 0

filetype plugin on
filetype plugin indent on

syntax on

set encoding=UTF-8
set autoread

set hlsearch " Highlight search
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set updatetime=100
set colorcolumn=100
set list listchars=tab:‚ñ∏\ ,eol:$,trail:¬∑

" Enable true colors support
if (has("termguicolors"))
 set termguicolors
endif

set termguicolors     " enable true colors support
set background="dark
set number
colorscheme palenight

function UnchangedHighlight()
  highlight ExtraWhitespace ctermbg=red guibg=red guifg=white
  highlight SpecialKey ctermfg=red guifg=#ff0000
  " Coc Highlight
  highlight CocErrorLine guifg=#000000 guibg=#D25972
  highlight CocWarningLine guifg=#000000 guibg=#CBAC62
endfunction

function DefaultHighlight()
  highlight NonText guifg=#3e3e3e
endfunction

call DefaultHighlight()
call UnchangedHighlight()

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>= :vertical resize +5<CR>
nnoremap <leader>- :vertical resize -5<CR>
nnoremap <leader>ps :Rg<SPACE>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>gs :GFiles?<CR>
nnoremap <leader>\ :vsp<CR>
nnoremap <leader>e :Ex<CR>
nnoremap <leader>mm :noh<CR>
:set ignorecase

" Try Telescopte
nnoremap <leader>tl <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Open current file in Chrome browser
nnoremap <leader>M :!open % -a Google\ Chrome<CR>

" Set rawtime exceeded
set redrawtime=10000
