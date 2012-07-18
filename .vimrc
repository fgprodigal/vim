set runtimepath=$VIM/.vim,$HOME/.vim,$VIMRUNTIME,$VIM/.vim/after,$HOME/.vim/after
"runtimepath
call pathogen#runtime_append_all_bundles()
filetype plugin on
filetype plugin indent on
"开启插件
set noswapfile
set nocompatible
"不兼容vi模式
set modelines=0
"不使用modelines
set number
"显示行号
syntax on
"语法高亮
set tabstop=4
"设置tap键为4个空格
set shiftwidth=4
"设置当行之间交错时使用4个空格， << 和 >> 命令移动时的宽度为 4
set softtabstop=4
"使得按退格键时可以一次删掉 4 个空格
set expandtab
"设置缩进长度
set showmatch
"设置匹配模式 显示括号对应
set ruler
"打开状态栏标尺
set incsearch
set hlsearch
"实时显示搜索结果
set scrolloff=3
"当光标与顶部距离为三行时发生翻滚，且翻滚后光标与底部相距三行
set autoindent
"自动对齐方式
set smartindent
"智能对齐方式
set showmode
"显示当前模式
set showcmd
"在窗口右下角显示完整命令已输入部分
set hidden
"允许在有未保存的修改时切换缓冲区，此时的修改由vim负责保存
set wildmenu
"启用文本模式的菜单
set wildmode=list:longest
"增强模式打开列表
set visualbell
"可视化铃声
set cursorline
"高亮光标所在行
set ttyfast
"设置快速终端
set backspace=indent,eol,start
"设置backspace的工作方式 不兼容vi
set laststatus=2
"总是显示状态栏
set encoding=utf-8
"选择编码
set langmenu=zh_CN.UTF-8
language messages zh_CN.utf-8
"避免windows下gvim菜单和系统提示乱码
set fileencodings=utf-8,chinese,latin-1   
"自动识别编码，正确显示中文
set wrap
"自动换行
set linespace=3
"设置行高
"colorscheme slate
colorscheme molokai
"设置颜色主题
set helplang=cn
"帮助文档设置中文
set foldmethod=manual
"折叠
au FileType php setlocal dictionary+=$VIMFILES/dict/php.dict
au FileType lua setlocal dictionary+=$VIMFILES/dict/wowlua.dict
au BufRead,BufNewFile *.js set ft=javascript syntax=jquery
au BufRead,BufNewFile *.aspx,*.asmx,*.ascx,*.master set ft=html syntax=aspnet
set complete-=k complete+=k
"字典
autocmd! bufwritepost .vimrc source $V
"每次写入.vimrc后，source一次~/.vimrc文件
let mapleader = ","
"mapleader
set ignorecase smartcase
"搜索时默认不区分大小写，只有搜索关键字中出现一个大字母时才区分大小写
set so=3
"光标在窗口上下边界时距离边界7行即开始滚屏
set fileencoding=utf-8
"编码
map <C-s> :w<CR>
imap <C-s> <C-o>:w<CR>
"保存快捷键
map <F6> :NERDTreeToggle<CR>
"NERDTree快捷键
set foldmethod=indent
"缩进作为折叠标识  
set foldlevel=100
"不自动折叠 
map <space> za
"空格折叠

if has("win32")
	au GUIEnter * simalt ~x
	set guifont=Consolas:h10
	"设置双字节字体
	set guifontwide=Consolas:h10
	"设置单字节字体
	let $VIMFILES = $VIM.'/.vim'
	let $V = $VIM.'/.vimrc'
	set shellslash
else
    au GUIEnter * set fullscreen
	set guifont=Courier:h14
	"设置双字节字体
	set guifontwide=Courier:h14
	"设置单字节字体
	let $VIMFILES = $HOME.'/.vim'
	let $V = $HOME.'/.vimrc'
endif
"解决菜单乱码   
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

"自动补全括号
inoremap ( <c-r>=OpenPair('(')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap { <c-r>=OpenPair('{')<CR>
inoremap } <c-r>=ClosePair('}')<CR>
inoremap [ <c-r>=OpenPair('[')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
" just for xml document, but need not for now.
"inoremap < <c-r>=OpenPair('<')<CR>
"inoremap > <c-r>=ClosePair('>')<CR>
function! OpenPair(char)
    let PAIRs = {
                \ '{' : '}',
                \ '[' : ']',
                \ '(' : ')',
                \ '<' : '>'
                \}
    if line('$')>2000
        let line = getline('.')

        let txt = strpart(line, col('.')-1)
    else
        let lines = getline(1,line('$'))
        let line=""
        for str in lines
            let line = line . str . "\n"
        endfor

        let blines = getline(line('.')-1, line("$"))
        let txt = strpart(getline("."), col('.')-1)
        for str in blines
            let txt = txt . str . "\n"
        endfor
    endif
    let oL = len(split(line, a:char, 1))-1
    let cL = len(split(line, PAIRs[a:char], 1))-1

    let ol = len(split(txt, a:char, 1))-1
    let cl = len(split(txt, PAIRs[a:char], 1))-1

    if oL>=cL || (oL<cL && ol>=cl)
        return a:char . PAIRs[a:char] . "\<Left>"
    else
        return a:char
    endif
endfunction
function! ClosePair(char)
    if getline('.')[col('.')-1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

inoremap ' <c-r>=CompleteQuote("'")<CR>
inoremap " <c-r>=CompleteQuote('"')<CR>
function! CompleteQuote(quote)
    let ql = len(split(getline('.'), a:quote, 1))-1
    let slen = len(split(strpart(getline("."), 0, col(".")-1), a:quote, 1))-1
    let elen = len(split(strpart(getline("."), col(".")-1), a:quote, 1))-1
    let isBefreQuote = getline('.')[col('.') - 1] == a:quote

    if '"'==a:quote && "vim"==&ft && 0==match(strpart(getline('.'), 0, col('.')-1), "^[\t ]*$")
        " for vim comment.
        return a:quote
    elseif "'"==a:quote && 0==match(getline('.')[col('.')-2], "[a-zA-Z0-9]")
        " for Name's Blog.
        return a:quote
    elseif (ql%2)==1
        " a:quote length is odd.
        return a:quote
    elseif ((slen%2)==1 && (elen%2)==1 && !isBefreQuote) || ((slen%2)==0 && (elen%2)==0)
        return a:quote . a:quote . "\<Left>"
    elseif isBefreQuote
        return "\<Right>"
    else
        return a:quote . a:quote . "\<Left>"
    endif
endfunction

let g:user_zen_expandabbr_key = '<c-return>'
let g:use_zen_complete_tag = 1
"设置zen coding为ctrl+return展开

function ShortTabLabel ()
    let bufnrlist = tabpagebuflist (v:lnum)
    let label = bufname (bufnrlist[tabpagewinnr (v:lnum) -1])
    let filename = fnamemodify (label, ':t')
    return filename
endfunction
set guitablabel=%{ShortTabLabel()}
"标签名

map <C-Right> :tabnext<CR>
map <C-Left>  :tabprevious<CR>
nmap <C-t> :tabnew<CR>
imap <C-t> <ESC>:tabnew<CR>
nmap <C-w> :tabclose<CR>
"标签快捷键
