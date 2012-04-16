set runtimepath=$VIM/.vim,$HOME/.vim,$VIMRUNTIME
"runtimepath
call pathogen#runtime_append_all_bundles()
filetype plugin on
"开启插件
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
colorscheme slate
"设置颜色主题
set helplang=cn
"帮助文档设置中文
set foldmethod=manual
"折叠
au FileType lua setlocal dictionary+=$VIMFILES/dict/wowlua.dict
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
autocmd VimEnter * NERDTree
"自动打开NERDTree

if has("win32")
	au GUIEnter * simalt ~x
	set guifont=Consolas:h10
	"设置双字节字体
	set guifontwide=Consolas:h10
	"设置单字节字体
	let $VIMFILES = $VIM.'/.vim'
	let $V = $VIM.'/.vimrc'
else
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
