" Some stuff added by me, some stuff cannibalized
" from various sources around the net. Feel free to rip this apart and use it
" to your own nefarious ends.

" gui options and colorscheme selection
if has('gui_running')
        set guifont=Bitstream\ Vera\ Sans\ Mono\ 10
        set guioptions-=T
        set guioptions+=g
        set guioptions-=t
        set guioptions-=m
        set guioptions-=L
        set guioptions-=l
        set guioptions-=r
        set guioptions-=R
        set guioptions-=e
        colorscheme tango2
        map <F12> :browse confirm e<CR>
else
        colorscheme default
endif

" Enable powerline
"python from powerline.bindings.vim import source_plugin; source_plugin()
python from powerline.bindings.vim import source_plugin; source_plugin()
let g:Powerline_symbols = 'fancy'

" basic options
set cmdheight=1
set history=50
set modeline
set nocompatible
set noerrorbells
set novisualbell
set number
set shortmess+=aIt
set showcmd
set showfulltag
set showmatch
set showmode
set title
set titlestring=%<%F
set ttyfast
set undolevels=1000
set viminfo='1000,f1,:1000,/1000
set wildmenu
set autowrite

" text layout settings
set noexpandtab
set wrap
set whichwrap+=<,>,[,]

" indent settings
set autoindent
set backspace=eol,start,indent
set shiftwidth=4
set smartindent
set softtabstop=4
set tabstop=4

" folding
set foldmethod=marker

" search options
set cursorline
set gdefault
set incsearch
set isk=@,48-57,_,192-255,-,.,@-@
set nohlsearch
set noignorecase

" set a toggle for pasting input
set pastetoggle=<F10>

" omnicompletion
set completeopt=menu
set completeopt+=menuone " Recommended for popupmenu-plugin
set complete-=i          " Recommended	"		"
set complete-=t          " Recommended  "		"
set tags+=~/.vim/systags
set tags+=./tags
set tags+=../tags
set tags+=../../tags

" set bracket matching and comment formats
set matchpairs+=<:>
set comments-=s1:/*,mb:*,ex:*/
set comments+=s:/*,mb:**,ex:*/
set comments+=fb:*
set comments+=b:\"
set comments+=n::

" use less space for line numbering if possible
if v:version >= 700
        try
                setlocal numberwidth=3
                catch
        endtry
endif

" use css for generated html files
let html_use_css=1

" setup a funky statusline
set laststatus=0
set statusline=
set statusline+=%-3.3n\                      " buffer number
set statusline+=%t\                          " file name
set statusline+=%h%m%r%w                     " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&fileencoding},            " fileencoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=0x%-8B\                      " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset

" enable filetype detection
filetype on
filetype plugin on
filetype indent on

" enable the latexSuite plugin
set grepprg=grep\ -nH\ S*

" autocommands "
if has("autocmd")
        augroup default
                " clear previous autocmds, stops a few errors creeping in.
                autocmd!
                autocmd BufEnter * syntax sync fromstart
                " When editing a file, always jump to the last cursor position.
                autocmd BufReadPost *
                        \       if line("'\"") && line("'\"") <= line("$") |
                                \       exe "normal `\"" |
                        \       endif
                autocmd Filetype *
                                \       if &omnifunc == "" |
                                \       setlocal omnifunc=syntaxcomplete#Complete |
                        \       endif
        augroup end

        augroup filetypes
                autocmd!
                autocmd BufNewFile,BufRead *.tpl set filetype=html
        augroup end

        augroup tex
                autocmd!
                autocmd Filetype tex setlocal wrap
                autocmd FileType tex map \ll :silent make pdf<CR>
                autocmd FileType tex map \lv :silent make view<CR>
                autocmd BufNewFile *.tex silent 0r ~/.vim/templates/template.tex
        augroup end

        augroup c
                autocmd!
                autocmd FileType c,cpp setlocal formatprg=indent
                autocmd FileType c,cpp setlocal cindent cinoptions=:0,p0,t0
                autocmd FileType c,cpp setlocal cinwords=if,else,while,do,for,switch,case
                autocmd FileType c,cpp setlocal expandtab
                autocmd Filetype c,cpp setlocal tabstop=4 shiftwidth=4 softtabstop=4
                autocmd BufNewFile main.c silent 0r ~/.vim/templates/main.c
        augroup end

        augroup perl
                autocmd!
                autocmd Filetype perl setlocal number
                autocmd BufNewFile *.pl silent 0r ~/.vim/templates/template.pl
        augroup end

        augroup gnuplot
                autocmd!
                autocmd BufNewFile,BufRead *.plt,*.gp set filetype=gnuplot
                autocmd BufNewFile *.plt silent 0r ~/.vim/templates/template.plt
        augroup end
endif

map <M-Left> :tabprev<CR>
map <M-Right> :tabnext<CR>
map <F9> :set number!<CR>
nnoremap <silent> <F8> :TlistToggle<CR>

" enable syntax hilighting "
syntax on

" Add closing brackets and quotes aso. when opening
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
" inoremap { {<ESC>mto}<ESC>`ta<CR>
autocmd Syntax html,vim inoremap < <lt>><ESC>i| inoremap > <c-r>=ClosePair('>')<CR>
"inoremap ) <c-r>=ClosePair(')')<CR>
"inoremap ] <c-r>=ClosePair(']')<CR>
"inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
" inoremap ' <c-r>=QuoteDelim("'")<CR>

function ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\<Right>"
  else
    return a:char
  endif
endf

function CloseBracket()
  if match(getline(line('.') + 1), '\s*}') < 0
    return "\<CR>}"
  else
    return "\<ESC>j0f}a"
  endif
endf

function QuoteDelim(char)
  let line = getline('.')
  let col = col('.')
  if line[col - 2] == "\\"
    "Inserting a quoted quotation mark into the string
    return a:char
  elseif line[col - 1] == a:char
    "Escaping out of the string
    return "\<Right>"
  else
    "Starting a string
    return a:char.a:char."\<ESC>i"
  endif
endf

" regex substitution for the word under the cursor
nmap ; :%s/<c-r>=expand("<cword>")<cr>/
vmap ; y:%s/<c-r>"/

" Have ctags created on press of ctrl-f12 (for C++)
map <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>:!cscope -b<CR>
" Make word before the cursor uppercase in insert mode with <C-F>
map! <C-F> <Esc>gUiw`]a

" Insert an IAD-conformant doxygen comment for a new function on press of <F8>
" in insert mode
imap <silent> <F8> <CR>//------------------------------------------------------------------------<CR><ESC>a<CR><ESC>a      ag2sim_func()<CR><ESC>a<CR><ESC>a------------------------------------------------------------------------<CR>!		Desc<CR>!<CR>!     \param  int    blabla<CR>!		\param	int   int<CR>!     \param  int *   pointer<CR>!<CR>!     \return int     0 success, -1 error<CR>!<CR>!     \author Gabel, Samuel<CR>!     \date   03.05.07<CR>------------------------------------------------------------------------

",v brings up my .vimrc
",V reloads it -- making all changes active (have to save first)

map ,v :sp ~/.vimrc<CR><C-W>_
map <silent> ,V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" Add C++-style comments to the beginning of a line with F6
nmap <silent> <F6> 0i//<ESC>
imap <silent> <F6> <ESC>mt0i//<ESC>`t2la
vmap <silent> <F6> :s#^#//#<CR>

" Delete C++-style comments at the beginning of a line with F5
nmap <silent> <F5> :.s#\(^\s*\)//#\1#<CR>
imap <silent> <F5> <ESC>mt:.s#\(^\s*\)//#\1#<CR>`ti
vmap <silent> <F5> :s#^\s*//##<CR>

map <F7> :make<CR>
nmap c :cn<CR>
nmap C :cp<CR>

" Delete the stupid space mapping
nmap <SPACE> i<SPACE>

" Have PageUp/PageDown save the cursor position
nmap <PageUp> m`<C-U>
nmap <PageDown> m`<C-D>
imap <PageUp> <ESC>m`<C-U>a
imap <PageDown> <ESC>m`<C-D>a
vmap <PageUp> <C-U>
vmap <PageDown> <C-D>

" Enable the automatic popupmenu-plugin for word completion
nmap <F4> :AutoComplPopEnable<CR>
" And get rid of it again, when it sucks.
imap <F4> <ESC>:AutoComplPopDisable<CR>a

