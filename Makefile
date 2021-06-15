
include defines.mk


all: deps

install:
	python3 setup.py install

uninstall:
	$(PIP) uninstall -y Tcx

test:
	$(MAKE) -C test

verify_commit: test

flake8:
	python3 -m flake8 tcx/*.py --max-line-length=180 --ignore=E203,E221,E241,W503

deps:
	$(PIP) install --upgrade --requirement requirements.txt
	$(PIP) install --upgrade --requirement dev-requirements.txt

remove_deps:
	$(PIP) uninstall -y --requirement requirements.txt
	$(PIP) uninstall -y --requirement dev-requirements.txt

clean:
	rm -f *.pyc
	rm -rf __pycache__
	rm -rf Tcx.egg-info
	rm -rf dist
	rm -rf build

.PHONY: all deps remove_deps clean test verify_commit
