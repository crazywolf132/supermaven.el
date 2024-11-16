# Supermaven for Emacs

Supermaven is an AI-powered code completion plugin for Emacs, converted from the official [Supermaven Neovim plugin](https://github.com/supermaven-inc/supermaven-nvim).

## Features

- AI-powered code completion
- Real-time suggestions as you type
- Support for multiple programming languages
- Customizable keybindings
- Integrated logging system
- Free and Pro versions available

## Installation

### Standard Emacs

1. Clone this repository:
   ```
   git clone https://github.com/crazywolf132/supermaven.el.git ~/.emacs.d/supermaven
   ```

2. Add the following to your Emacs configuration file (e.g., `~/.emacs` or `~/.emacs.d/init.el`):
   ```elisp
   (add-to-list 'load-path "~/.emacs.d/supermaven")
   (require 'supermaven)
   (add-hook 'prog-mode-hook 'supermaven-mode)
   ```

### DOOM Emacs

1. Add the following to your `~/.doom.d/packages.el`:
   ```elisp
   (package! supermaven
     :recipe (:host github :repo "crazywolf132/supermaven.el"))
   ```

2. Add the following to your `~/.doom.d/config.el`:
   ```elisp
   (use-package! supermaven
     :hook (prog-mode . supermaven-mode))
   ```

3. Run `doom sync` to install the package.

## Configuration

You can customize Supermaven by setting variables in your Emacs configuration file:

```elisp
(setq supermaven-ignore-filetypes '("org" "txt"))
(setq supermaven-disable-inline-completion nil)
(setq supermaven-keymaps
      '((accept-suggestion . "TAB")
        (clear-suggestion . "C-]")
        (accept-word . "C-j")))
(setq supermaven-log-level 'debug)
(setq supermaven-agent-version 26)
```

Note: When you change the agent-version (either because the lastest has changed or because you did set `supermaven-agent-version`) you probably need to delete `~/.supermaven/config.json` and run `supermaven-use-pro` again to link the current version of sm-agent to your account.

## Usage

Once installed and configured, Supermaven will automatically provide suggestions as you type in supported file types. Use the configured keybindings to interact with suggestions:

- `TAB` (default): Accept the current suggestion
- `C-]` (default): Clear the current suggestion
- `C-j` (default): Accept the next word of the suggestion

## Commands

- `M-x supermaven-start`: Start the Supermaven process
- `M-x supermaven-stop`: Stop the Supermaven process
- `M-x supermaven-restart`: Restart the Supermaven process
- `M-x supermaven-toggle`: Toggle Supermaven on/off
- `M-x supermaven-use-free-version`: Switch to the free version
- `M-x supermaven-use-pro`: Switch to the pro version (requires activation)
- `M-x supermaven-logout`: Log out from Supermaven
- `M-x supermaven-show-log`: Show the Supermaven log buffer
- `M-x supermaven-clear-log`: Clear the Supermaven log buffer

## Customization

### Changing Keybindings

You can modify the keybindings by setting the `supermaven-keymaps` variable:

```elisp
(setq supermaven-keymaps
      '((accept-suggestion . "C-<return>")
        (clear-suggestion . "C-c C-c")
        (accept-word . "M-<right>")))
```

### Ignoring File Types

To ignore certain file types, set the `supermaven-ignore-filetypes` variable:

```elisp
(setq supermaven-ignore-filetypes '("org" "txt" "md"))
```

### Changing Log Level

Modify the log level by setting the `supermaven-log-level` variable:

```elisp
(setq supermaven-log-level 'debug)  ; Options: off, error, warn, info, debug, trace
```

### Disabling Inline Completion

To disable inline completion, set the `supermaven-disable-inline-completion` variable:

```elisp
(setq supermaven-disable-inline-completion t)
```

## Troubleshooting

### Supermaven is not providing suggestions

1. Ensure that `supermaven-mode` is enabled for your buffer.
2. Check if the current file type is in the `supermaven-ignore-filetypes` list.
3. Verify that the Supermaven process is running with `M-x supermaven-start`.
4. Check the Supermaven log buffer for any error messages.

### Keybindings are not working

1. Make sure you've set up the keybindings correctly in your configuration.
2. Check if there are any conflicting keybindings in your Emacs configuration or other packages.

### Supermaven is slow or unresponsive

1. Check your internet connection, as Supermaven requires an active connection to function.
2. Try restarting the Supermaven process with `M-x supermaven-restart`.
3. Increase the log level to debug and check the log buffer for any issues.

## Contributing

Contributions to Supermaven for Emacs are welcome! Please feel free to submit pull requests, create issues or spread the word.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- Original Supermaven Neovim plugin developers
- The Emacs community for their invaluable resources and documentation
