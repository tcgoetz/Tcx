
include defines.mk


all: deps

test:
	$(MAKE) -C test

flake8:
	flake8 *.py --max-line-length=180 --ignore=E203,E221,E241,W503

deps:
	$(PIP) install $(PIP_INSTALL_OPT) --upgrade --requirement requirements.txt
	$(PIP) install $(PIP_INSTALL_OPT) --upgrade --requirement dev-requirements.txt

remove_deps:
	$(PIP) uninstall -y --requirement requirements.txt
	$(PIP) uninstall -y --requirement dev-requirements.txt

clean:
	rm -f *.pyc
	rm -rf __pycache__

.PHONY: all deps remove_deps clean test
