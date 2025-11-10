export PROJECT_BASE=$(CURDIR)
export VENV=$(PROJECT_BASE)/../.venv

include defines.mk

$(info $$PROJECT_BASE is [${PROJECT_BASE}])
$(info $$VENV is [${VENV}])
$(info $$PLATFORM is [${PLATFORM}])
$(info $$SHELL is [${SHELL}])

export PIP_PATH=$(VENV)/bin/$(PIP)
$(info $$PIP_PATH is [${PIP_PATH}])
export PYTHON_PATH=$(VENV)/bin/$(PYTHON)
$(info $$PYTHON_PATH is [${PYTHON_PATH}])

all: deps

publish_check: build
	$(PYTHON_PATH) -m twine check dist/*

publish: clean publish_check
	$(PYTHON_PATH) -m twine upload dist/* --verbose

build:
	$(PYTHON_PATH) -m build

$(PROJECT_BASE)/dist/$(MODULE)-*.whl: build

install: $(PROJECT_BASE)/dist/$(MODULE)-*.whl
	$(PIP_PATH) install --upgrade --force-reinstall $(PROJECT_BASE)/dist/$(MODULE)-*.whl 

install_pip:
	$(PIP_PATH) install --upgrade --force-reinstall tcxfile

uninstall:
	$(PIP_PATH) uninstall -y $(MODULE)

reinstall: clean uninstall install

test:
	$(MAKE) -C test

verify_commit: test

flake8:
	$(PYTHON_PATH) -m flake8 $(MODULE)/*.py --max-line-length=180 --ignore=E203,E221,E241,W503

deps:
	$(PIP_PATH) install --upgrade --requirement requirements.txt

devdeps:
	$(PIP_PATH) install --upgrade --requirement dev-requirements.txt

remove_deps:
	$(PIP_PATH) uninstall -y --requirement requirements.txt
	$(PIP_PATH) uninstall -y --requirement dev-requirements.txt

test_clean:
	$(MAKE) -C test clean

clean: test_clean
	echo "Cleaning Tcx"
	rm -f *.pyc
	rm -rf __pycache__
	rm -rf *.egg-info
	rm -rf dist
	rm -rf build

merge_develop:
	git fetch --all && git merge remotes/origin/develop

.PHONY: all deps remove_deps clean test verify_commit install uninstall dist build publish_check publish merge_develop
