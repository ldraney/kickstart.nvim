
"use alt-/ to search within a highlighted visual field
vnoremap <M-/> <Esc>/\%V
"
"Go to last position in file (also loads folding)
autocmd BufWinLeave * silent! mkview
autocmd BufWinEnter * silent! loadview

" current directory to match netrw browsing
let g:netrw_keepdir= 0

"give syntax highlighting to sh files with zsh syntax highlighting
au BufRead,BufNewFile *.sh setfiletype zsh
set syn=sh

call plug#begin()

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

" relative and absolute line numbers
"Plug 'sitiom/nvim-numbertoggle'

"format json files
Plug 'XadillaX/json-formatter.vim'
"must also run:
"npm install -g jjson
"usage:
":JSONFormatter"

Plug 'github/copilot.vim'
"must also run:
":Copilot setup
"# Go to my Microsoft Edge bookmark named "Copilot Login"
":Copilot enable

"format terraform file with a :TerraformFmt ex command
"Also include TerraformSyntax highlighting
Plug 'hashivim/vim-terraform'

"bash script syntax highlighting
"Plug 'godlygeek/tabular'
"Plug 'arzg/vim-sh'

" Telescope stuff
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.6' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'ThePrimeagen/harpoon'
"Start using vim with googgle docs :)))
"Plug 'aadv1k/gdoc.vim', {'do': './install.py'}

"LSP stuff
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'neovim/nvim-lspconfig'

" AUTOCOMPLETE STUFF?
"Plug 'hrsh7th/nvim-cmp'
"Plug 'williamboman/nvim-lsp-installer'
"Plug 'tami5/lspsaga.nvim'
"Plug 'simrat39/symbols-outline.nvim'
"Plug 'hrsh7th/nvim-cmp'
"Plug 'hrsh7th/cmp-nvim-lsp'
"Plug 'saadparwaiz1/cmp_luasnip'
"Plug 'L3MON4D3/LuaSnip'
"Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
"Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
"Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
"Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }
"
"Debugger
"Plug 'puremourning/vimspector'

" AESTHETICS
Plug 'gruvbox-community/gruvbox'

"highlighting plugins that may be useful when I'm a senior dev
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/rainbow_parentheses.vim'

" FILE FORMATTING AND VISUAL HELPS

"smooth scrolling
Plug 'psliwka/vim-smoothie'

"search blink
Plug 'ivyl/vim-bling'

Plug 'antoinemadec/FixCursorHold.nvim'
"
"Super handy.  Shows the current function or class when scrolling down
Plug 'wellle/context.vim'

"useful for aligning dictionaries or other declarations
"Plug 'junegunn/vim-easy-align'

"Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'lukas-reineke/indent-blankline.nvim', { 'tag': 'v3.3.10' }

" Automatic numbering and bullet points for new lines
"Plug 'dkarter/bullets.vim'

" FUNCTIONALITIES
Plug 'tpope/vim-repeat'
"
Plug 'ctrlpvim/ctrlp.vim'
Plug 'preservim/nerdcommenter'
Plug 'svermeulen/vim-easyclip' "Fixes the clipboard functionality

"Useful vim surround Keys:
"1. cs"'  to change the outer characters of current sentence
"2. ds" to delete outer characters entirely
"3. ysiw" to "surround current" word with "
"4. yssb or yss( to wrap entire line with parenthesis
"5. S" in visual mode will surround with quotes
Plug 'tpope/vim-surround'

"shows an outline of imports, functions, and classes by scope
Plug 'majutsushi/tagbar'

"  git assistant
Plug 'tpope/vim-fugitive'

"Plug 'ryanoasis/vim-devicons'
"Plug 'kyazdani42/nvim-web-devicons'

"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'kshenoy/vim-signature'

call plug#end()

let g:NERDSpaceDelims = 1

" Enable automatic formatting of Terraform files on save
let g:terraform_fmt_on_save = 1

"system clipboard on wsl2
if system('uname -r') =~ "microsoft"
  augroup Yank
  autocmd!
  autocmd TextYankPost * :call system('/mnt/c/windows/system32/clip.exe ',@")
  augroup END
endif

" EasyClip settings
nmap M <Plug>MoveMotionEndOfLinePlug
nnoremap gm m



" treesitter syntax highlighting
lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true, -- Enable Tree-sitter based highlighting
  },
  ensure_installed = {"yaml"}, -- Ensure YAML syntax is supported for GitHub Actions
}
EOF



"set relativenumber

"  SETS
"set startdir=$NVIM_PWD

"set number
"set relativenumber

"set statusline=%!MyStatusLine()
"function! MyStatusLine()
set statusline+=%F
let g:netrw_keepdir= 0

" this should open help in a vertical split
set splitright

"FOLDING
set viminfo+=n~/.vim/viminfo
set foldenable
set foldmethod=manual

function! ToggleAllFolds()
    " Check if there are any closed folds
    if foldclosed('.') != -1
        " If there are, open all folds
        normal zR
    else
        " Otherwise, close all folds
        normal zM
    endif
endfunction

nnoremap ZA :call ToggleAllFolds()<CR>

" Fold remaps
"nnoremap ZA zR
nnoremap ZD zE
nnoremap zG VGo:fold<CR>
nnoremap zgg Vgg:fold<CR>
"set foldmarker=BEGIN_FOLD,END_FOLD
" Managing Manual Folds:
"za: Toggle fold under the cursor.
"zR: Open all folds.
"zM: Close all folds.
"zo: Open fold under the cursor.
"zc: Close fold under the cursor.
"zd: Delete the fold at the cursor.
"zE: Erase all folds in the file.
"zj: Move to the start of the next fold.
"zk: Move to the end of the previous fold.

set formatoptions-=cro
set nopaste
"set splitright
"set tabline
set conceallevel=0
set autochdir
set ignorecase
set smartcase
set tabstop=4 softtabstop=4 shiftwidth=2
set mouse=a
set indentexpr=''
"set expandtab
"set autoindent
"set smarttab
"set incsearch ignorecase smartcase hlsearch
set nohlsearch
"set hlsearch!
set wildmode=longest,list,full wildmenu
set ruler laststatus=2 showcmd showmode
set list listchars=trail:»,tab:»-
set fillchars+=vert:\ 
set wrap breakindent
set encoding=utf-8
set textwidth=0
set nohidden
set title
set undodir=~/.vim/undodir  "I need to set up this directory
set undofile
set incsearch
set backspace
set autoread
set scrolloff=10
set colorcolumn=120
set clipboard=unnamed,unnamedplus
""" Coloring
set splitbelow
set splitright

set nocindent
set showbreak=>>
"set nosmartindent
"set noautoindent
"set indentexpr=
"filetype indent off
"filetype plugin indent off

lua require ('init')
let g:coq_settings = { 'auto_start': v:true }

"return to previous place in buffer

""" Main Configurations
"filetype plugin indent on

" Functions and autocmds to run whenever changing colorschemes
function! TransparentBackground()
    highlight Normal guibg=NONE ctermbg=NONE
    highlight LineNr guibg=NONE ctermbg=NONE
    set fillchars+=vert:\│
    highlight VertSplit gui=NONE guibg=NONE guifg=#444444 cterm=NONE ctermbg=NONE ctermfg=gray
endfunction

autocmd ColorScheme * call TransparentBackground() " uncomment if you are using a translucent terminal and you want nvim to use that

set relativenumber

"nnoremap <leader>th :lua requre('tmux_split_even_horizontal').tmux_split_even_horizontal()<CR>
"nnoremap <leader>s :lua require('toggle_rel_abs_numbers').toggle_rel_abs_numbers()<CR>

"function! ToggleLineNumbers()
  "if &relativenumber
    "set norelativenumber
	"set number
  "else
    "set relativenumber
  "endif
"endfunction

nnoremap <leader><leader>n :lua require('toggle_rel_abs_numbers').toggle_line_numbers()<CR>

" Main Coloring Configurations
syntax on
color gruvbox


" Enable True Color Support (ensure you're using a 256-color enabled $TERM, e.g. xterm-256color)
set termguicolors
"
"CURSOR SETTINGS
"cursor settings MUST COME AFTER set TERMGUICOLORS
"https://github.com/neovim/neovim/wiki/FAQ#nvim-shows-weird-symbols-2-q-when-changing-modes
"highlight Cursor guifg=blue guibg=blue
"set guicursor=i:block-Cursor-blinkon1
"set guicursor=i:hor
highlight Cursor guifg=blue guibg=blue
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul

" REMAPS
nnoremap <leader>gf :Telescope git_files<cr>

"Harpoon
nnoremap <leader>pf :lua require("harpoon.mark").add_file()<cr>
nnoremap <leader>pf :lua require("harpoon.ui").toggle_quick_menu()
nnoremap <leader>pf :lua require("harpoon.ui").toggle_quick_menu()


"set timeout timeoutlen=1000 ttimeoutlen=100
"inoremap <C-c> <Esc>:w<CR>
"
"save with ctrl s
nnoremap <C-s> <C-c>:mkview<CR><C-c>:w<CR>
inoremap <C-c> <Esc><right>
inoremap <Esc> <Esc><right>


"netrw to automatically change working directory
au FileType netrw nmap <buffer> <leader>% mt:!tmux split-window -h;tmux select-layout even-horizontal<CR>
au FileType netrw nmap <buffer> <leader>z mt:!tmux split-window -h; tmux select-pane -L; tmux kill-pane; tmux select-layout even-horizontal<CR>
"open current NETRW directory in a new tab
nnoremap <leader>z mt:!tmux split-window -h; tmux select-pane -L; tmux kill-pane; tmux select-layout even-horizontal<CR>
"open current NETRW directory in a new tab
nnoremap <leader>% mt:!tmux split-window -h;tmux select-layout even-horizontal<CR>

"ends up going to the same directory but doesn't open a file
"function! OpenInTmuxPane()
    "" Get the full path of the current file
    ""let l:filepath = netrw#LocalBrowseCheck("")
	""echo l:filepath
	"let l:filepath = expand('%:p')

    "" Prepare the tmux command
    "let l:tmux_command = "tmux split-window -h 'nvim " . l:filepath . "'"

    "" Call the command
    "call system(l:tmux_command)
"endfunction

function! OpenInTmuxPane()
    " Get the current directory from the netrw buffer
    let l:current_dir = b:netrw_curdir

    " Get the name of the file under the cursor
    let l:filename = expand('<cfile>')

    " Combine the directory and filename to get the full path
    let l:filepath = l:current_dir . '/' . l:filename

    " Prepare the tmux command
    let l:tmux_command = "tmux split-window -h 'nvim " . l:filepath . "'"

    " Call the command
    call system(l:tmux_command)
endfunction

nnoremap <leader>4 :call OpenInTmuxPane()<CR>

"netrw copy a file
au FileType netrw nmap <buffer> <leader>yp mt:!cp -r <C-R><C-F> ./<C-R><C-F>
"netrw delete under cursor
au FileType netrw nmap <buffer> <leader>x mt:!rm -rf <C-R><C-F><CR><CR>
"netrw mkdir command
au FileType netrw nmap <buffer> <leader>mkdir mt:!mkdir -p 

":!tmux split-window -h; tmux select-pane -L; tmux kill-pane; tmux select-layout even-horizontal<CR>
"OVERCOMING ANNOYING LITTLE VIM THINGS
"nnoremap <CR> <CR><left>
"inoremap <CR> <CR><left>
"nnoremap o o<left>

"highlight search settings
"highlight link Searchlight Incsearch
"hi Search guibg=white guifg=green
"hi Search cterm=NONE ctermfg=grey ctermbg=blue
""" PLUGIN CONFIGURATIONS

"let ctrlp search for hidden files and directories
let g:ctrlp_show_hidden = 1

" Neovim :Terminal
tmap <Esc> <C-\><C-n>
"tmap <C-w> <Esc><C-w>
"tmap <C-d> <Esc>:q<CR>

"delete
"I don't know what this does...
"autocmd BufWinEnter,WinEnter term://* startinsert
"autocmd BufLeave term://* stopinsert

" vim-pydocstring
let g:pydocstring_doq_path = '~/.config/nvim/env/bin/doq'

" delete
" Supertab
"let g:SuperTabDefaultCompletionType = "<C-n>"

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" indentLine
let g:indentLine_char = '▏'
let g:indentLine_defaultGroup = 'NonText'
" Disable indentLine from concealing json and markdown syntax (e.g. ```)
"let g:vim_json_syntax_conceal = 0
"let g:vim_markdown_conceal = 0
"let g:vim_markdown_conceal_code_blocks = 0

" TagBar
let g:tagbar_width = 40

" Limelight
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_guifg = 'gray'
nmap <Leader>l :Limelight!!<CR>
xmap <Leader>l :Limelight!!<CR>
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
" Startify
"let g:startify_fortune_use_unicode = 1

"" Startify + NERDTree on start when no file is specified
"let &tags = expand("%:p")

"COC VIM START

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  "" Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
"inoremap <silent><expr> <TAB>
      "\ pumvisible() ? "\<C-n>" :
      "\ <SID>check_back_space() ? "\<TAB>" :
      "\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"function! s:check_back_space() abort
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

" Use <c-space> to trigger completion.
"if has('nvim')
  ""inoremap <silent><expr> <c-space> coc#refresh()
"else
  ""inoremap <silent><expr> <c-@> coc#refresh()
"endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
			      ""\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
"nnoremap <silent> K :call <SID>show_documentation()<CR>
"function! s:show_documentation()
  "if (index(['vim','help'], &filetype) >= 0)
    "execute 'h '.expand('<cword>')
  "elseif (coc#rpc#ready())
    "call CocActionAsync('doHover')
  "else
    "execute '!' . &keywordprg . " " . expand('<cword>')
  "endif
"endfunction

" Highlight the symbol and its references when holding the cursor.
"autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
"nnoremap <leader>9 <Plug>(coc-rename)
"nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
"xmap <leader>=  <Plug>(coc-format-selected)
"nmap <leader>=  <Plug>(coc-format-selected)

"augroup mygroup
  "autocmd!
  """ Setup formatexpr specified filetype(s).
  "autocmd FileType typescript,json,python,yaml setl formatexpr=CocAction('formatSelected')
  """ Update signature help on jump placeholder.
  "autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"augroup end

"let g:python3_host_prog = "/usr/bin/python3.8"
" coc.vim END

" signify
"let g:signify_sign_add = '│'
"let g:signify_sign_delete = '│'
"let g:signify_sign_change = '│'
"hi DiffDelete guifg=#ff5555 guibg=none

" FixCursorHold for better performance
let g:cursorhold_updatetime = 100

" context.vim
let g:context_nvim_no_redraw =1

""" Filetype-Specific Configurations

" HTML, XML, Jinja
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType xml setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType htmldjango inoremap {{ {{  }}<left><left><left>
autocmd FileType htmldjango inoremap {% {%  %}<left><left><left>
autocmd FileType htmldjango inoremap {# {#  #}<left><left><left>

" Markdown and Journal
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType journal setlocal shiftwidth=2 tabstop=2 softtabstop=2

""" Custom Functions

" Trim Whitespaces
"function! TrimWhitespace()
    "let l:save = winsaveview()
    "%s/\\\@<!\s\+$//e
    "call winrestview(l:save)
"endfunction

""" CUSTOM MAPPINGS

"open up a terminal
nmap <leader><C-t> <c-W>s<C-w>j:terminal<CR>:set nonumber<CR><S-a>
nmap <C-t> <C-w>v<C-w>l:terminal<CR>:set nonumber<CR><S-a>

" NerdTree
"nmap <leader>q :NERDTreeToggle<CR>
"nnoremap <leader>e :NERDTreeFocus<CR>
"nnoremap <C-f> :NERDTreeFind<CR>  """open NerdTree current directory"""
"nmap \\ <leader>q
"
"CHADtree
"let &tags = expand("%:p")
"nnoremap <leader>e :CHADopen<CR>
"nnoremap <leader>3 :CHADopen --always-focus<CR>

"nnoremap  <leader>e :Vexplore<CR><C-w>r
"nnoremap  <leader>E :Ex<CR>

"Tagbar
"nmap <leader>w :TagbarToggle<CR>
"nmap \| <leader>w

"Source vim
nmap <leader>R :so ~/.config/nvim/init.vim<CR>


"nmap <leader>t :call TrimWhitespace()<CR>
"nmap <leader>y <C-w>v<C-w>l:HackerNews best<CR>J
"nmap <leader>p <Plug>(pydocstring)

"easy align
xmap <leader>a gaip*
nmap <leader>a gaip*
"nmap <leader>s :Rg<CR>

"scroll sync lock
nnoremap <leader><leader>sl :set scb!<CR>

"quick grep search
"all system files -- not useful
"nmap <leader>d :Files<CR>
"nnoremap <silent> <Leader>h: :History:<CR>
"nnoremap <silent> <Leader>h/ :History/<CR>
""latest files -- very useful!
"nnoremap <silent> <Leader>hh :History<CR>
""find file in line
"nmap <leader>z :BLines<CR>
"nmap <leader>H :RainbowParentheses!!<CR>
"nnoremap """ :reg<CR>
"


"nmap <leader>g :Goyo<CR>
"nmap <leader>j :set filetype=journal<CR>
"nmap <leader>l :Limelight!!<CR>
"xmap <leader>l :Limelight!!<CR>
"
"I actually don't like what this does.  It makes the python indent all weird.
"Figure out what plugin would cause indent to be like this, then delete it.
"I still have an annoying indentation error when I'm typing as well.
"autocmd FileType python nmap <leader>x :0,$!~/.config/nvim/env/bin/python -m yapf<CR>

nmap <silent> <leader>no :set hlsearch!<CR>

"nmap <Tab> :tabn<CR>
"nmap <S-Tset -g status-left "#{pane_current_path}"ab> :tabp<CR>

" view current buffers and type the number you want to go to.
":bd to delete a single buffer
nnoremap <F5> :buffers<CR>:buffer<Space>

"go back to file tree
"nnoremap <C-e> :Ex

"splits
nnoremap <leader><C-v> :vsplit<CR>
"nnoremap <leader><C-h> <C-w><s>

"Navigate split buffers
"Normal Mode
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-l> <C-W><C-l>
nnoremap <C-h> <C-W><C-h>
"Terminal mode
tnoremap <C-j> <C-\><C-n><C-W><C-J>
tnoremap <C-k> <C-\><C-n><C-W><C-K>
tnoremap <C-l> <C-\><C-n><C-W><C-L>
tnoremap <C-h> <C-\><C-n><C-W><C-H>


"add current cursor position to jumplist
nnoremap <Leader>m  :autocmd CursorHold * normal! m'<CR>


""easymotion mappings
"let g:EasyMotion_do_mapping = 0 " Disable default mappings
"nnoremap <Leader>f <Plug>(easymotion-prefix)f
"nnoremap <Leader>s <Plug>(easymotion-s2)
"nnoremap <Leader>f <Plug>(easymotion-prefix)s
"nnoremap  <c-_> <Plug>(easymotion-sn)
"nnoremap  <Leader>/ <Plug>(easymotion-sn)
"nnoremap <Leader>F <Plug>(easymotion-prefix)F
"nnoremap <Leader>s <Plug>(easymotion-prefix)s


"map  <C-;> <Plug>(easymotion-next)
"map  <C-,> <Plug>(easymotion-prev)" Terminal mode:
"nmap <leader>f <Plug>(easymotion-overwin-f)
"nmap <leader>cf c<Plug>(easymotion-overwin-f)
"nmap s <Plug>(easymotion-overwin-f2)
" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

"fuzzy finder
"I have to remap ctrlp's default in order to make my custom command to work
let g:ctrlp_map = '<c-p>'
"open up all files including dotfiles
nnoremap <leader>p :CtrlP /home/ldraney<CR>
set wildignore+=*/.vim/*
"

"Rename tmux window tab after current file with path
"autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%:t"))


let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

nnoremap <leader><leader>c GVggc
