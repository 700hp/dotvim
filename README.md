Installation:

    mkdir -p ~/.vim/bundle
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle   
    git clone git://github.com/jightuse/dotvim.git ~/.vim
    vim +BundleInstall +qall

Create symlinks:

    ln -s ~/dotfiles/vimrc ~/.vimrc
