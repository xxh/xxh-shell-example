#!/bin/bash
#
# Entrypoint script should be pure bash.
#

#
# Support arguments (this recommend but not required):
#   -f <file>               Execute file on host, print the result and exit
#   -c <command>            [Not recommended to use] Execute command on host, print the result and exit
#   -C <command in base64>  Execute command on host, print the result and exit
#   -v <level>              Verbose mode: 1 - verbose, 2 - super verbose
#   -e <NAME=B64> -e ...    Environement variables (B64 is base64 encoded string)
#   -b <BASE64> -b ...      Base64 encoded bash command
#
while getopts f:c:C:v:e:b: option
do
case "${option}"
in
f) EXECUTE_FILE=${OPTARG};;
c) EXECUTE_COMMAND=${OPTARG};;
C) EXECUTE_COMMAND_B64=${OPTARG};;
v) VERBOSE=${OPTARG};;
e) ENV+=("$OPTARG");;
b) EBASH+=("$OPTARG");;
esac
done

if [[ $VERBOSE != '' ]]; then
  export XXH_VERBOSE=$VERBOSE
fi

for env in "${ENV[@]}"; do
  name="$( cut -d '=' -f 1 <<< "$env" )";
  val="$( cut -d '=' -f 2- <<< "$env" )";
  val=`echo $val | base64 -d`

  if [[ $XXH_VERBOSE == '1' || $XXH_VERBOSE == '2' ]]; then
    echo Environment variable "$env": name=$name, value=$val
  fi

  export $name="$val"
done

for eb in "${EBASH[@]}"; do
  bash_command=`echo $eb | base64 -d`

  if [[ $XXH_VERBOSE == '1' || $XXH_VERBOSE == '2' ]]; then
    echo Entrypoint bash execute: $bash_command
  fi
  eval $bash_command
done

## Example disabling option:
#if [[ $EXECUTE_COMMAND ]]; then
#  echo '<THIS> entrypoint is not support command execution.'
#  exit 1
#fi

## Example command:
if [[ $EXECUTE_COMMAND ]]; then
  EXECUTE_COMMAND=(-c "${EXECUTE_COMMAND}")
fi

if [[ $EXECUTE_COMMAND_B64 ]]; then
  EXECUTE_COMMAND=`echo $EXECUTE_COMMAND_B64 | base64 -d`
  if [[ $XXH_VERBOSE == '1' || $XXH_VERBOSE == '2' ]]; then
    echo Execute command base64: $EXECUTE_COMMAND_B64
    echo Execute command: $EXECUTE_COMMAND
  fi

  EXECUTE_COMMAND=(-c "${EXECUTE_COMMAND}")
fi


if [[ $EXECUTE_FILE ]]; then
  EXECUTE_COMMAND=""
fi

## Example of adding argument `-f` before
#EXECUTE_FILE=`[ $EXECUTE_FILE ] && echo -n "-f $EXECUTE_FILE" || echo -n ""`
#

#
# Move to current directory
#
CURRENT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd $CURRENT_DIR

export XXH_HOME=`readlink -f $CURRENT_DIR/../../../..`
export XDG_CONFIG_HOME=$XXH_HOME/.config
#export HISTORY_FILE=$XXH_HOME/.your_portable_shell_history

#
# Run the portable shell
#
./your_portable_shell

# Example:
# ./your_portable_shell $EXECUTE_FILE "${EXECUTE_COMMAND[@]}"
