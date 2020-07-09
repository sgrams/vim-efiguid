" Check if NOT yet loaded
if exists('g:efiguid_loaded') && g:efiguid_loaded
	finish
endif
let g:efiguid_loaded = 1

" Check case
if !exists('g:efiguid_case')
	let g:efiguid_case = "lower"
endif

" Make sure we have python3
if !has('python')
	" finish
endif

function! EfiguidCreate()
" use python to generate EFI_GUID (array type)
python3 << endpy
import vim
from uuid import uuid4
in_str = str(uuid4()).replace("-","")
out_str = '{ 0x' + in_str[0:7] +      \
          ', 0x' + in_str[7:11] +     \
          ', 0x' + in_str[11:15] +    \
          ', { 0x' + in_str[15:17] +  \
          ', 0x' + in_str[17:19] +    \
          ', 0x' + in_str[19:21] +    \
          ', 0x' + in_str[21:23] +    \
          ', 0x' + in_str[23:25] +    \
          ', 0x' + in_str[25:27] +    \
          ', 0x' + in_str[27:29] +    \
          ', 0x' + in_str[29:31] +    \
          ' }}'
vim.command("let l:new_uuid = '%s'" % str(out_str))
endpy
  return l:new_uuid
endfunction

" Mappings
nnoremap <Plug>Efiguid i<C-R>=EfiguidCreate()<CR>
inoremap <Plug>Efiguid <C-R>=EfiguidCreate()<CR>
vnoremap <Plug>Efiguid c<C-R>=EfiGuidCreate()<CR><Esc>

if !exists("g:efiguid_no_mappings") || !g:efiguid_no_mappings
	nmap <Leader>g <Plug>Efiguid
	vmap <Leader>g <Plug>Efiguid
endif
