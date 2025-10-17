#!/usr/bin/env fish

set gen_file "$HOME/.gen.fish"

echo "" >$gen_file
if type -q starship
    starship init fish >>$gen_file
    echo "" >>$gen_file
end

if type -q zoxide
    zoxide init fish >>$gen_file
    echo "" >>$gen_file
end

if type -q vivid
    echo "export LS_COLORS='$(vivid generate tokyonight-night)'" >>$gen_file
    echo "" >>$gen_file
end

if test -d "$HOME/wiz-sec/darwish"
    echo "source $HOME/wiz-sec/darwish/config.fish" >>$gen_file
end
