" Python specific settings.
setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal cindent
setlocal smarttab
setlocal formatoptions=croql
setlocal number

" Start python on F5
map <F5> :w<CR>:!python "%"<CR>

autocmd BufWritePre * :%s/\s\+$//e

" rebuild pythontags 
"map <C-c> :!ctags -R -f ./pythontags `python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"`<CR>
"
iab ipdb import ipdb; ipdb.set_trace()
iab iipdb from IPython.core.debugger import Tracer
iab iplt import matplotlib.pyplot as plt
iab inp import numpy as np

setlocal textwidth=80
setlocal colorcolumn=80
highlight OverLength ctermbg=darkred ctermfg=white guibg=#592929
match OverLength /\%81v.*/

let g:syntastic_python_checkers=['pylint']
let g:syntastic_check_on_open = 1
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=5
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'

let g:jedi#popup_on_dot = 0

py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

