# latex-previewer Plugin for neovim

## latexmk setup
* change your latexmk config *$HOME/.latexmkrc*
```conf
$dvi_previewer = 'start xdvi -watchfile 1.5';
$ps_previewer  = 'start gv --watch';
$pdf_previewer = 'start zathura';
```
* set zathura as default viewer

## zathura setup
* change your zathura config *$HOME/.config/zathura/zathurarc*
```conf
set synctex true
set synctex-editor-command "nvr --remote-silent +%{line} %{input}"
```
* enable synctex set synctex-editor-command, needed for backward search (zathura to neovim)

## backward search
<!-- ```zsh -->
<!-- nvr --servername /tmp/nvimsocket my_main_file.tex -->
<!-- ``` -->
* ctrl + left click in pdf opens source file

## latex build command
```zsh
latexmk -pdf -interaction=nonstopmode -pvc -quiet -synctex=1 -shell-escape <my_main_file>.tex
```
* run latexmk
* ```-pdf``` output pdf
* ```-synctex=1``` enable synctex
* ```-pvc``` continuously checking all input files for changes and re-compile the whole document if needed and always display the result
* more information [here](https://mg.readthedocs.io/latexmk.html)

## magic comments
* add the following to your latex files in the very first line
```latex
% !TEX root = <my_main_file.tex>
```
* you need to set the path to your main latex file, so that the plugin can show the correct preview
