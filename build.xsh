#!/usr/bin/env xonsh

#
# Build script is needed to create `build` directory with all files needed to run portable shell on the host
#

import sys
from shutil import which

def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)

script_dir = pf"{__file__}".absolute().parent
build_dir = script_dir / 'build'
rm -rf @(build_dir)/
mkdir -p @(build_dir)
cd @(build_dir)

if p'your_portable_shell'.exists():
    eprint('SKIP: Portable shell already builded')
else:
    wget https://your_portable_shell