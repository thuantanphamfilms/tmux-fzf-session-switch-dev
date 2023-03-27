↖️ (Feeling lost? Use the GitHub TOC!)

# TMUX FZF Session Switch

![preview img](/img/preview.png)

## Can do?

1. Session + window name fuzzy search and switch.
2. Create new session

## Getting started

- Video: 
  - Tutorial: https://youtu.be/WJEphxyKAbw
  - Demo v2, session + window search: https://youtu.be/XWdDwQJgUmw

- Install the [tpm](https://github.com/tmux-plugins/tpm) Tmux Plugin Manager.
- Put `set -g @plugin 'thuanOwa/tmux-fzf-session-switch'` into your tmux config
- Use tpm to install this plugin. Default you can press `prefix + I` (`I` is
  `shift + i` = I)
- `Prefix + Ctrl + f`: Open up fzf in a new tab. (e.g. prefix = ctrl + a. Hold ctrl -> press a -> press f -> done)
- If you type a name that doesn't exist, you will be prompted to create it.

> If this name conflicts with another session name -> add a double/single quotes `'example'`

## Requirements

- [Tmux >= 3.3a](https://github.com/thuanowa/tmux-fzf-session-switch/pull/5/files) `pop-up menu`
- [fzf](https://github.com/junegunn/fzf)
- `>=` 2 tmux sessions (bug [#10](https://github.com/thuanowa/tmux-fzf-session-switch/issues/10))

## Customize

> 🫰Thanks to [@erikw](https://github.com/erikw)

### Search session only

```bash
set-option -g @fzf-goto-session-only 'true'
```

### Key binding

```bash
set -g @fzf-goto-session 'key binding'
```

> Eg. to override the default session switcher in tmux available at `prefix` + s`:

```bash
set -g @fzf-goto-session 's'
```

#### Without prefix

```bash
set -g @fzf-goto-session-without-prefix 'true'
```

### Window dimensions

```bash
set -g @fzf-goto-win-width WIDTH
set -g @fzf-goto-win-height HEIGHT
```

> Eg.

```bash
set -g @fzf-goto-win-width 70
set -g @fzf-goto-win-height 20
```

## Tips

### Use in command line

```bash
function tmuxSessionSwitch() {
  session=$(tmux list-windows -a | fzf | sed 's/: .*//g')
  tmux switch-client -t "$session"
}
```

```bash
function tmux_kill_uname_session() {
  echo "kill all unname tmux session"
  cd /tmp/
  tmux ls | awk '{print $1}' | grep -o '[0-9]\+' >/tmp/killAllUnnameTmuxSessionOutput.sh
  sed -i 's/^/tmux kill-session -t /' killAllUnnameTmuxSessionOutput.sh
  chmod +x killAllUnnameTmuxSessionOutput.sh
  ./killAllUnnameTmuxSessionOutput.sh
  cd -
  tmux ls
}
```

> use with `clear` command is the best

```
alias clear='tmux_kill_uname_session ; clear -x'
```

### Easy to press

- In my use case, I don't use this keybinding for switch sessions, I use `hold space + ;` mapping for `hold Ctrl + a + f`
- How can I use `hold space + ;` mapping?
  -> I use [input remapper](https://github.com/sezanzeb/input-remapper), also you can see [my dotfiles](https://github.com/thuanOwa/dotfiles)

> config in GUI

```python
space: if_single(key(KEY_SPACE), ,timeout=10000)
space + semicolon: KEY_RIGHTCTRL+a+f
```

![input remapper][img_input_remapper]

[img_input_remapper]: ./img/input_remapper.png

## QnA

Why I don't create push request to main repo?

-> "Don't confirm `y` to create a new session". This one different flow from the original repo. So that's why I don't push request into original repo.

Different from https://github.com/rcribbs/tmux-fzf-session-switch ?

1. No confirm y to create new session
1. tmux pop-up
1. Custom key binding, window dimensions
1. session + window search
