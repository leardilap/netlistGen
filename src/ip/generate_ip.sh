#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m'

current_folder=$(pwd)
script_folder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tcl_name="generate_ip.tcl"
tcl_script=$script_folder/$tcl_name

if [ ! -z "$1" ];
then
  fullpath=$1
else
  echo "No file specified"
  return 1
fi

if [ ! -f $fullpath ]; then
  echo "Specified file not found"
  return 1
elif [ ! ${fullpath: -4} == ".xci" ]; then
  echo "Wrong file format, must be *.xci"
  return 1
else
  echo "==== Generating IP output products for the file:"
  if [ $? -eq 0 ]; then
      echo "Path is OK"
  else
      echo "Something strange is with the realpath command"
      return 1
  fi
  echo $fullpath
fi

filename=$(basename $fullpath)

# cd to the ip directory
cd $(dirname $fullpath)

# performing and operation
vivado -mode batch -nolog -nojournal -source $tcl_script -tclargs $filename

if [ $(find . -type f -name "*_viv.edn") 1> /dev/null 2>&1 ];
then
  echo -e "${GREEN}"
  echo -e "${BOLD}==== NOTE: Now include *.edf, *.edn files in your project sythesis as well as the *.vhd for simulation.${NC}"
  ### Remove not relevant files
  #find . -not -name '*.edf' -not -name '*.xci' -not -name '*.vhd' -not -name '*.prj' -not -name '*.edn' -not -name 'synth' -not -name '.' -not -name '..' -print0 | xargs -0 rm -rf --
else
  echo -e "${GREEN}"
  echo -e "${BOLD}==== NOTE: Now include *.edf file in your project sythesis as well as the *.vhd for simulation..${NC}"
  ### Remove not relevant files
  #find . -not -name '*.edf' -not -name '*.xci' -not -name '*.vhd' -not -name '*.prj' -not -name '.' -not -name '..' -print0 | xargs -0 rm -rf --
fi


# go to previous directory
cd $current_folder

echo "==== Done"


