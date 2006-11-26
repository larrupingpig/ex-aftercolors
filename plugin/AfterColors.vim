" Vim Plugin: AfterColors.vim: 
" Provides: Automatic sourcing of after/colors/ scripts.
" Author: Peter Hodge <toomuchphp-vim@yahoo.com>
" Version: 1.2
" Last Update: November 27, 2006
"
" Warning: If you only have vim 6, the after/colors scripts will only be
" invoked once when Vim starts up. (If you only specify your colorscheme in
" your .vimrc file, this should be good enough.)
"
" Minor Bug: if you just add your 'after/colors' scripts to
" 'vimfiles/after/colors/myColorsName.vim', when you go to
" use CTRL-D after the 'colors' command, vim will list
" 'myColorsName' twice, because it doesn't know that one of them
" is an 'after' script. I have sent an email to Bram regarding this
" bug, but as a work-around, I have made it possible that you can
" also put your scripts in an 'after_colors' folder:
"   vimfiles/after_colors/myColorsName.vim
" or
"   vimfiles/after/after_colors/myColorsName.vim
"
"
" Note: because you generally choose your colorscheme in
" _vimrc and plugins are loaded afterwards, the sequence files
" are loaded on startup may be a little confusing at first:
" -- Vim Load Sequence --
" 	1 - _vimrc
" 	2 - vimfiles/colors/myColorsName.vim
" 	3 - vimfiles/plugins/[plugins]
" 	4 - vimfiles/plugins/AfterColors.vim
" 	5 - vimfiles/plugins/[more plugins]
" 	6 - vimfiles/after_colors/myColorsName.vim


" provide ability for an 'after/colors' file using autocommands
augroup AfterColorsPlugin
	autocmd!

	" source the 'after' colors scripts only after vim has finished everything
	" else, because there are many things which will reset the colors
	autocmd VimEnter * call s:AfterColorsScript()

	" if this vim has the 'Colorscheme' event, we can hook onto it to ensure
	" that the 'after' colors are reloaded when the colorscheme is changed
	if exists('#Colorscheme')
		autocmd Colorscheme * call s:AfterColorsScript()
	endif

augroup end

function! s:AfterColorsScript()
	if exists('g:colors_name') && strlen(g:colors_name)
		" allow two places to store after/colors scripts
		execute 'runtime! after/colors/' . g:colors_name . '.vim'
		execute 'runtime! after_colors/' . g:colors_name . '.vim'

		" allow global colors in 'common.vim'
		execute 'runtime! after/colors/common.vim'
		execute 'runtime! after_colors/common.vim'
	endif
endfunction
