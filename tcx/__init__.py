"""library for reading and writing TCX files."""

__author__ = "Tom Goetz"
__copyright__ = "Copyright Tom Goetz"
__license__ = "GPL"

# flake8: noqa

from .version_info import version_string

__version__ = version_string()

from .tcx import Tcx
