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
set linespace=2
"设置行高
colorscheme slate
"设置颜色主题
"set lines=50 columns=128
"设置macvim窗口大小
set helplang=cn
"帮助文档设置中文
set foldmethod=manual
"折叠
au FileType lua setlocal dictionary+=~/.vim/dict/wowlua.dict
set complete-=k complete+=k
"字典
autocmd! bufwritepost .vimrc source ~/.vimrc
"定义了一个自动命令，每次写入.vimrc后，都会执行这个自动命令，source一次~/.vimrc文件
let mapleader = ","

if has("win32")
	set fileencoding=chinese
	au GUIEnter * simalt ~x
	set guifont=Courier\ New:h10
	"设置双字节字体
	set guifontwide=Courier\ New:h10
	"设置单字节字体
else
	set fileencoding=utf-8
	set guifont=Courier:h14
	"设置双字节字体
	set guifontwide=Courier:h14
	"设置单字节字体
endif
"解决菜单乱码   
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim