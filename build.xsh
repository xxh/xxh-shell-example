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

cp @(script_dir / 'entrypoint.sh') @(build_dir)/

cd @(build_dir)
if p'your_portable_shell'.exists():
    eprint('SKIP: Portable shell already builded')
else:
    shell_url='...'
    eprint(f'Download <your_portable_shell> from {shell_url}')
    if which('wget'):
        r =![wget -q --show-progress @(shell_url) -O your_portable_shell]
        if r.returncode != 0:
            eprint(f'Error while download using wget: {r}')
            exit(1)
    elif which('curl'):
        r =![curl -L @(shell_url) -o your_portable_shell]
        if r.returncode != 0:
            eprint(f'Error while download using curl: {r}')
            exit(1)