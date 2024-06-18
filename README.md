## Configs and stuff

For now you can just:

```
mv ~/.config/nvim ~/.config/nvim.bak # optional back up
git clone git@github.com:leiske/dotfiles.git ~/.config/
```
(should fail to install if it can't make a backup)

Probably add `alias vim="nvim"` or something like that


## tmux plugins

Use `prefix + I` to install plugins

## Issues migrating from Packer to Lazy?

Try clearing cache and stuff and restart vim few times

```bash
rm -r ~/.local/share/nvim
# check your XDG_* env vars for this
rm -r ~/.cache/nvim
```
