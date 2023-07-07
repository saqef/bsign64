/* standard.h							-*- C++ -*-
     $Id: standard.h,v 1.3 2002/01/18 01:06:46 elf Exp $

   written by Oscar Levi
   21 November 1998

   This file is part of the project BSIGN.  See the file README for
   more information.

   Copyright (C) 1998 The Buici Company

   This program is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public License as
   published by the Free Software Foundation; either version 2 of the
   License, or (at your option) any later version.

   This program is distributed in the hope that it will be useful, but
   WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   General Public License for more details.

   You should have received a copy of the GNU General Public License
   in a file called COPYING along with this program; if not, write to
   the Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA
   02139, USA.

   -----------
   DESCRIPTION
   -----------

   Standard Header inclusion for all files in the project.  This
   inclusion ought (dare I say MUST) be first.

*/

#if !defined(__STANDARD_H__)
#define __STANDARD_H__

/* ----- Includes */

// #include "build.h"		// Build parameters, always first

#include "config.h" // Autoconf configuration header

// #include "debug.h"		// Our local debug code

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <memory.h>
#include <string.h>

#include <ctype.h>
#if defined(HAVE_MALLOC_H)
#include <malloc.h>
#endif

// #include "porting.h"

#if !defined(__CONSTVALUE)
#define __CONSTVALUE __const
#endif

// ----- Typedefs

typedef unsigned char byte;
typedef signed char int8;
typedef unsigned char unsigned8;
typedef short int16;
typedef unsigned short unsigned16;

#if SIZEOF_INT == 4
typedef signed int int32;
typedef unsigned int unsigned32;
#elif SIZEOF_LONG == 4
typedef signed long int32;
typedef unsigned long unsigned32;
#endif

#if SIZEOF_LONG == 8
typedef signed long int64;
typedef unsigned long unsigned64;
#elif SIZEOF_LONG_LONG == 8
typedef signed long long int64;
typedef unsigned long long unsigned64;
#endif

#endif /* __STANDARD_H__ */
