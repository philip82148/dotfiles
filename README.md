# dotfiles

## Install

```sh
gclone https://github.com/philip82148/dotfiles
cd dotfiles
cp .gitconfig ~/.gitconfig
cp -r .config ~/.config
```

```sh
code --install-extension esbenp.prettier-vscode
code --install-extension ms-python.black-formatter
code --install-extension ms-python.isort
code --install-extension ms-python.flake8
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension eamodio.gitlens
code --install-extension donjayamanne.githistory
code --install-extension formulahendry.code-runner
code --install-extension vscodevim.vim
```

### Mac

```sh
sed '/# INSERT COMMON/,$d' mac.zshrc > ~/.zshrc
cat common.zshrc >> ~/.zshrc
sed '1,/# INSERT COMMON/d' mac.zshrc >> ~/.zshrc
```

### WSL

```sh
sed '/# INSERT COMMON/,$d' wsl.zshrc > ~/.zshrc
cat common.zshrc >> ~/.zshrc
sed '1,/# INSERT COMMON/d' wsl.zshrc >> ~/.zshrc
```

## Export to repo

```shell
cp -r ~/.config .
rm -rf .config/gh .config/nvim/lazy-lock.json
brew bundle dump -f --no-describe --no-vscode
```

### Mac

```sh
cat mac.zshrc > ~/.zshrc
```

### WSL

```sh
cat wsl.zshrc > ~/.zshrc
```
