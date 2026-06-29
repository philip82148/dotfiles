# dotfiles

# Install

```shell
curl https://raw.githubusercontent.com/philip82148/dotfiles/main/.gitconfig > ~/.gitconfig
```

```shell
gclone https://github.com/philip82148/dotfiles
cd dotfiles
cp .gitconfig ~/.gitconfig
cp -r .config ~/.config
```

```shell
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

# Export to repo

```shell
cp ~/.zshrc mac.zshrc
cp -r ~/.config .
rm -rf .config/gh .config/nvim/lazy-lock.json
brew bundle dump -f --no-describe --no-vscode
```
