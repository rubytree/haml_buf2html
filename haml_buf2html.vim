" haml_buf2html.vim
" Copyright (c) 2010 Mateusz Bil 
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.

if exists("g:haml_buf2html_loaded")
        finish
endif

let g:haml_buf2html_loaded = 1

" is vim compiled with ruby support?
if !has('ruby')
        echohl WarningMsg
        echo "Warning haml_buf2haml needs Vim compiled with Ruby support"
        echohl none
        finish
endif

function Haml2HtmlNew()
        ruby $buffer.haml2html
endfunction

function Haml2HtmlVNew()
        ruby $buffer.haml2html :render => :new, :vsplit => true
endfunction

function Haml2HtmlInsert()
        ruby $buffer.haml2html :render => :insert
endfunction

function Haml2HtmlOverwrite()
        ruby $buffer.haml2html :render => :overwrite
endfunction

function Haml2HtmlView()
        ruby $buffer.haml2html :render => :preview
endfunction

map <c-h><c-n> :call Haml2HtmlNew()<CR>
map <c-h><c-v> :call Haml2HtmlVNew()<CR>
map <c-h><c-i> :call Haml2HtmlInsert()<CR>
map <c-h><c-o> :call Haml2HtmlOverwrite()<CR>
map <c-h><c-p> :call Haml2HtmlView()<CR>

ruby << EOR
        require 'vim'
        require 'haml_buf2html.rb'
        $buffer = VIM::Buffer.current
EOR
