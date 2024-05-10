# Ancient Makefile implicit rule disabler
(%): %
%:: %,v
%:: RCS/%,v
%:: s.%
%:: SCCS/s.%
%.out: %
%.c: %.w %.ch
%.tex: %.w %.ch
%.mk:

# Variables
BRANCH := main
INTERACTIVE := $(shell test -t 0 && echo 1)
ifdef INTERACTIVE
    RED	:= \033[0;31m
    YELLOW := \033[0;33;1m
    END	:= \033[0m
else
    RED	:=
    END	:=
endif

# Let there be no default target
.PHONY: help
help:
	@echo "${RED}Help info: the following commands are supported:${END}"
	@echo "init      - will git checkout each submodule to the tracked"
	@echo "            commit (resulting in a git detached HEAD)"
	@echo "checkout  - will checkout the suppllied branch (via the"
	@echo "            syntax BRANCH=main) ignoring submodule errors"
	@echo "            if the branch does not exist"
	@echo "status    - will print the git status for all the repos"
	@echo "4e        - will exec 'git submodule foreach git \$$CMD'"
	@echo "etags     - constructs an emacs tags table"
	@echo ""

# checkout the latest on main on all the submodules
.PHONY: init
init:
	git submodule update --init --merge --remote --recursive

.PHONY: checkout 4e
checkout:
	git submodule foreach "git checkout ${BRANCH} || :"
4e:
	git submodule foreach git ${CMD}

.PHONY: status
status:
	@echo "${RED}VTP-dev-env${END}\n`git remote get-url origin`\n`git branch --show-current`\n`git status -s`"
	@git submodule --quiet foreach 'echo "${RED}$${name}${END}" && git remote get-url origin && git branch --show-current && git status -s'

# emacs tags
ETAG_SRCS := $(shell find * -type f -name '*.py' -o -name '*.md' | grep -v defunct)
.PHONY: etags
etags: ${ETAG_SRCS}
	etags ${ETAG_SRCS}
