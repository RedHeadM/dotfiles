" Fisa-nvim-config
" http://nvim.fisadev.com
" version: 10.0

" TODO current problems:
" * end key not working undef tmux+fish

" ============================================================================
" Vim-plug initialization
" Avoid modify this section, unless you are very sure of what you are doing

let vim_plug_just_installed = 0
let vim_plug_path = expand('~/.config/nvim/autoload/plug.vim')
if !filereadable(vim_plug_path)
    echo "Installing Vim-plug..."
    echo ""
    silent !mkdir -p ~/.config/nvim/autoload
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let vim_plug_just_installed = 1
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" Obscure hacks done, you can now modify the rest of the .vimrc as you wish :)

" ============================================================================
" Active plugins
" You can disable or add new ones here:

" this needs to be here, so vim-plug knows we are declaring the plugins we
" want to use
call plug#begin('~/.config/nvim/plugged')

" Code commenter
Plug 'scrooloose/nerdcommenter'

" Better file browser
"Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " on demand
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on':  'NERDTreeToggle' } " on demand
" Class/module browser
Plug 'majutsushi/tagbar'
" TODO known problems:
" * current block not refreshing

" Airline, info line at bottom
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Code and files fuzzy finder
" Plug 'ctrlpvim/ctrlp.vim'
" Extension to ctrlp, for fuzzy command finder
" Plug 'fisadev/vim-ctrlp-cmdpalette'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Pending tasks list: mapped to <F2>
Plug 'fisadev/FixedTaskList.vim'

" Async autocompletion
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Completion from other opened files
"Plug 'Shougo/context_filetype.vim'

" Python autocompletion
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build' } }

" Mulitcusur
Plug 'mg979/vim-visual-multi', {'branch': 'master'} 

" bestter pyton text objects and motions
" eg. <vaf>: select around fn, <yac> copy around class  
Plug 'jeetsukumaran/vim-pythonsense'
"Plug 'python-mode/python-mode', { 'branch': 'develop' }

" Automatically close parenthesis, etc
"Plug 'Townk/vim-autoclose'

" python auto doc stirng
Plug 'heavenshell/vim-pydocstring'

" Surround
"Plug 'tpope/vim-surround'
Plug 'machakann/vim-sandwich'

" Indent text object
Plug 'michaeljsmith/vim-indent-object'

" Indentation based movements
Plug 'jeetsukumaran/vim-indentwise'

" Indentation based movements
" alig test vipga=
Plug 'junegunn/vim-easy-align'

" Better language packs
"Plug 'sheerun/vim-polyglot'

" Ack code search (requires ack installed in the system)
Plug 'mileszs/ack.vim'
" TODO is there a way to prevent the progress which hides the editor?

" Paint css colors with the real color
"Plug 'lilydjwg/colorizer'
" TODO is there a better option for neovim?

" Window chooser
"Plug 't9md/vim-choosewin'

" Highlight matching html tags
"Plug 'valloric/MatchTagAlways'

" Git integration nerdtree:  status 
Plug 'tpope/vim-fugitive'

" Git/mercurial/others diff icons on the side of the file lines
Plug 'mhinz/vim-signify'

" Yank history navigation
Plug 'vim-scripts/YankRing.vim'

" Linters
Plug 'neomake/neomake'
" TODO is it running on save? or when?
" TODO not detecting errors, just style, is it using pylint?

" Relative numbering of lines (0 is the current line)
" (disabled by default because is very intrusive and can't be easily toggled
" on/off. When the plugin is present, will always activate the relative
" numbering every time you go to normal mode. Author refuses to add a setting
" to avoid that)
Plug 'myusuf3/numbers.vim'

" displaying thin vertical lines at each indentation level for code indented with spaces
Plug 'Yggdroot/indentLine'

" multi curser 
"Plug 'terryma/vim-multiple-cursors'

" auto ctags C-] to jump to definition
Plug 'ludovicchabant/vim-gutentags'

" Highlight last yank for a shork time
Plug 'machakann/vim-highlightedyank'

Plug 'vim-latex/vim-latex'

" vim and panel movement with <C-h/j/k/l>
Plug 'christoomey/vim-tmux-navigator'


"COLOR and themes 
Plug 'drewtempelmeyer/palenight.vim' " Theme
Plug 'ryanoasis/vim-devicons' " filetype glyphs (icons) to various vim plugins
"Plug 'fisadev/fisa-vim-colorscheme'
"Plug 'morhetz/gruvbox'
"Plug 'dracula/vim'
"Plug 'kaicataldo/material.vim'
"Plug 'ayu-theme/ayu-vim'
"Plug 'sonph/onehalf', {'rtp': 'vim/'}
"Plug 'rakr/vim-one'

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

" ============================================================================
" Install plugins the first time vim runs

if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ============================================================================
" Vim settings and mappings
" You can edit them as you wish

" tabs and spaces handling
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
""'search: incremental search
set ignorecase        " ignore case in searches<Paste>
set smartcase " but case-sensitive if expression contains a capital letter
set nohlsearch

set termguicolors     " enable true colorsHet nobackup
set noswapfile
set nowrap
syntax on
" line ident 
" the character used for indicating indentation
"let g:indentLine_char = '┊'
 let g:indentLine_char = '│'
let g:indentLine_color_term = 239
" interactive find replace preview
set inccommand=nosplit
" show line numbers
set nu
    
" undofunction after reopening
set undofile
set undodir=/tmp
 
"mac osx clipboard sharing
set clipboard=unnamed
" remove ugly vertical lines on window division
set fillchars+=vert:\

" True color
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif
" use 256 colors when possible
"if (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256') || has('nvim')
	"let &t_Co = 256
    ""colorscheme solarized8_flat
    "colorscheme fisa
"else
    "colorscheme delek
"endif

" THEME
colorscheme palenight
" needed so deoplete can auto select the first suggestion
set completeopt+=noinsert
" comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
set completeopt-=preview

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" ignore file patterns 
set wildignore=*.o,*~,*.pyc,*/__pycache__/
" save as sudo
ca w!! w !sudo tee "%"

" tab navigation mappings
map tt :tabnew
map <M-Right> :tabn<CR>
imap <M-Right> <ESC>:tabn<CR>
map <M-Left> :tabp<CR>
imap <M-Left> <ESC>:tabp<CR>

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=3
" make scroll faster
set scrolljump=-15
" clear search results
nnoremap <silent> // :noh<CR>

" clear empty spaces at the end of lines on save of python files
autocmd BufWritePre *.py :%s/\s\+$//e

" fix problems with uncommon shells (fish, xonsh) and plugins running commands
" (neomake, ...)
set shell=/bin/bash
set omnifunc=syntaxcomplete#Complete

"*****************************************************************************
" functions
"*****************************************************************************
function! s:FixWhitespace(line1,line2)
    let l:save_cursor = getpos(".")
    silent! execute ':' . a:line1 . ',' . a:line2 . 's/\\\@<!\s\+$//'
    call setpos('.', l:save_cursor)
endfunction

" Toggle spell checking
function! s:ToggleSpellLang()
    " toggle between en and fr
    if &spelllang =~# 'en'
        :set spelllang=de
    else
        :set spelllang=en
    endif
endfunction
"
"*****************************************************************************
" Plugins settings and mappings
"*****************************************************************************

" toggle spell on or off
nnoremap <F4> :setlocal spell!<CR>
" toggle language
nnoremap <F5> :call <SID>ToggleSpellLang()<CR>

" Tagbar -----------------------------

" toggle tagbar display
"map <F4> :TagbarToggle<CR>
"" autofocus on tagbar open
"let g:tagbar_autofocus = 1

" NERDTree -----------------------------

" toggle nerdtree display
map <F3> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
"nmap ,t :NERDTreeFind<CR>
nmap ,t :NERDTreeToggle<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$', '^__pycache__$',"\.egg-info$"]
" show current root as relative path from $HOME in status bar
let NERDTreeStatusline="%{exists('b:NERDTree')?fnamemodify(b:NERDTree.root.path.str(), ':~'):''}"
" hide press for help
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
" close nerdtree if the lastwindow
"autocmd bufenter * if (winnr(“$”) == 1 && exists(“b:NERDTreeType”) && b:NERDTreeType == “primary”) | q | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" nerdtree show git status
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "~",
    \ "Staged"    : "+",
    \ "Untracked" : "x",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "x",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
" Tasklist ------------------------------

" show pending tasks list
map <F2> :TaskList<CR>

" Neomake ------------------------------

" Run linter on write
autocmd! BufWritePost * Neomake

" Check code as python3 by default
let g:neomake_python_python_maker = neomake#makers#ft#python#python()
let g:neomake_python_flake8_maker = neomake#makers#ft#python#flake8()
let g:neomake_python_python_maker.exe = 'python3 -m py_compile'
let g:neomake_python_flake8_maker.exe = 'python3 -m flake8'
" pyton Virtual Environments package:
"let g:python_host_prog = '/usr/bin/python2.7'
"let g:python3_host_prog = '/usr/bin/python3.5'
" Fzf ------------------------------

" set fzf's default input to ripgrep instead of find. This also removes
" gitignore etc 
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
"let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --color=always --exclude .git --ignore-file ~/.gitignore'
"let $FZF_DEFAULT_OPTS='--ansi'
"let g:fzf_files_options = '--preview "(bat --color \"always\" --line-range 0:100 {} || head -'.&lines.' {})"''


" file finder mapping
nmap ,e :GFiles<CR>
nmap ,E :Files<CR>
" tags (symbols) in current file finder mapping
nmap ,g :BTag<CR>
" tags (symbols) in all files finder mapping
nmap ,G :Tag<CR>
" general code finder in current file mapping
nmap ,f :BLines<CR>
" general code finder in all files mapping
nmap ,F :Lines<CR>
" commands finder mapping
nmap ,C :Commands<CR>
" commands show all open buffers
nmap ,b :Buffers<CR>
" to be able to call CtrlP with default search text
"function! CtrlPWithSearchText(search_text, ctrlp_command_end)
    "execute ':CtrlP' . a:ctrlp_command_end
    "call feedkeys(a:search_text)
"endfunction
" same as previous mappings, but calling with current word as default text
"nmap ,wg :call CtrlPWithSearchText(expand('<cword>'), 'BufTag')<CR>
"nmap ,wG :call CtrlPWithSearchText(expand('<cword>'), 'BufTagAll')<CR>
"nmap ,wf :call CtrlPWithSearchText(expand('<cword>'), 'Line')<CR>
"nmap ,we :call CtrlPWithSearchText(expand('<cword>'), '')<CR>
"nmap ,pe :call CtrlPWithSearchText(expand('<cfile>'), '')<CR>
"nmap ,wm :call CtrlPWithSearchText(expand('<cword>'), 'MRUFiles')<CR>
"nmap ,wc :call CtrlPWithSearchText(expand('<cword>'), 'CmdPalette')<CR>

" EasyAlign -----------------------------

"Start interactive EasyAlign in visual mode (e.g. vipga=)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Deoplete -----------------------------

" Use deoplete for autocompletion

let g:deoplete#enable_at_startup = 0
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_complete=0
" complete with words from any opened file
let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'
"let g:deoplete#deoplete_onmni_patterns = get(g:, 'deoplete#force_omni_input_patterns', {})
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"inoremap <expr> <C-n>  deoplete#mappings#manual_complete()
"inoremap <silent><expr> <TAB>
    "\ pumvisible() ? "\<C-n>" :
    "\ <SID>check_back_space() ? "\<TAB>" :
    "\ deoplete#mappings#manual_complete()
"function! s:check_back_space() abort "{{{
    "let col = col('.') - 1
    "return !col || getline('.')[col - 1]  =~ '\s'
"endfunction"}}}
"""""""""""""""""""deoplete-jedi settings"""""""""""""""""""""""""""

" whether to show doc string
"let g:deoplete#sources#jedi#show_docstring = 0

" do not use typeinfo (for faster completion)
"let g:deoplete#sources#jedi#enable_typeinfo = 0

" for large package, set autocomplete wait time longer
"let g:deoplete#sources#jedi#server_timeout = 50

" Jedi-vim ------------------------------

" Disable autocompletion (using deoplete instead)
"let g:jedi#completions_enabled = 1

" All these mappings work only for python code:
" Go to definition
"let g:jedi#goto_command = ',d'
" Find ocurrences
"let g:jedi#usages_command = ',o'
" Find assignments
"let g:jedi#goto_assignments_command = ',a'
" Go to definition in new tab
"nmap ,D :tab split<CR>:call jedi#goto()<CR>
"let g:jedi#documentation_command = ",,d"

" Ack.vim ------------------------------

" mappings
nmap ,r :Ack
nmap ,wr :Ack <cword><CR>

" Window Chooser ------------------------------
"nmap  -  <Plug>(choosewin)
" show big letters
"let g:choosewin_overlay_enable = 1

" Signify ------------------------------

" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = [ 'git', 'hg' ]
" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

" Autoclose ------------------------------

" Fix to let ESC work as espected with Autoclose plugin
" (without this, when showing an autocompletion window, ESC won't leave insert
"  mode)
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" Yankring -------------------------------

" Fix for yankring and neovim problem when system has non-text things copied
" in clipboard
let g:yankring_clipboard_monitor = 0
let g:yankring_history_dir = '~/.config/nvim/'

" Airline ------------------------------

let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0
" show tabs at the top if open
let g:airline#extensions#tabline#formatter = 'unique_tail'
" to use fancy symbols for airline, uncomment the following lines and use a
" patched font (more info on docs/fancy_symbols.rst)
"if !exists('g:airline_symbols')
   "let g:airline_symbols = {}
"endif
"let g:airline_left_sep = '⮀'
"let g:airline_left_alt_sep = '⮁'
"let g:airline_right_sep = '⮂'
"let g:airline_right_alt_sep = '⮃'
"let g:airline_symbols.branch = '⭠'
"let g:airline_symbols.readonly = '⭤'
"let g:airline_symbols.linenr = '⭡'

"  added to  Fisa-nvim-config :
set cursorline
hi Cursor ctermfg=White ctermbg=Yellow cterm=bold guifg=white guibg=yellow gui=bold

set hlsearch
"  ctrl l to clear search heilight
nnoremap <C-l> :nohl<CR><C-l>:echo "Search Cleared"<CR>

" Return to the same line you left off at
	augroup line_return
		au!
		au BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\	execute 'normal! g`"zvzz' |
			\ endif
	augroup END

" Auto load
	" Triger `autoread` when files changes on disk
	" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
	" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
	autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
	set autoread
	" Notification after file change
	" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
	autocmd FileChangedShellPost *
	  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None


" copy and past with gvim
vnoremap <C-c> "+y
"map <C-v> "+p
"map <leader>v "+p

if has('mouse')
   set mouse=a
 endif
" caps lock to esc
"nnoremap <Tab> <Esc>

" True Colors
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  "if (has("termguicolors"))
  if (has("mermguicolors"))
    set mermguicolors
  endif
endif

" theme
set background=dark
" vearch selction with // 
vnoremap // y/<C-R>"<CR>

"Map leader key to , NerdCommenter, you DO have to hold down the <leader> key
let mapleader = ","

" selction with comment
:nnoremap <Leader>q" ciw""<Esc>P
:nnoremap <Leader>q' ciw''<Esc>P


" Mappings to move lines alt un or down with j and k
noremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" python print word unter cursor 
nnoremap <A-d> viwy'>oprint('<C-r>": {}'.format(<C-r>"))<Esc>
" python print selected word 
vnoremap <A-d> y'>oprint('<C-r>": {}'.format(<C-r>"))<Esc>
nnoremap <A-l> viwy'>olog.info('<C-r>": {}'.format(<C-r>"))<Esc>
vnoremap <A-l> y'>olog.info('<C-r>": {}'.format(<C-r>"))<Esc>
" brackpoints in Python 3.6 and below
nnoremap <A-b> oimport pdb; pdb.set_trace() # BREAKPOINT<Esc>



" save with ctrl c, if freezes press ctrl q
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" yank from current cursor position to end of line
"noremap Y y$
"nnoremap Y y$


" ctrl-D to dublicate line
map <C-S-d> yyP

" remap  capital HJKL to move line
noremap H ^
noremap L g_
noremap J 5j
noremap K 5k

" replace word under cursor, globally, with confirmation
"nnoremap <Leader>k :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
"vnoremap <Leader>k y :%s/<C-r>"//gc<Left><Left><Left>
nmap <Leader>k <Plug>(Scalpel)
vmap <Leader>k "xy:Scalpel/\v<<C-R>=@x<CR>>//<Left>
"<CR>

" remove highlighting on escape>u
"map <silent> <esc> :nohlsearch<cr>


" Keep selection when indenting/outdenting.
vnoremap > >gv
vnoremap < <gv

" Open tag in new tab, used with gutentags
:nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T

