## Configs and stuff

For now you can just:

```
mv ~/.config/nvim ~/.config/nvim.bak # optional back up
git clone git@github.com:leiske/configsandstuff.git ~/.config/
```
(should fail to install if it can't make a backup)

Go download [Packer](https://github.com/wbthomason/packer.nvim) before running

Open nvim and type `:PackerSync`

Probably add `alias vim="nvim"` or something like that
