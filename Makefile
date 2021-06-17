
include defines.mk

MODULE=tcxfile

all: deps

dist: build

publish_check: dist
	$(PYTHON) -m twine check dist/*

publish: publish_check
	$(PYTHON) -m twine upload dist/* --verbose

build:
	$(PYTHON) -m build

install: build
	$(PIP) install --upgrade --force-reinstall ./dist/$(MODULE)-*.whl 

uninstall:
	$(PIP) uninstall -y $(MODULE)

test:
	$(MAKE) -C test

verify_commit: test

flake8:
	$(PYTHON) -m flake8 $(MODULE)/*.py --max-line-length=180 --ignore=E203,E221,E241,W503

deps:
	$(PIP) install --upgrade --requirement requirements.txt

devdeps:
	$(PIP) install --upgrade --requirement dev-requirements.txt

remove_deps:
	$(PIP) uninstall -y --requirement requirements.txt
	$(PIP) uninstall -y --requirement dev-requirements.txt

test_clean:
	$(MAKE) -C test clean

clean: test_clean
	rm -f *.pyc
	rm -rf __pycache__
	rm -rf *.egg-info
	rm -rf dist
	rm -rf build

.PHONY: all deps remove_deps clean test verify_commit install uninstall dist build publish_check publish
