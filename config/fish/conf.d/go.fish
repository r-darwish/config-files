if test -d ~/go/bin
    fish_add_path --path ~/go/bin
end

function godbg -d "Debug go"
    dlv debug --headless -l 127.0.0.1:31337 $argv
end

alias tidy="go mod tidy"
