# Compiler and flags
ANTIBODY = antibody
ANTIBODY_FLAGS = 

# Source and object file lists
SOURCES = $(wildcard *.txt)
OBJECTS = $(SOURCES:.txt=.zsh)

# Main target
all: $(OBJECTS)

# Rule for building .zsh files from .txt files
%.zsh: %.txt
	$(ANTIBODY) bundle $(ANTIBODY_FLAGS) <$< > $@

# Clean target
clean:
	rm -f $(OBJECTS)
