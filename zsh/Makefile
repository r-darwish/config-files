# Compiler and flags
ANTIDOTE = antidote
ANTIDOTE_FLAGS = 
ANTIDOTE_FILE = antidote/antidote.zsh

# Source and object file lists
SOURCES = $(wildcard *.txt)
OBJECTS = $(SOURCES:.txt=.zsh)

# Main target
all: $(OBJECTS)

.PHONY: all clean antidote
~/.antidote:
	git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote

# Rule for building .zsh files from .txt files
%.zsh: %.txt
	zsh -c "source ~/.antidote/antidote.zsh; $(ANTIDOTE) bundle $(ANTIDOTE_FLAGS) <$< > $@"

# Clean target
clean:
	rm -f $(OBJECTS)
