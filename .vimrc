set enc=utf-8
set fenc=utf-8
set fencs=utf-8,euc-jp,sjis,iso-2022-jp

set nocompatible  " Use Vim defaults instead of 100% vi compatibility
set backspace=indent,eol,start  " more powerful backspacing

" Now we set some defaults for the editor 
set textwidth=0   " Don't wrap words by default
set nobackup    " Don't keep a backup file
"set viminfo=50 ,<1000,s100,\"50 " read/write a .viminfo file, don't store more than
"set viminfo='50,<1000,s100,:0,n~/.vim/viminfo
set history=100   " keep 50 lines of command line history
set ruler   " show the cursor position all the time

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc

"==<head comment>=============================================================
iab papp <ESC>:r ~/.vim_templates/perl_application.pl<CR>
iab _comment <ESC>:r ~/.vim_templates/perl_comment.pl<CR>
iab perl_mod <ESC>:r ~/.vim_templates/perl_module.pl<CR>

set mouse=a
if &term == "screen"
  set ttymouse=xterm2
endif


" We know xterm-debian is a color terminal
if &term =~ "xterm-debian" || &term =~ "xterm-xfree86" || &term =~ "xterm-256color"
  set t_Co=16
  set t_Sf=[3%dm
  set t_Sb=[4%dm
endif

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

syntax on

if &term =~ "xterm-256color"
  "  colorscheme desert256
  colorscheme inkpot
endif

" Debian uses compressed helpfiles. We must inform vim that the main
" helpfiles is compressed. Other helpfiles are stated in the tags-file.
" set helpfile=$VIMRUNTIME/doc/help.txt.gz
set helpfile=$VIMRUNTIME/doc/help.txt

if has("autocmd")
  " Enabled file type detection
  " Use the default filetype settings. If you also want to load indent files
  " to automatically do language-dependent indenting add 'indent' as well.
  filetype plugin on
  "¤½¤Î¥Õ¥¡¥¤¥ë¥¿¥¤¥×¤Ë¤¢¤ï¤»¤¿¥¤¥ó¥Ç¥ó¥È¤òÍøÍÑ¤¹¤ë
  filetype indent on
  " ¤³¤ì¤é¤Îft¤Ç¤Ï¥¤¥ó¥Ç¥ó¥È¤òÌµ¸ú¤Ë
  "autocmd FileType php filetype indent off

  " autocmd FileType php :set indentexpr=
  autocmd FileType html :set indentexpr=
  autocmd FileType xhtml :set indentexpr=
endif

" Some Debian-specific things
augroup filetype
  au BufRead reportbug.*    set ft=mail
  au BufRead reportbug-*    set ft=mail
augroup END

" ¥¿¥ÖÉý¤ÎÀßÄê
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

set modelines=0

"¥¤¥ó¥Ç¥ó¥È¤Ï¥¹¥Þ¡¼¥È¥¤¥ó¥Ç¥ó¥È
set smartindent
"¸¡º÷Ê¸»úÎó¤¬¾®Ê¸»ú¤Î¾ì¹ç¤ÏÂçÊ¸»ú¾®Ê¸»ú¤ò¶èÊÌ¤Ê¤¯¸¡º÷¤¹¤ë
set ignorecase
"¸¡º÷Ê¸»úÎó¤ËÂçÊ¸»ú¤¬´Þ¤Þ¤ì¤Æ¤¤¤ë¾ì¹ç¤Ï¶èÊÌ¤·¤Æ¸¡º÷¤¹¤ë
set smartcase
"¸¡º÷»þ¤ËºÇ¸å¤Þ¤Ç¹Ô¤Ã¤¿¤éºÇ½é¤ËÌá¤ë
set wrapscan
"¸¡º÷Ê¸»úÎóÆþÎÏ»þ¤Ë½ç¼¡ÂÐ¾ÝÊ¸»úÎó¤Ë¥Ò¥Ã¥È¤µ¤»¤Ê¤¤
set noincsearch
"¥¿¥Ö¤Îº¸Â¦¤Ë¥«¡¼¥½¥ëÉ½¼¨
"set listchars=tab:\\ 
set nolist
"ÆþÎÏÃæ¤Î¥³¥Þ¥ó¥É¤ò¥¹¥Æ¡¼¥¿¥¹¤ËÉ½¼¨¤¹¤ë
set showcmd
"³ç¸ÌÆþÎÏ»þ¤ÎÂÐ±þ¤¹¤ë³ç¸Ì¤òÉ½¼¨
set showmatch
"¸¡º÷·ë²ÌÊ¸»úÎó¤Î¥Ï¥¤¥é¥¤¥È¤òÍ­¸ú¤Ë¤·¤Ê¤¤
set nohlsearch
"¥¹¥Æ¡¼¥¿¥¹¥é¥¤¥ó¤ò¾ï¤ËÉ½¼¨
set laststatus=2

function! GetB()
  let c = matchstr(getline('.'), '.', col('.') - 1)
  let c = iconv(c, &enc, &fenc)
  return String2Hex(c)
endfunction
" :help eval-examples
" The function Nr2Hex() returns the Hex string of a number.
func! Nr2Hex(nr)
  let n = a:nr
  let r = ""
  while n
    let r = '0123456789ABCDEF'[n % 16] . r
    let n = n / 16
  endwhile
  return r
endfunc
" The function String2Hex() converts each character in a string to a two
" character Hex string.
func! String2Hex(str)
  let out = ''
  let ix = 0
  while ix < strlen(a:str)
    let out = out . Nr2Hex(char2nr(a:str[ix]))
    let ix = ix + 1
  endwhile
  return out
endfunc

"¥¹¥Æ¡¼¥¿¥¹¥é¥¤¥ó¤ËÊ¸»ú¥³¡¼¥É¤È²þ¹ÔÊ¸»ú¤òÉ½¼¨¤¹¤ë
" set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']['.&ft.']'}\ %F%=%l,%c%V%8P
if winwidth(0) >= 120
  set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %F%=[%{GetB()}]\ %l,%c%V%8P
else
  set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %f%=[%{GetB()}]\ %l,%c%V%8P
endif

"set statusline=%{GetB()}

" ¥³¥Þ¥ó¥É¥é¥¤¥óÊä´°¤¹¤ë¤È¤­¤Ë¶¯²½¤µ¤ì¤¿¤â¤Î¤ò»È¤¦(»²¾È :help wildmenu)
" set wildmenu
" ¥³¥Þ¥ó¥É¥é¥¤¥óÊä´Ö¤ò¥·¥§¥ë¤Ã¤Ý¤¯
set wildmode=list:longest
" ¥Ð¥Ã¥Õ¥¡¤¬ÊÔ½¸Ãæ¤Ç¤â¤½¤ÎÂ¾¤Î¥Õ¥¡¥¤¥ë¤ò³«¤±¤ë¤è¤¦¤Ë
set hidden
" ³°Éô¤Î¥¨¥Ç¥£¥¿¤ÇÊÔ½¸Ãæ¤Î¥Õ¥¡¥¤¥ë¤¬ÊÑ¹¹¤µ¤ì¤¿¤é¼«Æ°¤ÇÆÉ¤ßÄ¾¤¹
set autoread

" cvs,svn¤Î»þ¤ÏÊ¸»ú¥³¡¼¥É¤òeuc-jp¤ËÀßÄê
autocmd FileType cvs :set fileencoding=euc-jp
autocmd FileType svn :set fileencoding=utf-8

" set tags
if has("autochdir")
  set autochdir
  set tags=tags;
else
  set tags=./tags,./../tags,./*/tags,./../../tags,./../../../tags,./../../../../tags,./../../../../../tags
endif


" tags key map (C-z ¤ò C-t¤Ë,C-t¤ÏGNU/screen¤È¤«¤Ö¤ë)
map <C-z> <C-t>

" php¤ÇK¤Çhelp¤ò¤Ò¤¯
"autocmd BufNewFile,Bufread *.php,*.php3,*.php4 set keywordprg="help"

" php¤Ê¤éindent¥Õ¥¡¥¤¥ë¤Ï»È¤ï¤Ê¤¤
"autocmd FileType php :filetype indent off

" %¥Þ¥Ã¥Á¤Çruby¤Î¥¯¥é¥¹¤ä¥á¥½¥Ã¥É¤¬ÂÐ±þ¤¹¤ë¤è¤¦¤Ë¤¹¤ë
" autocmd FileType ruby :source ~/.vim/ftplugin/ruby-matchit.vim

" ¼­½ñ¥Õ¥¡¥¤¥ë¤«¤é¤ÎÃ±¸ìÊä´Ö
:set complete+=k

" C-]¤Çtj¤ÈÆ±Åù¤Î¸ú²Ì
nmap <C-]> g<C-]>

" ye¤Ç¤½¤Î¥«¡¼¥½¥ë°ÌÃÖ¤Ë¤¢¤ëÃ±¸ì¤ò¥ì¥¸¥¹¥¿¤ËÄÉ²Ã
nmap ye :let @"=expand("<cword>")<CR>

"set minibfexp
let g:miniBufExplMapWindowNavVim=1 "hjkl¤Ç°ÜÆ°
let g:miniBufExplSplitBelow=0  " Put new window above
let g:miniBufExplMapWindowNavArrows=1
let g:miniBufExplMapCTabSwitchBufs=1
let g:miniBufExplModSelTarget=1 
let g:miniBufExplSplitToEdge=1

" CD.vim example:// ¤ÏÅ¬ÍÑ¤·¤Ê¤¤
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

" howm
"set runtimepath+=~/.vim/howm_vim

"im_custom
"if has('im_custom/canna')
" set imoptions=canna
" set noimcmdline
" set iminsert=0
" set imsearch=0
" inoremap :set iminsert=0
" inoremap :set imsearch=0
"" <C-i>¤Ç¤Î¥¤¥ó¥µ¡¼¥È¥â¡¼¥É¤ËÆþ¤Ã¤¿¤È¤­¤ÏÆüËÜ¸ìÆþÎÏOn
"  nmap <C-i> :set iminsert=2<CR>i
"" imap <ESC> <ESC>:set iminsert=0<CR>
"endif

" insert mode»þ¤Ëc-j¤ÇÈ´¤±¤ë
" imap <C-j> <esc>

" Taglist
" nnoremap <silent> <C-,> :Tlist<CR>
"nnoremap <C-q> :Tlist<CR>
"nnoremap <silent> <C-.> :TlistClose<CR>

" savevers.vim(backup)
"set backup
"set patchmode=.clean 
"set backupdir=~/.backup_vim
"let savevers_types = "*"
"let savevers_dirs = &backupdir

" command mode »þ tcshÉ÷¤Î¥­¡¼¥Ð¥¤¥ó¥É¤Ë
cmap <C-A> <Home>
cmap <C-F> <Right>
cmap <C-B> <Left>
cmap <C-D> <Delete>
cmap <Esc>b <S-Left>
cmap <Esc>f <S-Right>
cmap <C-S> <Up>

"É½¼¨¹ÔÃ±°Ì¤Ç¹Ô°ÜÆ°¤¹¤ë
nmap j gj
nmap k gk
vmap j gj
vmap k gk

"¥Õ¥ì¡¼¥à¥µ¥¤¥º¤òÂÕÂÆ¤ËÊÑ¹¹¤¹¤ë
map <kPlus> <C-W>+
map <kMinus> <C-W>-

" Á°²ó½ªÎ»¤·¤¿¥«¡¼¥½¥ë¹Ô¤Ë°ÜÆ°
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" closetab C-_¤Ç¥¿¥°¤ò¤È¤¸¤ë
"let g:closetag_html_style=1
"source ~/.vim/scripts/closetag.vim 

",e ¤Ç¤½¤Î¥³¥Þ¥ó¥É¤ò¼Â¹Ô
nmap ,e :execute '!' &ft ' %'<CR>
"nmap ,e :execute 'set makeprg=' . expand(&ft) . '\ ' . expand('%')<CR>:make<CR>

" phpdoc
let g:foo_DefineAutoCommands = 1

" MiniBufExplorer ¤Ç GNU screen like¤Ê¥­¡¼¥Ð¥¤¥ó¥É
let mapleader = "" 
"nnoremap <Leader>f :last<CR>
"nnoremap <Leader><C-f> :last<CR>
nmap <Space> :MBEbn<CR>
nmap <F3> :MBEbp<CR>
nmap <F4> :MBEbn<CR>
nnoremap <Leader><Space> :MBEbn<CR>
nnoremap <Leader>n       :MBEbn<CR>
nnoremap <Leader><C-n>   :MBEbn<CR>
nnoremap <Leader>p       :MBEbp<CR>
nnoremap <Leader><C-p>   :MBEbp<CR>
nnoremap <Leader>c       :new<CR>
nnoremap <Leader><C-c>   :new<CR>
nnoremap <Leader>k       :bd<CR>
nnoremap <Leader><C-k>   :bd<CR>
nnoremap <Leader>s       :IncBufSwitch<CR>
nnoremap <Leader><C-s>   :IncBufSwitch<CR>
nnoremap <Leader><Tab>   :wincmd w<CR>
nnoremap <Leader>Q       :only<CR>
nnoremap <Leader>w       :ls<CR>
nnoremap <Leader><C-w>   :ls<CR>
nnoremap <Leader>a       :e #<CR>
nnoremap <Leader><C-a>   :e #<CR>
nnoremap <Leader>"       :BufExp<CR>
nnoremap <Leader>1   :e #1<CR>
nnoremap <Leader>2   :e #2<CR>
nnoremap <Leader>3   :e #3<CR>
nnoremap <Leader>4   :e #4<CR>
nnoremap <Leader>5   :e #5<CR>
nnoremap <Leader>6   :e #6<CR>
nnoremap <Leader>7   :e #7<CR>
nnoremap <Leader>8   :e #8<CR>
nnoremap <Leader>9   :e #9<CR>

nnoremap ,<Space> :MBEbn<CR>
nnoremap ,n       :MBEbn<CR>
nnoremap ,<C-n>   :MBEbn<CR>
"nnoremap ,p       :MBEbp<CR>
"nnoremap ,<C-p>   :MBEbp<CR>
nnoremap ,c       :new<CR>
nnoremap ,<C-c>   :new<CR>
nnoremap ,k       :bd<CR>
nnoremap ,<C-k>   :bd<CR>
nnoremap ,s       :IncBufSwitch<CR>
nnoremap ,<C-s>   :IncBufSwitch<CR>
nnoremap ,<Tab>   :wincmd w<CR>
nnoremap ,Q       :only<CR>
nnoremap ,w       :ls<CR>
nnoremap ,<C-w>   :ls<CR>
nnoremap ,a       :e #<CR>
nnoremap ,<C-a>   :e #<CR>
nnoremap ,"       :BufExp<CR>
nnoremap ,1   :e #1<CR>
nnoremap ,2   :e #2<CR>
nnoremap ,3   :e #3<CR>
nnoremap ,4   :e #4<CR>
nnoremap ,5   :e #5<CR>
nnoremap ,6   :e #6<CR>
nnoremap ,7   :e #7<CR>
nnoremap ,8   :e #8<CR>
nnoremap ,9   :e #9<CR>
" TaglistÍÑ
nnoremap <Leader>l       :Tlist<CR>
nnoremap <Leader><C-l>       :Tlist<CR>
nnoremap <Leader>o       :TlistClose<CR>
nnoremap <Leader><C-o>       :TlistClose<CR>

let mapleader = '\' 

" buf°ÜÆ°
"nmap <c-n>  :MBEbn<CR>
"nmap <c-p>  :MBEbp<CR> 

" ¤¤¤í¤¤¤í°Ï¤à¤è
"fun! Quote(quote)
"  normal mz
"  exe 's/\(\k*\%#\k*\)/' . a:quote . '\1' . a:quote . '/'
"  normal `zl
"endfun
"
"fun! UnQuote()
"  normal mz
""  exe 's/["' . "'" . ']\(\k*\%#\k*\)[' . "'" . '"]/\1/'
"  exe 's/\(["' . "'" . ']\)\(\k*\%#\k*\)\1/\2/'
"  normal `z
"endfun

nnoremap <silent> ,q" :call Quote('"')<CR>
nnoremap <silent> ,q' :call Quote("'")<CR>
nnoremap <silent> ,qd :call UnQuote()<CR>

"" 'quote' a word 
"nnoremap ,q' :silent! normal mpea'<esc>bi'<esc>`pl 
"" double "quote" a word 
"nnoremap ,q" :silent! normal mpea"<esc>bi"<esc>`pl 
"nnoremap ,q( :silent! normal mpea)<esc>bi(<esc>`pl 
"nnoremap ,q[ :silent! normal mpea]<esc>bi[<esc>`pl 
"nnoremap ,q{ :silent! normal mpea}<esc>bi{<esc>`pl 
"" remove quotes from a word 
"nnoremap ,qd :silent! normal mpeld bhd `ph<CR>


" ¸½ºß¹Ô¤òhighlight
" set updatetime=1
" autocmd CursorHold * :match Search /^.*\%#.*$

" code2html
let html_use_css = 1

" ¥Ú¡¼¥¹¥È»þ¤Ëautoindent¤òÌµ¸ú¤Ë
"set paste

" SeeTab
let g:SeeTabCtermFG="black"
let g:SeeTabCtermBG="red" 

" netrw-ftp
let g:netrw_ftp_cmd="netkit-ftp"

" netrw-http
let g:netrw_http_cmd="wget -q -O"

" mru.vim
" MRU ¤Ï MiniBufExplorer ¤ÈÁêÀ­¤¬¤ï¤ë¤¤¤¿¤á¤Ä¤«¤ï¤Ê¤¤
"let MRU_Max_Entries = 100
"let MRU_Use_Current_Window = 2
"let MRU_Window_Height=15

" YankRing.vim
nmap ,y :YRShow<CR>

" html escape function
:function HtmlEscape() 
silent s/&/\&amp;/eg 
silent s/</\&lt;/eg 
silent s/>/\&gt;/eg 
:endfunction 

:function HtmlUnEscape() 
silent s/&lt;/</eg 
silent s/&gt;/>/eg 
silent s/&amp;/\&/eg 
:endfunction 

" 16¿§
"set t_Co=16
"set t_Sf=[3%dm
"set t_Sb=[4%dm

" Êä´°¸õÊä¤Î¿§¤Å¤± for vim7
hi Pmenu ctermbg=8
hi PmenuSel ctermbg=12
hi PmenuSbar ctermbg=0

" changelog mode
if has("autocmd")
  autocmd FileType changelog map ,d ggi<CR><CR><ESC>kki<C-R>=strftime("%Y-%m-%d")<CR> gorou <hotchpotch@gmail.com><ESC>o<CR><TAB>* | map ,n ggo<CR><TAB>*
endif

if has("autocmd")
  autocmd FileType changelog map ,n :call InsertChangeLogEntry("gorou", "hotchpotch@gmail.com")<CR>a
endif

function! InsertChangeLogEntry(name, mail)
  if strpart(getline(1), 0, 10) == strftime("%Y-%m-%d")
    execute "normal ggo\<CR>\<TAB>*"
  else
    let s:header = strftime("%Y-%m-%d") . " " . a:name . " <" . a:mail . ">"
    execute "normal ggi\<CR>\<CR>\<ESC>kki" . s:header . "\<CR>\<CR>\<TAB>*"
  endif
endfunction

" encoding
nmap ,U :set encoding=utf-8<CR>
nmap ,E :set encoding=euc-jp<CR>
nmap ,S :set encoding=cp932<CR>

" rails
au BufNewFile,BufRead app/**/*.rhtml set fenc=utf-8
au BufNewFile,BufRead app/**/*.rb set fenc=utf-8

" cofs's fsync
au BufNewFile,BufRead /mnt/c/* set nofsync
au BufNewFile,BufRead *.tt set filetype=html

map ,t  <Esc>:!prove -vl %<CR>
map ,pt <Esc>:%! perltidy<CR>
map ,ptv <Esc>:'<,'>! perltidy<CR>
nmap ,td <Esc>:!tidy -iq -raw -m %<CR>

set ttimeout
set timeout
set ttimeoutlen=0
set timeoutlen=0
"map OA 
"map OB 
"map OC 
"map OD 
"imap OA 
"imap OB 
"imap OC 
"imap OD 

