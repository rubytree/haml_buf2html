haml_buf2html
=============
Haml\_buf2html is a simple Vim plugin written in [ruby], that renders html from [haml] directly in Vim.
You can use it to write your plain html faster by writing it in [haml] or to preview how your [haml] will be rendered.

Instalation
===========

Before you install
------------------
Make sure you have installed [vim-ruby], [rubygems] and [haml] gem on your system. 

How to install
--------------
Copy:

* haml\_buf2html.vim file into your $VIMHOME/plugin directory
* haml\_buf2html.rb file into your $VIMHOME/ruby directory


Usage
=====
You can render html from haml buffer in 5 ways:

1. in Vim's terminal: 
        <c-h><c-p> or :call Haml2HtmlView()
2. in new buffer: 
        <c-h><c-n> or :call Haml2HtmlNew()
3. in new vsplitted buffer: 
        <c-h><c-v> or :call Haml2HtmlVNew()
4. insert rendered html after cursor in current haml buffer: 
        <c-h><c-i> or :call Haml2HtmlInsert()
5. overwrite current haml buffer (clear then insert):
        <c-h><c-o> or :call Haml2HtmlOverwrite()


Todo
====
* Installation script
* Vimdoc
* Rails views

Licence
=======
Haml\_buf2html is released under [MIT] licence

[ruby]:http://www.ruby-lang.org
[haml]:http://haml-lang.com/
[vim-ruby]:http://vim-ruby.rubyforge.org/
[rubygems]:http://rubygems.org/
[MIT]:www.opensource.org/licenses/mit-license.php
