#
# This Makefile automates running tests for the project.
#

PROJECT_BASE ?= $(CURDIR)/..

PYTHON=python3
export PYTHONPATH=${PROJECT_BASE}:${PROJECT_BASE}/..


ALL_TEST_GROUPS=loop read

#
# Over all targets
#
all: $(ALL_TEST_GROUPS)

clean:
	rm -f *.pyc
	rm -f *.log
	rm -f *.txt
	rm -rf __pycache__

#
# Targets for testing smaller slices of functionality.
#
$(ALL_TEST_GROUPS):
	$(PYTHON_PATH) test_$@.py

.PHONY: all db file_parse
