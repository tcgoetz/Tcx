"""library for reading and writing TCX files."""

import re
import os
from setuptools import setup


def get_version(version_file):
    """Extract version fron module source."""
    with open(version_file, 'r') as file:
        data = file.read()
        match = re.search(r'version_info = \((\d), (\d), (\d)\)', data, re.M)
        if match:
            return f'{match.group(1)}.{match.group(2)}.{match.group(3)}'


module_name = 'tcx'
module_version = get_version(module_name + os.sep + 'version_info.py')

setup(name=module_name, version=module_version, author='Tom Goetz', packages=[module_name], license=open('LICENSE').read(), description='Read and write Tcx format files.',
      install_requires=open('requirements.txt').readlines(),
      url="https://github.com/tcgoetz/Tcx", python_requires=">=3.0")
