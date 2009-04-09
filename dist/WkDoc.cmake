# 
# Copyright (c) 2009, Asmodehn's Corp.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without 
# modification, are permitted provided that the following conditions are met:
# 
#     * Redistributions of source code must retain the above copyright notice, 
#	    this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#		notice, this list of conditions and the following disclaimer in the 
#	    documentation and/or other materials provided with the distribution.
#     * Neither the name of the Asmodehn's Corp. nor the names of its 
#	    contributors may be used to endorse or promote products derived
#	    from this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
# THE POSSIBILITY OF SUCH DAMAGE.
#

macro( WKDoc )
FIND_PACKAGE(Doxygen)

IF (DOXYGEN_FOUND)

  # click+jump in Emacs and Visual Studio (for doxy.config) (jw)
  IF    (CMAKE_BUILD_TOOL MATCHES "(msdev|devenv)")
    SET(DOXY_WARN_FORMAT "\"$file($line) : $text \"")
  ELSE  (CMAKE_BUILD_TOOL MATCHES "(msdev|devenv)")
    SET(DOXY_WARN_FORMAT "\"$file:$line: $text \"")
  ENDIF (CMAKE_BUILD_TOOL MATCHES "(msdev|devenv)")
  
  # we need latex for doxygen because of the formulas
  FIND_PACKAGE(LATEX)
  IF    (NOT LATEX_COMPILER)
    MESSAGE(STATUS "latex command LATEX_COMPILER not found but usually required. You will probably get warnings and user inetraction on doxy run.")
  ENDIF (NOT LATEX_COMPILER)
  IF    (NOT MAKEINDEX_COMPILER)
    MESSAGE(STATUS "makeindex command MAKEINDEX_COMPILER not found but usually required.")
  ENDIF (NOT MAKEINDEX_COMPILER)
  IF    (NOT DVIPS_CONVERTER)
    MESSAGE(STATUS "dvips command DVIPS_CONVERTER not found but usually required.")
  ENDIF (NOT DVIPS_CONVERTER)
  
if (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/doc/Doxyfile" )
	message( STATUS "Using existing ${CMAKE_CURRENT_SOURCE_DIR}/doc/Doxyfile" )
	# use static hand-edited Doxyfile :
	CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/doc/Doxyfile ${CMAKE_CURRENT_BINARY_DIR}/doc/Doxyfile @ONLY )
elseif (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/CMake/Doxyfile.wk" )
	message( STATUS "Configuring Template ${CMAKE_CURRENT_SOURCE_DIR}/CMake/Doxyfile.wk --> ${CMAKE_CURRENT_BINARY_DIR}/doc/Doxyfile" )
	# use template to generate Doxyfile :
	CONFIGURE_FILE(${CMAKE_CURRENT_SOURCE_DIR}/CMake/Doxyfile.wk ${CMAKE_CURRENT_BINARY_DIR}/doc/Doxyfile @ONLY )
else (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/doc/Doxyfile" )
	# failed completely...
    message(SEND_ERROR "Please create ${CMAKE_CURRENT_SOURCE_DIR}/doc/Doxyfile or check that ${CMAKE_CURRENT_SOURCE_DIR}/CMake/Doxyfile.wk template exists")
endif(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/doc/Doxyfile" )
	 
  ADD_CUSTOM_TARGET(doc ${DOXYGEN_EXECUTABLE} "${CMAKE_CURRENT_BINARY_DIR}/doc/Doxyfile" )
  
ENDIF(DOXYGEN_FOUND)

endmacro( WKDoc )
