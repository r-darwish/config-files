winget install microsoft.powershell Git.Git starship neovim junegunn.fzf lazygit OpenJS.NodeJS peazip yazi sharkdp.fd ripgrep python3 zoxide eza-community.eza dandavison.delta

New-Item -ItemType SymbolicLink -Path "~\.gitconfig" -Target "$pwd\.gitconfig"
git config --global core.sshCommand 'C:\\Windows\\System32\\OpenSSH\\ssh.exe'
