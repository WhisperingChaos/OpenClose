#!/bin/bash
#
###############################################################################
##
##  Puropse:
##    Implement Open-Close mechanism for bash files - open for extension,
##    closed for modification.  Leverages function override behavior where
##    the last bash function definition having the same name as a prior
##    function, will replace the prior function's definition. 
##
##    Encourages other installations using base scripts to encode their
##    own local customizations without concern that these customizations
##    will be overwritten by a new release of the base project code.
##
###############################################################################

###############################################################################
##
##  Purpose:
##    Implement a function override mechanism for bash scripts that are 
##    directly invoked by their name, creating their own command shell -
##    'mainline' programs.
##
###############################################################################
FunctionOverrideCommandGet (){
  FunctionOverrideIncludeSource "$0"
}
###############################################################################
##
##  Purpose:
##    Implement a function override mechanism for bash scripts that are included, 
##    using the 'source' keyword into the command shell that serves
##    as a 'mainline' program/shell.
##
##  Assume:
##    >  At the time the source is included, that there is only a single
##       layer of source between the invocation of this function and its
##       definition in this file, as more than one level will cause 
##       the reference of ${BASH_SOURCE[1]} to incorrectly resolve 
##       to one of these intermediate layers.
##
###############################################################################
FunctionOverrideIncludeGet (){
  FunctionOverrideIncludeSource "${BASH_SOURCE[1]}"
}
###############################################################################
##
##  Purpose:
##    Implement a function override mechanism so others can repair and
##    extend the behavior of all bash source inculded in this product without
##    having to apply changes directly to the files that contain the code.
##    
##
##  Note:
##    >  This function should not be directly called, instead, one of the
##       functions above, that call this routine should be called.
##    >  The files containing the source need not exist as their non-existence
##       will be suppressed.
##    >  Override code must be stored in file prefixed with the file name
##       targeted whose functions are targeted for replacement and suffixed
##       by "Override.sh".  Permits clear delineation between base and override
##       code and can allow override code to exist in same directory as base code
##       which should be generally avoided.
##
##  Assume:
##    >  All source module names in the project are unique.
##    >  All extension modules must be placed in their appropriate directories.
##       Otherwise, overriding mechanism may fail.
##    >  The PATH variable has been properly established to include all
##       extension directories in appropriate search order.  N levels of
##       override directories can be implemented.  Just need to ensure that
##       searching the PATH variable finds the correct override instance 
##       before the others.  This can be considered a weakness of this
##       approach.
##
##  Input:
##    $1 - file name of bash module to extend.
##
##  Ouptut:
##    STDERR - All messages generated while including the source should
##        appear in STDERR except for "not exist"
##    STDOUT - All messages generated while including the source 
##        that are written SYSOUT.
##
###############################################################################
FunctionOverrideIncludeSource (){
  local -r functionOverrideName="`basename "$1" .sh`"
  source "${functionOverrideName}Override.sh" 2> >( grep -v '.*FunctionInclude.sh:.*: No such file or directory'>&2)
}
# override the override
FunctionOverrideIncludeGet

###############################################################################
# 
# The MIT License (MIT)
# Copyright (c) 2014-2017 Richard Moyse License@Moyse.US
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
###############################################################################
