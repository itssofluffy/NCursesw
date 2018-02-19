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

#ifndef _CNCURSESWEXTENSIONS_H
#define _CNCURSESWEXTENSIONS_H

#include <ctype.h>
#include <locale.h>

#include <ncurses.h>

bool ncursesw_setup();
bool valid_terminal_capability(const char *);

attr_t wa_attributes;            // attributes
attr_t wa_normal;                // normal attribute
attr_t wa_standout;              // standout attribute
attr_t wa_underline;             // underline attribute
attr_t wa_reverse;               // reverse attribute
attr_t wa_blink;                 // blink attribute
attr_t wa_dim;                   // dim attribute
attr_t wa_bold;                  // bold attribute
attr_t wa_altcharset;            // alternate character set attribute
attr_t wa_invis;                 // invisible attribute
attr_t wa_protect;               // protect attribute
attr_t wa_horizontal;            // horizontal attribute
attr_t wa_left;                  // left attribute
attr_t wa_low;                   // low attribute
attr_t wa_right;                 // right attribute
attr_t wa_top;                   // top attribute
attr_t wa_vertical;              // vertical attribute
attr_t wa_italic;                // italic attribute

mmask_t button1_released;        // mouse button 1 up
mmask_t button1_pressed;         // mouse button 1 down
mmask_t button1_clicked;         // mouse button 1 clicked
mmask_t button1_double_clicked;  // mouse button 1 double clicked
mmask_t button1_triple_clicked;  // mouse button 1 triple clicked

mmask_t button2_released;        // mouse button 2 up
mmask_t button2_pressed;         // mouse button 2 down
mmask_t button2_clicked;         // mouse button 2 clicked
mmask_t button2_double_clicked;  // mouse button 2 double clicked
mmask_t button2_triple_clicked;  // mouse button 2 triple clicked

mmask_t button3_released;        // mouse button 3 up
mmask_t button3_pressed;         // mouse button 3 down
mmask_t button3_clicked;         // mouse button 3 clicked
mmask_t button3_double_clicked;  // mouse button 3 double clicked
mmask_t button3_triple_clicked;  // mouse button 3 triple clicked

mmask_t button4_released;        // mouse button 4 up
mmask_t button4_pressed;         // mouse button 4 down
mmask_t button4_clicked;         // mouse button 4 clicked
mmask_t button4_double_clicked;  // mouse button 4 double clicked
mmask_t button4_triple_clicked;  // mouse button 4 triple clicked

#if NCURSES_MOUSE_VERSION > 1
mmask_t button5_released;        // mouse button 5 up
mmask_t button5_pressed;         // mouse button 5 down
mmask_t button5_clicked;         // mouse button 5 clicked
mmask_t button5_double_clicked;  // mouse button 5 double clicked
mmask_t button5_triple_clicked;  // mouse button 5 triple clicked
#else
mmask_t button1_reserved_event;  // mouse button 1 reserved event
mmask_t button2_reserved_event;  // mouse button 2 reserved event
mmask_t button3_reserved_event;  // mouse button 3 reserved event
mmask_t button4_reserved_event;  // mouse button 4 reserved event
#endif

mmask_t button_shift;            // shift was down during button state change
mmask_t button_ctrl;             // control was down during button state change
mmask_t button_alt;              // alt was down during button state change
mmask_t all_mouse_events;        // report all button state changes

mmask_t report_mouse_position;   // report mouse movement
#endif
