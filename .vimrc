
set backspace=indent,eol,start
set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

filetype plugin indent on

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'scrooloose/nerdcommenter'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'majutsushi/tagbar'
Plugin 'moll/vim-node'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'pangloss/vim-javascript'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/syntastic'
Plugin 'fatih/vim-go'
Plugin 'python-mode/python-mode'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'pearofducks/ansible-vim'
Plugin 'tpope/vim-sensible'

call vundle#end()

"vim-node
autocmd User Node
    \ if &filetype == "javascript" |
    \   nmap <buffer> <C-w>f <Plug>NodeVSplitGotoFile |
    \   nmap <buffer> <C-w><C-f> <Plug>NodeVSplitGotoFile |
    \ endif

"""python
let g:pymode_indent = 0
let g:pymode_rope = 1
" Documentation
let g:pymode_doc = 0
let g:pymode_doc_key = 'K'
set completeopt=menu
"Linting
let g:pymode_lint = 1
let g:pymode_lint_checkers = "pyflakes,pep8"
"let g:pymode_lint_checkers = "pylint,pyflakes"
" Maximum line length
let g:pymode_options_max_line_length = 120
" let g:pymode_lint_options_pyflakes = { 'builtins': '_' }
let g:pymode_lint_options_pep8 = {'max_line_length': g:pymode_options_max_line_length}
" Auto check on save
let g:pymode_lint_write = 1
let g:pymode_lint_ignore = "C0111"
" Support virtualenv
let g:pymode_virtualenv = 1
" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
"Don't autofold code
let g:pymode_folding = 0
"quickfix
let g:pymode_quickfix_minheight = 2
let g:pymode_quickfix_maxheight = 5


"syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let g:syntastic_javascript_checkers=['standard']
"let g:syntastic_javascript_standard_exec = 'semistandard'
"
"autocmd bufwritepost *.js silent !semistandard % --format
"set autoread

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 2
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_list_type = "quickfix"

"airline
set laststatus=2
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'
" let g:airline_theme='wombat'
" Move to the next buffer
nmap <leader>l :bnext<CR>
" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" By default the leader shortcut is defined as: \ I've mapped my leader to ,
let mapleader = ","


"color
syntax enable
set background=dark
colorscheme solarized
let g:solarized_termtrans = 1
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color

"encoding
set encoding=utf-8
set fileencodings=utf-8,chinese,latin-1
set fileencoding=utf-8
set termencoding=utf-8

"vim-javascript
let g:javascript_conceal_function   = "ƒ"
let g:javascript_conceal_null       = "ø"
let g:javascript_conceal_this       = "@"
let g:javascript_conceal_return     = "⇚"
let g:javascript_conceal_undefined  = "¿"
let g:javascript_conceal_NaN        = "ℕ"
let g:javascript_conceal_prototype  = "¶"
let g:javascript_conceal_static     = "•"
let g:javascript_conceal_super      = "Ω"
set regexpengine=1
syntax enable

"NerdTree
"autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" 将 NERDTree 的窗口设置在 vim 窗口的右侧（默认为左侧）
let NERDTreeWinPos="right"
let NERDTreeShowBookmarks=1

" remember pos of cursor
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif 

" hightlight extra white space
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" remove trailing space
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction
autocmd BufWritePre     *.js :call TrimWhiteSpace()


nmap <C-b>n  :bnext<CR>
nmap <C-b>p  :bprev<CR>

" --- taglist
let ctagsbin = 'gotags'
" check if vim-go is available and has the binary
if !executable('gotags') && !exists("g:go_gotags_bin")
    let ctagsbin = expand(g:go_gotags_bin),
endif

nmap <silent><F8> :TlistToggle<CR>
imap <silent><F8> <C-o>:TlistToggle<CR>
let Tlist_Use_SingleClick = 1
let Tlist_Use_Right_Window = 1
let Tlist_Show_One_File = 1
let tlist_php_settings = 'php;c:class;d:constant;f:function'
" --- tagbar
nmap <Leader>rt :TagbarToggle<CR>
let g:tagbar_autofocus = 1

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" golang
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:go_fmt_command = "goimports"

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
"set autoindent
"set smartindent
"au FileType Makefile set noexpandtab
"retab

"ansible
let g:ansible_extra_keywords_highlight = 1
let g:ansible_attribute_highlight = "ob"
let g:ansible_name_highlight = 'd'

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

set softtabstop=4
