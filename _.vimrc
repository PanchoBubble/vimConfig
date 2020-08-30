syntax on

set guicursor=
set noshowmatch
set relativenumber
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=50

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

set colorcolumn=80



function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction

call plug#begin('~/.vim/plugged')
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'

Plug 'morhetz/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'phanviet/vim-monokai-pro'
Plug 'vim-airline/vim-airline'
Plug 'flazz/vim-colorschemes'
Plug '/home/mpaulson/personal/vim-be-good'
Plug 'preservim/nerdtree'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" Clone repo and python3 install.py --all
Plug 'Valloric/YouCompleteMe'
Plug 'mjbrownie/YouCompleteMe', { 'do': function('BuildYCM') }

" Install silver search for this
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" HTML CLOSE TAG
Plug 'alvan/vim-closetag'

" CSS HEX color visualizer
Plug 'https://github.com/etdev/vim-hexcolor.git'

" React snippets
Plug 'epilande/vim-react-snippets'

" Ultisnips
Plug 'SirVer/ultisnips'
call plug#end()

set background=dark
colorscheme gruvbox

let g:NERDTreeWinPos = "right"
let g:NERDTreeWinSize=40
set completeopt-=preview

nnoremap <silent><c-s> :<c-u>update<cr>

let mapleader = ","
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"Search in dir for cursor word
map <leader>f :execute "Ag" expand("<cword>") <CR>
set wildignore+=**/node_modules/**,**/dist/**,**/*sql*/**


"Remove all trailing whitespace
nmap <leader>c :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

"Tree toggle off or open with current file location
function MyNerdToggle()
    if &filetype == 'nerdtree'
        :NERDTreeToggle
    else
        :NERDTreeFind
    endif
endfunction
"nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>n :call MyNerdToggle()<CR>

let NERDTreeShowHidden=1

autocmd BufNewFile *.html 0r ~/.vim/templates/html.skel


highlight ColorColumn ctermbg=125* guibg=LightMagenta

"""""""""""""""""""""""""""""""""""""""
""""""" Show unsaved changes """"""""""
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

map <leader>r :DiffSaved <CR>
"""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""
"""""""" GO TO PREV FILE """"""""""""""
nmap <leader>bb <C-^><cr>
"""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""
" move selected lines up one line
xnoremap <S-UP>  :m-2<CR>gv=gv

" move selected lines down one line
xnoremap <S-DOWN> :m'>+<CR>gv=gv
"""""""""""""""""""""""""""""""""""""""
