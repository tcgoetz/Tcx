
include defines.mk


all: deps

test:
	$(MAKE) -C test

deps:
	$(PIP) install --user --upgrade --requirement requirements.txt

remove_deps:
	$(PIP) uninstall --requirement requirements.txt

clean:
	rm -f *.pyc
	rm -rf __pycache__

.PHONY: all deps remove_deps clean test
