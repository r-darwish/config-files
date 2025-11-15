winget install microsoft.powershell Git.Git starship neovim junegunn.fzf lazygit OpenJS.NodeJS peazip yazi sharkdp.fd ripgrep python3 zoxide eza-community.eza dandavison.delta alexx2000.DoubleCommander Microsoft.Sysinternals.Suite

New-Item -ItemType SymbolicLink -Path "~\.gitconfig" -Target "$pwd\.gitconfig"
git config --global core.sshCommand 'C:\\Windows\\System32\\OpenSSH\\ssh.exe'

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
pwsh -c "Install-Module PSFzf,Microsoft.WinGet.Client,Microsoft.Powershell.ConsoleGuiTools"
