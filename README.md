# My configuration for NeoVim

How to reproduce my configuration:

Install :

- Git
- Neovim
- NodeJs (Last version)
- choco
- python3
- npm
- pip

choco install:

- choco install mingw
- choco install make
- choco install cmake
- choco install ripgrep

npm install:

- npm install -g tree-sitter-cli
- npm install -g neovim
- npm install -g prettier

pip install:

- pip install neovim
- pip install debugpy

Add to environement PATH :

- C:\Program Files\nodejs\
- C:\Program Files\Git\usr\bin
- C:\Program Files\Git\cmd
- C:\Program Files (x86)\Neovim\bin
- C:\Program Files (x86)\Neovim

Install the vim-plug (Pluggins manager) : https://github.com/junegunn/vim-plug

Open nvim-qt and run command:

- PlugInstall

Create Directory bookmarks (optional):

- Add file bookmarks.vim

  Define bookmarks like that :

       let g:startify_bookmarks = [
             \ {'shortcut': 'path'},
             \ {'shortcut': 'path'},
             \]

