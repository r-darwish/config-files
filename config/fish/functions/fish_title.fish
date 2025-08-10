function fish_title
    if set -q SSH_CLIENT
        echo [(hostname)] (pwd): $argv[1]
    else
        echo (pwd): $argv[1]
    end
end
