" @:  repeat last command
nmap <F1> :pyf ~/bin/vimdoc.py<CR>

set nocompatible
set term=xterm-256color
set t_Co=256
filetype plugin indent on
set number
syntax on
set incsearch
set hlsearch
set mouse=a
set nobackup
set nowritebackup
set clipboard=unnamedplus
set viminfo+=:10000
" statusline
"set noruler
"set laststatus=2
"set statusline=%F%m%r%h%w\ 
"set statusline+=%{fugitive#statusline()}\    

" show auto complete menus
set wildmenu
" make wildmenu behave like bash completion
set wildmode=list:longest,full

" auto expand tabs to spaces
set tabstop=2
au FileType python setl tabstop=4
au FileType make setl noexpandtab
set shiftwidth=2
set expandtab
" indent
"set autoindent
"set smartindent
runtime ftplugin/man.vim

let mapleader = ","
" define mappings following

" setting up vundle - the vim plugin bundler
" use :BundleInstall
if !isdirectory(expand("~/.vim/bundle/vundle"))
  !mkdir -p ~/.vim/bundle
  !git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
endif
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
"#######################################################
"Bundle 'https://github.com/davidhalter/jedi-vim'
"#######################################################
Bundle 'https://github.com/nvie/vim-flake8.git'
"#######################################################
Bundle 'https://github.com/tpope/vim-fugitive.git'
" diff to revision, branch, version     :Gdiff [<branch>|<revision>|~<number>|...]
"#######################################################
Bundle 'https://github.com/troydm/easybuffer.vim.git'
" # show buffer list
nmap <Leader>b :EasyBuffer<CR>
"#######################################################
Bundle 'https://github.com/vim-scripts/taglist.vim.git'
nmap <silent> <F2> :TlistToggle<CR>
let Tlist_Show_One_File = 1
"#######################################################
Bundle 'https://github.com/Lokaltog/vim-easymotion.git'
" helptext: start easymotion <Leader><Leader>w
"#######################################################
" normally,
"
" > cd ~/.vim/bundle/YouCompleteMe
" > ./install.sh --clang-completer
"
" should work. otherwise, try following to compile the sources
"
" > rm -rf ~/bin/ycm_build
" > mkdir -p ~/bin/ycm_build/llvm_root_dir
" > cd ~/bin/ycm_build/llvm_root_dir
" > wget -qO - http://llvm.org/releases/3.2/clang+llvm-3.2-x86-linux-ubuntu-12.04.tar.gz | tar xz --strip 1
" > wget -qO - http://llvm.org/releases/3.9.0/clang+llvm-3.9.0-x86_64-linux-gnu-ubuntu-16.04.tar.xJ | tar xz --strip 1
" > cd ~/bin/ycm_build
" > cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=~/ycm_build/llvm_root_dir ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
" > make
"
" no worries about the errors at the end of the compilation in conjunction with gmock
"
" to generate ycm_extra_conf, do
" > cd <projdir>
" > ~/bin/YCM-Generator/config_gen.py .
Bundle 'https://github.com/Valloric/YouCompleteMe.git'
"let g:ycm_confirm_extra_conf = 0
"#######################################################
Bundle 'https://github.com/tpope/vim-pathogen.git'
"#######################################################
Bundle 'https://github.com/scrooloose/syntastic.git'
"#######################################################
Bundle 'https://github.com/vim-scripts/L9.git'
"#######################################################
Bundle 'https://github.com/vim-scripts/a.vim.git'
map <Leader>s :A<CR>
"#######################################################
Bundle 'https://github.com/vim-scripts/FuzzyFinder.git'
map <Leader>t :FufBufferTag!<CR>
map <Leader>g :FufTag!<CR>
map <Leader>f :FufFile **/<CR>
autocmd FileType fuf inoremap <buffer> <Tab> <C-n>
"#######################################################
Bundle 'https://github.com/tomtom/tcomment_vim'
" toggle comments for single line   gcc
" toggle comments for visual line   gc
call tcomment#DefineType('htt', '# %s')
"#######################################################
" see :help snipMate-remap
" trigger snipmate and jump to next placeholder          <c-j>
" jump over placeholder without deleting default value   <TAB>
" list snippets                                          <c-r><TAB>
Bundle 'https://github.com/msanders/snipmate.vim.git'
" change triggering snippets as it overlaps with completion of YouCompleteMe
ino <silent> <c-j> <esc>a<c-r>=TriggerSnippet()<cr>
" add custom snippet search directory
let g:snippets_dir = "~/.vim/bundle/snipmate.vim/snippets, ~/.vim/snippets"
"#######################################################
Bundle 'https://github.com/vim-scripts/ShowMarks.git'
let showmarks_include="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
" set mark              <m><mark>
" jump to mark          <'><mark>
" hide mark             <Leader>mh
" delete marks          <Leader>ma
"
" # show all marks
map <Leader>m :marks<CR>
"#######################################################
" ack-grep has to be available on the system
Bundle 'https://github.com/mileszs/ack.vim.git'
let g:ackprg="ack-grep -H --nocolor --nogroup --column --follow"
" # grep for word under cursor
map <Leader>a :Ack<CR>
"#######################################################
Bundle "https://github.com/kien/ctrlp.vim.git"
let g:ctrlp_map = '<Leader>p'
let g:ctrlp_working_path_mode = 'c'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(swp|so|o)$',
  \ }
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_clear_cache_on_exit = 0
"#######################################################
Bundle "https://github.com/nanotech/jellybeans.vim"
"let g:jellybeans_background_color_256 = 0
"let g:jellybeans_use_lowcolor_black = 0
"let g:jellybeans_background_color = ""
autocmd ColorScheme * highlight Normal ctermbg=None
autocmd ColorScheme * highlight LineNr ctermbg=None
autocmd ColorScheme * highlight NonText ctermbg=None
colorscheme jellybeans
"#######################################################
Bundle "https://github.com/vim-scripts/gtags.vim"
"#######################################################
" show yank-stack     :Yanks
let g:yankstack_map_keys = 0
nmap <Leader>s <Plug>yankstack_substitute_newer_paste_
Bundle "https://github.com/maxbrunsfeld/vim-yankstack"
"#######################################################
nmap <silent> <F9> :GundoToggle<CR>
Bundle "https://github.com/sjl/gundo.vim"
"#######################################################
" tabular alignment :Tab /<delimiter>
Bundle "https://github.com/godlygeek/tabular"
"#######################################################

" # code formatting (http://llvm.org/apt)
au FileType c map <Leader>r :pyf ~/bin/clang-format.py<CR>
"au FileType python map <Leader>r :!autopep8 -i %<CR>:e<CR>
" pip install autopep8
" # use gq to clean up code
au FileType python setlocal formatprg=autopep8\ -aa\ --indent-size\ 0\ -

" # highlight word under cursor
map <Leader>h :let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<C-M>

"set cscopetag
set tags=tags;/
" create ctags and cscope database
function CreateMeta(lang)
  if filereadable("/tmp/.meta")
    echom "meta creation running..."
  else
    echom "creating meta data..."
    exec ":!{ touch /tmp/.meta; create-meta.sh " . a:lang . " > /dev/null; rm /tmp/.meta; } &"
  endif
endfunction

" add cscope database
function CscopeAdd()
  cs add cscope.out
  cs reset
endfunction

nmap <silent> <F3> :exec 'tag '.expand('<cword>')<CR>
"</docu>
" The following maps all invoke one of the following cscope search types:
"   's'   symbol:   find all references to the token under cursor
"   'g'   global:   find global definition(s) of the token under cursor
"   'c'   calls:    find all calls to the function name under cursor
"   't'   text:     find all instances of the text under cursor
"   'e'   egrep:    egrep search for the word under cursor
"   'f'   file:     open the filename under cursor
"   'i'   includes: find files that include the filename under cursor
"   'd'   called:   find functions that function under cursor calls
"
nmap <silent> <F4> :call CscopeAdd()<CR>:cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <silent> <F5> :call CscopeAdd()<CR>:cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <silent> <F6> :call CscopeAdd()<CR>:cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <silent> <F7> :call CscopeAdd()<CR>:cs find t <C-R>=expand("<cword>")<CR><CR>

" meta data is genereated via external scripts
au FileType python nmap <F12> :call CreateMeta("python")<CR><CR>
au FileType c nmap <F12> :call CreateMeta("C")<CR><CR>

map <down> <nop>
map <left> <nop>
map <right> <nop>
map <up> <nop>   
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>
imap <up> <nop> 

