link_config() {
    local source target basename
    source="$PWD/$1"
    basename=$(basename "$1")
    target="$HOME/.config/$basename"
    if [[ $basename == "nushell" && $(uname) == "Darwin" ]]; then
      target="$HOME/Library/Application Support/$basename"
    fi

    if link=$(readlink "$target"); then
        if [[ "$link" == "$source" ]]; then
            echo "Already linked $target"
            return 0
        fi
    fi

    rm -rf "$target"
    ln -s "$source" "$target"
}
