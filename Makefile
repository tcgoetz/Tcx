
#
# What python are we using?
#
PYTHON2=/usr/bin/python
#PYTHON3=/usr/bin/python3
PYTHON3=/usr/local/bin/python3
#PYTHON=${PYTHON2}
PYTHON=${PYTHON3}

PIP3=/usr/local/bin/pip3
PIP=${PIP3}
export PYTHON PIP


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

.PHONY: all deps remove_deps clean
