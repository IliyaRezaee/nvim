set nocompatible              " required
filetype off                  " required

call plug#begin('~/.config/nvim/plugged')

"Plug 'preservim/nerdtree'
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
"Plug 'Xuyuanp/nerdtree-git-plugin'
"Plug 'unkiwii/vim-nerdtree-sync'
Plug 'vim-scripts/indentpython.vim'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'preservim/nerdcommenter'
Plug 'alvan/vim-closetag'
Plug 'joshdick/onedark.vim'
Plug 'mattn/emmet-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-airline/vim-airline'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'epilande/vim-react-snippets'
Plug 'SirVer/ultisnips'
Plug 'voldikss/vim-floaterm'
Plug 'famiu/bufdelete.nvim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

call plug#end()

" Enable folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" Floaterm config
let g:floaterm_keymap_toggle = '<space>t'
let g:floaterm_keymap_next   = '<F8>'
let g:floaterm_keymap_prev   = '<F6>'
let g:floaterm_keymap_new    = '<F5>'
let g:floaterm_autoinsert=1
let g:floaterm_width=0.8
let g:floaterm_height=0.8
let g:floaterm_wintitle=0
let g:floaterm_autoclose=1
let g:floaterm_wintype="split"
let g:floaterm_height=0.3
autocmd User FloatermOpen setlocal nonumber norelativenumber

" ultisnips config
let g:UltiSnipsExpandTrigger="<C-s>"
let g:UltiSnipsJumpForwardTrigger="<C-f>"
let g:UltiSnipsJumpBackwardTrigger="<C-b>"

" set spaces to 2 for html, css, js
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab
autocmd Filetype htmldjango setlocal tabstop=2 shiftwidth=2 expandtab
autocmd Filetype css setlocal tabstop=2 shiftwidth=2 expandtab
autocmd Filetype javascript setlocal tabstop=2 shiftwidth=2 expandtab
autocmd Filetype javascriptreact setlocal tabstop=2 shiftwidth=2 expandtab
autocmd Filetype typescript setlocal tabstop=2 shiftwidth=2 expandtab
autocmd Filetype typescriptreact setlocal tabstop=2 shiftwidth=2 expandtab
autocmd Filetype json setlocal tabstop=2 shiftwidth=2 expandtab


" emmet config
let g:user_emmet_expandabbr_key='<Tab>'
imap <expr> <C-e> emmet#expandAbbrIntelligent("\<C-e>")

" prettier config
"augroup fmt
  "autocmd!
  "autocmd BufWritePre * undojoin | Neoformat
"augroup END

" airline config

" enable tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
set showtabline=1 " Always show tabs
set noshowmode " We don't need to see things like -- INSERT -- anymore

nmap <C-t> <Esc>:tabnew<CR>

" snippets config
" let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
" let g:UltiSnipsUsePythonVersion = 3

" fzf config
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }


nnoremap <C-p> :Files<cr>
map <space>b :Buffers<CR>
nnoremap <space>g :Rg<CR>

" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden -g '!node_modules/' -g '!venv/'"


" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)


" Get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case --glob "!node_modules/ !venv/" %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" nerdcommenter
vmap <C-_> <plug>NERDCommenterToggle
nmap <C-_> <plug>NERDCommenterToggle

" python indentaion config
au BufNewFile,BufRead *.py
    \set tabstop=4
    \set softtabstop=4
    \set shiftwidth=4
    \set textwidth=79
    \set expandtab
    \set autoindent
    \set fileformat=unix

" a red color for bad whitespaces
au BufRead,BufNewFile * match BadWhitespace /\s\+$/

" general settings
colorscheme onedark
set number
set showmatch
set history=1000
set undolevels=1000
set wildignore=*.swp,*.bak,*.pyc
set visualbell
set noerrorbells
set encoding=utf-8
set mouse=a   " support mouse
set termbidi  " support persian
set clipboard=unnamedplus
set colorcolumn=80
syntax on

nmap <Tab> :bNext<CR>
nmap <S-Tab> :bprevious<CR>
nmap <space>w :Bdelete<CR>
nmap <space>r :source $MYVIMRC<CR>
tnoremap <Esc> <C-\><C-n>

" enable case insensetive search
set ignorecase
set smartcase

highlight BadWhitespace ctermbg=red guibg=darkred

" config autoclose tag
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '<leader'
let g:closetag_filenames = '*.html,*.js,*.jsx,*.tsx'

" config coc
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-pairs',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-pyright',
  \ 'coc-html',
  \ 'coc-htmldjango',
  \ 'coc-explorer',
  \ ]

" coc-pairs
autocmd FileType * let b:coc_pairs_disabled = ["<"]

" coc-explorer
" Explorer
let g:coc_explorer_global_presets = {
\   '.vim': {
\     'root-uri': '~/.vim',
\   },
\   'tab': {
\     'position': 'tab',
\     'quit-on-open': v:true,
\   },
\   'floating': {
\     'position': 'floating',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingTop': {
\     'position': 'floating',
\     'floating-position': 'center-top',
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingLeftside': {
\     'position': 'floating',
\     'floating-position': 'left-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'floatingRightside': {
\     'position': 'floating',
\     'floating-position': 'right-center',
\     'floating-width': 50,
\     'open-action-strategy': 'sourceWindow',
\   },
\   'simplify': {
\     'file-child-template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   }
\ }

nmap <space>e :CocCommand explorer<CR>
nmap <space>f :CocCommand explorer --preset floating<CR>
autocmd BufEnter * if (winnr("$") == 1 && &filetype == 'coc-explorer') | q | endif

" from readme
" if hidden is not set, TextEdit might fail.
set hidden " Some servers have issues with backup files, see #649 set nobackup set nowritebackup " Better display for messages set cmdheight=2 " You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
