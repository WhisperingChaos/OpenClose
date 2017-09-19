##!/bin/bash
#
##############################################################################
##
##  Puropse:
##    Help implement Open-Close mechanism for bash files - open for extension,
##    closed for modification.  Changes the PATH for the executing script and
##    its child processes to include all directories from which to load 
##    all modules needed to compose the initial and secondary scripts.  This
##    permits changing the behavior of the application by simply changing
##    the order of how overriding modules are found by searching the PATH.
##
###############################################################################
path_Set(){
  local -r scriptFilePath="$(readlink -f "$1")"
  local -r scriptDir="$( dirname "$scriptFilePath")"
  # include dependent utilities/libraries in path
  if [ -d "$scriptDir/module" ]; then
    local modDir
    for modDir in $( ls -d "$scriptDir/module"/* ); do
      PATH="$modDir:$PATH"
     done
  fi
  export PATH="$scriptDir:$PATH"
}
path_Set "${BASH_SOURCE[0]}"
