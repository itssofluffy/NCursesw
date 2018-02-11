/*
    CNCurseswExtensions.h

    Copyright (c) 2018 Stephen Whittle  All rights reserved.

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"),
    to deal in the Software without restriction, including without limitation
    the rights to use, copy, modify, merge, publish, distribute, sublicense,
    and/or sell copies of the Software, and to permit persons to whom
    the Software is furnished to do so, subject to the following conditions:
    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
    THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
    IN THE SOFTWARE.
*/

#define _XOPEN_SOURCE_EXTENDED 1

#ifndef _CNCURSESW_H
#define _CNCURSESW_H

#include <ctype.h>
#include <locale.h>

#include <ncurses.h>

bool ncursesw_setup();

attr_t wa_attributes;
attr_t wa_normal;
attr_t wa_standout;
attr_t wa_underline;
attr_t wa_reverse;
attr_t wa_blink;
attr_t wa_dim;
attr_t wa_bold;
attr_t wa_altcharset;
attr_t wa_invis;
attr_t wa_protect;
attr_t wa_horizontal;
attr_t wa_left;
attr_t wa_low;
attr_t wa_right;
attr_t wa_top;
attr_t wa_vertical;
attr_t wa_italic;
#endif
