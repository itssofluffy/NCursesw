/*
    CNCurseswExtensions.c

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

#include "include/CNCurseswExtensions.h"

bool _initialised = false;

bool ncursesw_setup() {
    if (!_initialised) {
        wa_normal = (attr_t)(1U - 1U);
        wa_attributes = ((attr_t)((~(1U - 1U))) << ((0) + 8));
        wa_standout = ((attr_t)((1U)) << ((8) + 8));
        wa_underline = ((attr_t)((1U)) << ((9) + 8));
        wa_reverse = ((attr_t)((1U)) << ((10) + 8));
        wa_blink = ((attr_t)((1U)) << ((11) + 8));
        wa_dim = ((attr_t)((1U)) << ((12) + 8));
        wa_bold = ((attr_t)((1U)) << ((13) + 8));
        wa_altcharset = ((attr_t)((1U)) << ((14) + 8));
        wa_invis = ((attr_t)((1U)) << ((15) + 8));
        wa_protect = ((attr_t)((1U)) << ((16) + 8));
        wa_horizontal = ((attr_t)((1U)) << ((17) + 8));
        wa_left = ((attr_t)((1U)) << ((18) + 8));
        wa_low = ((attr_t)((1U)) << ((19) + 8));
        wa_right = ((attr_t)((1U)) << ((20) + 8));
        wa_top = ((attr_t)((1U)) << ((21) + 8));
        wa_vertical = ((attr_t)((1U)) << ((22) + 8));
        wa_italic = ((attr_t)((1U)) << ((23) + 8));

        _initialised = true;
    }

    return _initialised;
};
