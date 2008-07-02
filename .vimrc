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
  "���Υե����륿���פˤ��碌������ǥ�Ȥ����Ѥ���
  filetype indent on
  " ������ft�Ǥϥ���ǥ�Ȥ�̵����
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

" ������������
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

set modelines=0

"����ǥ�Ȥϥ��ޡ��ȥ���ǥ��
set smartindent
"����ʸ���󤬾�ʸ���ξ�����ʸ����ʸ������̤ʤ���������
set ignorecase
"����ʸ�������ʸ�����ޤޤ�Ƥ�����϶��̤��Ƹ�������
set smartcase
"�������˺Ǹ�ޤǹԤä���ǽ�����
set wrapscan
"����ʸ�������ϻ��˽缡�о�ʸ����˥ҥåȤ����ʤ�
set noincsearch
"���֤κ�¦�˥�������ɽ��
"set listchars=tab:\\ 
set nolist
"������Υ��ޥ�ɤ򥹥ơ�������ɽ������
set showcmd
"������ϻ����б������̤�ɽ��
set showmatch
"�������ʸ����Υϥ��饤�Ȥ�ͭ���ˤ��ʤ�
set nohlsearch
"���ơ������饤�����ɽ��
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

"���ơ������饤���ʸ�������ɤȲ���ʸ����ɽ������
" set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']['.&ft.']'}\ %F%=%l,%c%V%8P
if winwidth(0) >= 120
  set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %F%=[%{GetB()}]\ %l,%c%V%8P
else
  set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %f%=[%{GetB()}]\ %l,%c%V%8P
endif

"set statusline=%{GetB()}

" ���ޥ�ɥ饤���䴰����Ȥ��˶������줿��Τ�Ȥ�(���� :help wildmenu)
" set wildmenu
" ���ޥ�ɥ饤����֤򥷥���äݤ�
set wildmode=list:longest
" �Хåե����Խ���Ǥ⤽��¾�Υե�����򳫤���褦��
set hidden
" �����Υ��ǥ������Խ���Υե����뤬�ѹ����줿�鼫ư���ɤ�ľ��
set autoread

" cvs,svn�λ���ʸ�������ɤ�euc-jp������
autocmd FileType cvs :set fileencoding=euc-jp
autocmd FileType svn :set fileencoding=utf-8

" set tags
if has("autochdir")
  set autochdir
  set tags=tags;
else
  set tags=./tags,./../tags,./*/tags,./../../tags,./../../../tags,./../../../../tags,./../../../../../tags
endif


" tags key map (C-z �� C-t��,C-t��GNU/screen�Ȥ��֤�)
map <C-z> <C-t>

" php��K��help��Ҥ�
"autocmd BufNewFile,Bufread *.php,*.php3,*.php4 set keywordprg="help"

" php�ʤ�indent�ե�����ϻȤ�ʤ�
"autocmd FileType php :filetype indent off

" %�ޥå���ruby�Υ��饹��᥽�åɤ��б�����褦�ˤ���
" autocmd FileType ruby :source ~/.vim/ftplugin/ruby-matchit.vim

" ����ե����뤫���ñ�����
:set complete+=k

" C-]��tj��Ʊ���θ���
nmap <C-]> g<C-]>

" ye�Ǥ��Υ���������֤ˤ���ñ���쥸�������ɲ�
nmap ye :let @"=expand("<cword>")<CR>

"set minibfexp
let g:miniBufExplMapWindowNavVim=1 "hjkl�ǰ�ư
let g:miniBufExplSplitBelow=0  " Put new window above
let g:miniBufExplMapWindowNavArrows=1
let g:miniBufExplMapCTabSwitchBufs=1
let g:miniBufExplModSelTarget=1 
let g:miniBufExplSplitToEdge=1

" CD.vim example:// ��Ŭ�Ѥ��ʤ�
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
"" <C-i>�ǤΥ��󥵡��ȥ⡼�ɤ����ä��Ȥ������ܸ�����On
"  nmap <C-i> :set iminsert=2<CR>i
"" imap <ESC> <ESC>:set iminsert=0<CR>
"endif

" insert mode����c-j��ȴ����
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

" command mode �� tcsh���Υ����Х���ɤ�
cmap <C-A> <Home>
cmap <C-F> <Right>
cmap <C-B> <Left>
cmap <C-D> <Delete>
cmap <Esc>b <S-Left>
cmap <Esc>f <S-Right>
cmap <C-S> <Up>

"ɽ����ñ�̤ǹ԰�ư����
nmap j gj
nmap k gk
vmap j gj
vmap k gk

"�ե졼�ॵ���������Ƥ��ѹ�����
map <kPlus> <C-W>+
map <kMinus> <C-W>-

" ����λ������������Ԥ˰�ư
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" closetab C-_�ǥ�����Ȥ���
"let g:closetag_html_style=1
"source ~/.vim/scripts/closetag.vim 

",e �Ǥ��Υ��ޥ�ɤ�¹�
nmap ,e :execute '!' &ft ' %'<CR>
"nmap ,e :execute 'set makeprg=' . expand(&ft) . '\ ' . expand('%')<CR>:make<CR>

" phpdoc
let g:foo_DefineAutoCommands = 1

" MiniBufExplorer �� GNU screen like�ʥ����Х����
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
" Taglist��
nnoremap <Leader>l       :Tlist<CR>
nnoremap <Leader><C-l>       :Tlist<CR>
nnoremap <Leader>o       :TlistClose<CR>
nnoremap <Leader><C-o>       :TlistClose<CR>

let mapleader = '\' 

" buf��ư
"nmap <c-n>  :MBEbn<CR>
"nmap <c-p>  :MBEbp<CR> 

" ������Ϥ��
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


" ���߹Ԥ�highlight
" set updatetime=1
" autocmd CursorHold * :match Search /^.*\%#.*$

" code2html
let html_use_css = 1

" �ڡ����Ȼ���autoindent��̵����
"set paste

" SeeTab
let g:SeeTabCtermFG="black"
let g:SeeTabCtermBG="red" 

" netrw-ftp
let g:netrw_ftp_cmd="netkit-ftp"

" netrw-http
let g:netrw_http_cmd="wget -q -O"

" mru.vim
" MRU �� MiniBufExplorer ����������뤤����Ĥ���ʤ�
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

" 16��
"set t_Co=16
"set t_Sf=[3%dm
"set t_Sb=[4%dm

" �䴰����ο��Ť� for vim7
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

