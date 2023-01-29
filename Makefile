# Automatically Generated Makefile by EDE.
# For use with: make
#
# DO NOT MODIFY THIS FILE OR YOUR CHANGES MAY BE LOST.
# EDE is the Emacs Development Environment.
# http://cedet.sourceforge.net/ede.shtml
#

require=$(foreach r,$(1),(require (quote $(r))))
EMACSFLAGS=-batch --no-site-file --eval '(setq debug-on-error t)' 
# EMACS=@echo "    > $@";emacs
EMACS=emacs

LOADPATH= ./

# wy_SEMANTIC_GRAMMAR=java.wy java-tags.wy thrift.wy
wy_SEMANTIC_GRAMMAR=thrift.wy
VERSION=1.1beta

.PHONY: all
all: wy 

%-wy.el: %.wy
	$(EMACS) $(EMACSFLAGS) $(addprefix -L ,$(LOADPATH)) --eval '(progn $(call require,$(PRELOADS)))' -f semantic-grammar-batch-build-packages $^

.PHONY: wy
wy: $(addsuffix -wy.elc, $(basename $(wy_SEMANTIC_GRAMMAR)))
wy: $(addsuffix -wy.el, $(basename $(wy_SEMANTIC_GRAMMAR)))
wy: PRELOADS=semantic/grammar semantic/bovine/grammar semantic/wisent/grammar

wy: EMACSFLAGS+= --eval '(setq max-specpdl-size 1500 max-lisp-eval-depth 700 wisent-verbose-flag t)'
%.elc: %.el
	$(EMACS) $(EMACSFLAGS) $(addprefix -L ,$(LOADPATH)) --eval '(progn $(call require, $(PRELOADS)))' -f batch-byte-compile $^

# .PHONY: test
# test: wy
# test: PRELOADS=calc calc-wy
# test:
# 	$(EMACS) $(EMACSFLAGS) $(addprefix -L ,$(LOADPATH)) --eval '(progn $(call require, $(PRELOADS)))' -f wisent-calc-utest $^

.PHONY: clean
clean:
	rm -f *-by.el *-wy.el *.elc wisent.output

# End of Makefile
