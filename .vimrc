"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vimrc:
"
" Author: Marko Maric
"
" Plugin List:
"   vim-nerdtree           -> File browser
"   vim-syntastic          -> Syntax checker
"   vim-jinja              -> Jinja for Vim
"   vim-json               -> Better JSON for Vim
"   vim-python-syntax      -> Python syntax highlighting
"   vim-python-pep8-indent -> Modify Vim indentation behaviour to comply with Pep8
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"+=====================+"
"|  Colours            |"
"+=====================+"

"Enable syntax highlighting
syntax on
colorscheme badwolf

"+=====================+"
"|  User Interface     |"
"+=====================+"

"Indentation options for using 4 spaces instead of tabs
set tabstop=4 "number of visual spaces per TAB
set shiftwidth=4
set softtabstop=4 "number of spaces in tab when editing
set expandtab "tabs are spaces
set encoding=utf-8
set number "show line numbers
set showcmd "show command in bottom bar
set cursorline "highlight current line
set showmatch "highlight matching brackets
set incsearch "search as characters are entered
set hlsearch "highlight matches
set ignorecase "Use case isensitive search except when using capital letters
set smartcase
"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>:<backspace>

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype plugin indent on

"+=====================+"
"|  Misc
"+=====================+"

set nobackup "file automatically deleted after succesfully writing the og file
set autoread
set clipboard=unnamed
" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e
" Automatically write closing brackets and ending quotes
inoremap        (  ()<Left>
inoremap        [  []<Left>
inoremap        {  {}<Left>
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"


"+===================
" o/O                   Start insert mode with [count] blank lines.
"                       The default behavior repeats the insertion [count]
"                       times, which is not so useful.
function! s:NewLineInsertExpr( isUndoCount, command )
    if ! v:count
        return a:command
    endif

    let l:reverse = { 'o': 'O', 'O' : 'o' }
    " First insert a temporary '$' marker at the next line (which is necessary
    " to keep the indent from the current line), then insert <count> empty lines
    " in between. Finally, go back to the previously inserted temporary '$' and
    " enter insert mode by substituting this character.
    " Note: <C-\><C-n> prevents a move back into insert mode when triggered via
    " |i_CTRL-O|.
    return (a:isUndoCount && v:count ? "\<C-\>\<C-n>" : '') .
    \   a:command . "$\<Esc>m`" .
    \   v:count . l:reverse[a:command] . "\<Esc>" .
    \   'g``"_s'
endfunction
nnoremap <silent> <expr> o <SID>NewLineInsertExpr(1, 'o')
nnoremap <silent> <expr> O <SID>NewLineInsertExpr(1, 'O')


"+====================

"+=====================+"
"|  Plugin Key Maps    |"
"+=====================+"

let g:python_pep8_indent_hang_closing = 1
let g:python_pep8_indent_multiline_string = 1
let g:syntastic_python_checkers = ['flake8']
let g:python_highlight_all = 1
" map f2 to toggle nerdtree
map <F2> :NERDTreeToggle<CR>
"map f3 to sysntasticchecker
map <F3> :SyntasticCheck<CR>
"map f4 to ctrlp
map <F4> :CtrlP<CR>
