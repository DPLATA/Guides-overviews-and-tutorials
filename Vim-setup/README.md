# Setting up vim text editor for beginners. 
This guide was made on Kubuntu 20.04 focal OS. This guide assumes you already have vim installed in your computer and that you have basic understanding of vim modes. Also this guide assumes that you know how to change from command to insert mode and knowing how to quit vim is also required if you do not know how to do it you should start by learning those basic steps first.


### Step 1:
Create and edit a .vimrc file

```
vim ~/.vimrc
```

This will create a file named .vimrc under your home dir (~) and then open it directly on vim editor.

### Step 2:
Setup vim config inside .vimrc file

Bear with me on this one, just copy for now, explanation is commented out in my .vimrc file.

```
 set noerrorbells                                                                
 set tabstop=4 softtabstop=4                                                     
 set shiftwidth=4                                                                
 set expandtab                                                                   
 set smartindent                                                                 
 set rnu                                                                         
 set nowrap                                                                      
 set smartcase                                                                   
 set incsearch                                                                   
                                                                                
 set colorcolumn=80                                                              
 highlight ColorColumn ctermbg=0 guibg=lightgrey     
```

### Step 3:
Create .vim/ folder by running

```
mkdir ~/.vim
```

This will create a .vim folder under your home directory.

### Step 4:
Install vim-plug

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

This will create a file for vim-plug inside .vim/autoload folder.

### Step 5:
Add plugins and colorscheme at the end of your .vimrc file

```
call plug#begin('~/.vim/plugged')                                               
 Plug 'morhetz/gruvbox'                                                          
 Plug 'jremmen/vim-ripgrep'                               
call plug#end()

 colorscheme gruvbox                                                             
 set background=dark
```


### Step 6:
Install YouCompleteMe plugin

```
clone YCM repo into your .vim/plugged folder git clone https://github.com/ycm-core/YouCompleteMe.git
```
Install YCM plugin

```
cd ~/.vim/plugged/YouCompleteMe/
git submodule update --init --recursive
python3 install.py --all
```

### Step 7:
Add the following line after the rip grep plugin in .vimrc file

```
Plug 'git@github.com:ycm-core/YouCompleteMe.git'
```

Save the file and install the plugin

```
:source %
:PlugInstall
```

This guide is far from perfect but it is a good starting point for someone looking to start using vim more often; like me ;).`
