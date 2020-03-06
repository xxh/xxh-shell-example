#!/bin/bash
#
# Entrypoint script should be pure bash.
#

#
# Support three arguments (this recommend but not required):
#   -f <file>         Execute file on host, print the result and exit
#   -c <command>      Execute command on host, print the result and exit
#   -v                Verbose mode to debug
#
while getopts f:c:v: option
do
case "${option}"
in
f) EXECUTE_FILE=${OPTARG};;
c) EXECUTE_COMMAND=${OPTARG};;
v) VERBOSE=${OPTARG};;
esac
done

#
# Move to current directory
#
CURRENT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd $CURRENT_DIR

#
# Run the portable shell
#
./your_portable_shell # $EXECUTE_FILE $EXECUTE_COMMAND $VERBOSE