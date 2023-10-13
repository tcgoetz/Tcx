export PROJECT_BASE=$(CURDIR)

include defines.mk

all: deps

publish_check: build
	$(PYTHON) -m twine check dist/*

publish: clean publish_check
	$(PYTHON) -m twine upload dist/* --verbose

build:
	$(PYTHON) -m build

$(PROJECT_BASE)/dist/$(MODULE)-*.whl: build

install: $(PROJECT_BASE)/dist/$(MODULE)-*.whl
	$(PIP) install --upgrade --force-reinstall $(PROJECT_BASE)/dist/$(MODULE)-*.whl 

install_pip:
	$(PIP) install --upgrade --force-reinstall tcxfile

uninstall:
	$(PIP) uninstall -y $(MODULE)

reinstall: clean uninstall install

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
