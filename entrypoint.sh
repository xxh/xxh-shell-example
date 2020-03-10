#!/bin/bash
#
# Entrypoint script should be pure bash.
#

#
# Support three arguments (this recommend but not required):
#   -f <file>         Execute file on host, print the result and exit
#   -c <command>      Execute command on host, print the result and exit
#   -v <level>        Verbose mode: 1 - verbose, 2 - super verbose
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

## Example disabling option:
#if [[ $EXECUTE_COMMAND ]]; then
#  echo '<THIS> entrypoint is not support command execution.'
#  exit 1
#fi

## Example command argument:
#if [[ $EXECUTE_COMMAND ]]; then
#  EXECUTE_COMMAND=(-c "${EXECUTE_COMMAND}")
#fi
#
#if [[ $EXECUTE_FILE ]]; then
#  EXECUTE_COMMAND=""
#fi

if [[ $VERBOSE != '' ]]; then
  export XXH_VERBOSE=$VERBOSE
fi

## Example of adding argument `-f` before
#EXECUTE_FILE=`[ $EXECUTE_FILE ] && echo -n "-f $EXECUTE_FILE" || echo -n ""`
#

#
# Move to current directory
#
CURRENT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd $CURRENT_DIR

export XXH_HOME=`realpath -m $CURRENT_DIR/../../../../`

#
# Run the portable shell
#
./your_portable_shell

# Example:
# ./your_portable_shell $EXECUTE_FILE "${EXECUTE_COMMAND[@]}"