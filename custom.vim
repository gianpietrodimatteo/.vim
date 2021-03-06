"------------------------------------------------------------------------------
" Master Mappings
"------------------------------------------------------------------------------
" Map escape sequences to their alt combinations
let c='a'
while c <= 'z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw
" Timeout to know if it was Esc j or Alt j
set timeout ttimeoutlen=50

function! ConfirmQuit()
  if (&modified==1)
    if (confirm("Close this buffer and discard changes?", "&Yes\n&No", 2)==1)
      :quit!
    endif
  else
    :quit!
  endif
endfu

function! ConfirmQuitAll()
  if (len(filter(getbufinfo(), 'v:val.changed == 1')) > 0)
    if (confirm("Close all buffers and discard changes?", "&Yes\n&No", 2)==1)
      :qa!
    endif
  else
    :qa!
  endif
endfu

" Prompt before force quitting
cnoremap <silent> q!<CR>  :call ConfirmQuit()<CR>
nmap ZQ :call ConfirmQuit()<CR>
cnoremap <silent> qa!<CR>  :call ConfirmQuitAll()<CR>

function! DeleteThis()
  if (confirm("Delete this file and close this buffer?", "&Yes\n&No", 2)==1)
    :call delete(expand('%')) | bdelete!
  endif
endfu
nmap <m-b> :call DeleteThis()<CR>


"------------------------------------------------------------------------------
" Basics
"------------------------------------------------------------------------------
" Type :so % (:source %) to refresh .vimrc after making changes

set nocompatible
set mouse=a
set hidden
syntax enable
set number relativenumber
set encoding=utf-8
set fileencodings=utf-8
set laststatus=2
set splitright splitbelow
" autocmd BufNewFile * startinsert
set ignorecase
set incsearch

set cmdheight=1

let mapleader =" "

""let g:solarized_termcolors=256
""set t_Co=256
" set background=light
" set termguicolors " Enable true color support.
" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" " colorscheme solarized
" colorscheme jellybeans

" NOTE - only works after installing vim gtk
" set clipboard=unnamedplus
set clipboard=unnamed

" Activates filetype detection and other stuff and autocompletion
filetype indent plugin on
set omnifunc=syntaxcomplete#Complete
set wildmode=longest,list,full

" Disable automatic comenting on new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

set backupdir=~/.vim/temp/.backup//
set directory=~/.vim/temp/.swp//
set undodir=~/.vim/temp/.undo//

" Indent with 2 spaces
set expandtab
set shiftwidth=2
set softtabstop=2

" Automatically deletes all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" Line wraping
set wrap
set fo+=t
set fo-=l
set tw=0

" Toggle line wrapping at 80 characters
let s:wrapping = 0
function! ToggleWrapFunction()
  if s:wrapping == 0
    let s:wrapping = 1
    set tw=80
  else
    let s:wrapping = 0
    set tw=0
  endif
endfunction

command ToggleWrap call ToggleWrapFunction()

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .

" % takes you to matching pairs
set matchpairs=(:),{:},[:],<:>,?:\:

" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" Toggle status line
let s:hidden_all = 0
function! ToggleHiddenAll()
  if s:hidden_all  == 0
    let s:hidden_all = 1
    set noshowmode
    set noruler
    set laststatus=0
    set noshowcmd
  else
    let s:hidden_all = 0
    set showmode
    set ruler
    set laststatus=2
    set showcmd
  endif
endfunction

set backspace=indent,eol,start  " more powerful backspacing

nnoremap <M-h> :call ToggleHiddenAll()<CR>

" Disable ex-mode mappings
nnoremap Q <nop>

" Stop spamming me with viminfo files
set viminfo="NONE"


"------------------------------------------------------------------------------
" Basic keybindings
"------------------------------------------------------------------------------
" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Still available:
" Ctrl-I      Tab
" Ctrl-[      Esc
" Ctrl-M      Enter
" Ctrl-H      Backspace
" leader k
" leader l
" leader h
" lets liberate leader y u i for the tab functionallity
" Alt move/delete buffers
nmap <leader>k :bp<CR>
nmap <leader>l :bn<CR>
nmap <leader>h :bd<CR>
nmap <leader>i :tabp<CR>
nmap <leader>o :tabn<CR>
nmap <leader>y :tabclose<CR>

" easy quit, save, one or all
nnoremap ZW :call ConfirmQuitAll()<CR>
nnoremap ZS :wa<CR>
nnoremap ZA :update<CR>
nnoremap ZX :xa<CR>

" Navigating with guides
" inoremap <leader><Tab> <Esc>/<++><Enter>"_c4l
vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
map <leader><leader> <Esc>/<++><Enter>"_c4l

" Remapping cxco to ctrl+space
imap <C-Space> <C-X><C-O>

" Make easy enter
nnoremap <leader><Enter> i<Enter><Esc>

" Quick macros
nnoremap <Space>q @q

" set clipboard=unnamed

" Quick clipboard cut, copy and paste
" nmap m "*m
" nmap M "*M
" nmap y "*y
" nmap Y "*Y
" nmap p " *p
" nmap P " *P

" vmap m "*m
" vmap M "*M
" vmap y "*y
" vmap Y "*Y
" vmap p " *p
" vmap P " *P
" Now that I have cut this is obsolete

" Select all
nnoremap <C-a> ggVG

" Stop highlighting:
nnoremap <F3> :noh<CR>

"------------------------------------------------------------------------------
" Editor keybindings
"------------------------------------------------------------------------------
" Alt moves lines
nmap <m-j> Vmp
nmap <m-k> VmkP
vmap <m-j> Vmp
vmap <m-k> VmkP

" Alt duplication
nmap <m-d> YP
vmap <m-d> YP
imap <m-d> <Esc>YPi

" Easy escaping characters
inoremap <m-l> <Right>
" Easy deletion of unwanted completions
inoremap <m-x> <Del>
" New Line
inoremap <m-m> <Esc>o
nnoremap <m-m> o<Esc>

" Quick split window
nnoremap <C-Bslash> :vsplit<Enter>

" Quick source current configuration file
nmap <leader><leader>o :so %<Enter>

" Update this file
nmap <leader>j :e<CR>
" Quick split
nmap <leader>v :vsplit

" Search for selection
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" execute single line
nnoremap <m-t> 0YPj!!bash<CR>
" execute multiple lines
xnoremap <m-t> yPgv:!bash<CR>

" Spell-check e for english, i for portuguese
nnoremap <leader><leader>e :setlocal spell! spelllang=en_us<CR>
nnoremap <leader><leader>i :setlocal spell! spelllang=pt<CR>

" Correct indentation and apply line wrap
nnoremap <m-f> V=Vgq<CR>
" Correctly indent the whole file motherfuckerrr
nnoremap <leader>f :g/./ normal gqq<CR>:noh<CR>

" F7 corrects indentation
nnoremap <F7> gg=G<C-o><C-o>

" Print time stamp
nnoremap <F2> :read !date<CR>

" Quick Notes
nnoremap <leader>3 I# <Esc>
nnoremap <leader>1 I1. <Esc>
nnoremap <leader>8 I* <Esc>
nnoremap <leader>- o---<CR><CR><Esc>
nnoremap <leader><Tab> I<Tab><Esc>
" Markdown
nnoremap <leader>9 I[](<Esc>A)<Esc>F[a

" Uppercase first letter of line
nnoremap <leader>u 0vU

" New line
" nmap <C-CR> o<Esc>

"------------------------------------------------------------------------------
" Plugin settings
"------------------------------------------------------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#ale#enabled = 1

let g:prettier#config#single_quote = 'true'

let g:ale_open_list = 1
let g:ale_set_quickfix = 1
nmap <silent> <m-i> <Plug>(ale_previous_wrap)
nmap <silent> <m-o> <Plug>(ale_next_wrap)

let g:ale_java_google_java_format_executable =
      \ "$HOME/local/google-java-format/core/target/google-java-format-1.7-SNAPSHOT-all-deps.jar"
let g:ale_java_google_java_format_use_global = 1
let g:ale_linters = {
      \   'javascript': ['eslint'],
      \   'vue': ['eslint'],
      \   'java': ['javac']
      \}

let g:ale_fixers = {
      \    'javascript': ['eslint'],
      \    'typescript': ['prettier', 'tslint'],
      \    'scss': ['prettier'],
      \    'html': ['prettier'],
      \    'java': ['google_java_format']
      \}

let g:ale_java_eclipselsp_path = '$HOME/local/eclipse.jdt.ls'
let g:ale_java_eclipselsp_workspace_path = '$HOME/eclipse/prompt-workspace'

let g:ale_fix_on_save = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_html_htmlhint_options='--config=$HOME/dotfiles/language/.htmlhintrc'
let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''
" autocmd QuickFixCmdPost [^l]* nested cwindow
" autocmd QuickFixCmdPost    l* nested lwindow

map <M-u> :ALEToggle<CR>

" Open close explorer
nnoremap <M-e> :NERDTreeToggle<CR>

" Ctrlp ignoring files
set wildignore+=/*/dist/*,*/target/*,*/node_modules/*,*/tmp/*,*.so,*.swp,*.zip
" MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

map <C-p> :CtrlP<CR>

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn)$',
      \ 'file': '\v\.(exe|so|dll)$',
      \ 'link': 'some_bad_symbolic_links',
      \ }

"----------------- alvan autoclose tags
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
"
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.xml'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified
" files.
"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.xml'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml,xml'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified
" files.
"
let g:closetag_xhtml_filetypes = 'xhtml,jsx,xml'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>`
" will be closed while `<link>` won't.)
"
let g:closetag_emptyTags_caseSensitive = 1

" dict
" Disables auto-close if not in a "valid" region (based on filetype)
"
let g:closetag_regions = {
      \ 'typescript.tsx': 'jsxRegion,tsxRegion',
      \ 'javascript.jsx': 'jsxRegion',
      \ }

" Shortcut for closing tags, default is '>'
"
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
"
let g:closetag_close_shortcut = '<leader>>'

" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" cutlass
nnoremap m d
xnoremap m d

nnoremap mm dd
nnoremap M D

" subversive
" Example config
nmap <leader>s <plug>(SubversiveSubstituteRange)
xmap <leader>s <plug>(SubversiveSubstituteRange)

nmap <leader>ss <plug>(SubversiveSubstituteWordRange)

" Simple motions that are useful for subversive are:
" ie = inner entire buffer
onoremap ie :exec "normal! ggVG"<cr>

" iv = current viewable text in the buffer
onoremap iv :exec "normal! HVL"<cr>

" Confirm substitution
nmap <leader>cr <plug>(SubversiveSubstituteRangeConfirm)
xmap <leader>cr <plug>(SubversiveSubstituteRangeConfirm)
nmap <leader>crr <plug>(SubversiveSubstituteWordRangeConfirm)

" Abolish integration
" You can substitute SubversiveSubvertRange for SubversiveSubvertRangeNoPrompt
" to use default register without prompting
nmap <leader><leader>s <plug>(SubversiveSubvertRange)
xmap <leader><leader>s <plug>(SubversiveSubvertRange)

nmap <leader><leader>ss <plug>(SubversiveSubvertWordRange)


"------------------------------------------------------------------------------
" Styles
"------------------------------------------------------------------------------
au BufRead,BufNewFile *.md setlocal textwidth=80
au BufRead,BufNewFile *.sh setlocal textwidth=80
au BufRead,BufNewFile *.bash setlocal textwidth=80


"------------------------------------------------------------------------------
" Snippets
"------------------------------------------------------------------------------
"*.html
autocmd FileType html nnoremap ,h1 <h1></h1><Enter><Enter><Esc>2kf<i
autocmd FileType html nnoremap ,html <Esc>:-1read
      \ $HOME/.vim/snippets/html.html<CR>

"*.sh
autocmd FileType sh nnoremap ,sh :-1read $HOME/.vim/snippets/shebang.sh<CR>o

