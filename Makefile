#!/bin/bash

BRANCHES = upstream/master zavulon/pr

all: main
	ls -lt main/dist/*exe | head -2

main: renderer
	cd main && \
	yarn build && \
	CSC_NAME= npx electron-builder build --win=nsis

renderer:
	cd renderer && \
	yarn install && \
	yarn make-index-files && \
	yarn build

install:
	cygstart "`ls -t main/dist/*Setup*exe | head -1`"

update:
	git diff --exit-code
	git fetch --all && \
	git checkout master && \
	git merge -m "Merge branches: $(BRANCHES)" $(BRANCHES)

.PHONY: all renderer main install update
