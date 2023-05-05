# Minimal makefile for Typst documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
TYPSTOPTS    ?=
TYPSTBUILD   ?= typst
SOURCEDIR     = src
BUILDDIR      = build
MAINFILE      = main.typ

# Put it first so that "make" without argument is like "make help".
help:
	@$(TYPSTBUILD) help

.PHONY: help Makefile

# Catch-all target: route all unknown commands to Typst using the new
# "make mode" option.  $(O) is meant as a shortcut for $(TYPSTOPTS).
%: Makefile
	@$(TYPSTBUILD) $@ "$(SOURCEDIR)/$(MAINFILE)" "$(BUILDDIR)" $(TYPSTOPTS) $(O)
