/*
    ncursesw_setup.c

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

attr_t  ncurses_bits(unsigned, int);
mmask_t ncurses_mouse_mask(mmask_t, mmask_t);

bool _initialised = false;

bool ncursesw_setup() {
    if (!_initialised) {
        wa_attributes          = ncurses_bits(~(1U - 1U), 0);                     // Equivalent of complex macro WA_ATTRIBUTES
        wa_normal              = (1U - 1U);                                       // Equivalent of complex macro WA_NORMAL
        wa_standout            = ncurses_bits(1U, 8);                             // Equivalent of complex macro WA_STANDOUT
        wa_underline           = ncurses_bits(1U, 9);                             // Equivalent of complex macro WA_UNDERLINE
        wa_reverse             = ncurses_bits(1U, 10);                            // Equivalent of complex macro WA_REVERSE
        wa_blink               = ncurses_bits(1U, 11);                            // Equivalent of complex macro WA_BLINK
        wa_dim                 = ncurses_bits(1U, 12);                            // Equivalent of complex macro WA_DIM
        wa_bold                = ncurses_bits(1U, 13);                            // Equivalent of complex macro WA_BOLD
        wa_altcharset          = ncurses_bits(1U, 14);                            // Equivalent of complex macro WA_ALTCHARSET
        wa_invis               = ncurses_bits(1U, 15);                            // Equivalent of complex macro WA_INVIS
        wa_protect             = ncurses_bits(1U, 16);                            // Equivalent of complex macro WA_PROTECT
        wa_horizontal          = ncurses_bits(1U, 17);                            // Equivalent of complex macro WA_HORIZONTAL
        wa_left                = ncurses_bits(1U, 18);                            // Equivalent of complex macro WA_LEFT
        wa_low                 = ncurses_bits(1U, 19);                            // Equivalent of complex macro WA_LOW
        wa_right               = ncurses_bits(1U, 20);                            // Equivalent of complex macro WA_RIGHT
        wa_top                 = ncurses_bits(1U, 21);                            // Equivalent of complex macro WA_TOP
        wa_vertical            = ncurses_bits(1U, 22);                            // Equivalent of complex macro WA_VERTICAL
        wa_italic              = ncurses_bits(1U, 23);                            // Equivalent of complex macro WA_ITALIC

        button1_released       = ncurses_mouse_mask(1, NCURSES_BUTTON_RELEASED);  // Equivalent of complex macro BUTTON1_RELEASED
        button1_pressed        = ncurses_mouse_mask(1, NCURSES_BUTTON_PRESSED);   // Equivalent of complex macro BUTTON1_PRESSED
        button1_clicked        = ncurses_mouse_mask(1, NCURSES_BUTTON_CLICKED);   // Equivalent of complex macro BUTTON1_CLICKED
        button1_double_clicked = ncurses_mouse_mask(1, NCURSES_DOUBLE_CLICKED);   // Equivalent of complex macro BUTTON1_DOUBLE_CLICKED
        button1_triple_clicked = ncurses_mouse_mask(1, NCURSES_TRIPLE_CLICKED);   // Equivalent of complex macro BUTTON1_TRIPLE_CLICKED

        button2_released       = ncurses_mouse_mask(2, NCURSES_BUTTON_RELEASED);  // Equivalent of complex macro BUTTON2_RELEASED
        button2_pressed        = ncurses_mouse_mask(2, NCURSES_BUTTON_PRESSED);   // Equivalent of complex macro BUTTON2_PRESSED
        button2_clicked        = ncurses_mouse_mask(2, NCURSES_BUTTON_CLICKED);   // Equivalent of complex macro BUTTON2_CLICKED
        button2_double_clicked = ncurses_mouse_mask(2, NCURSES_DOUBLE_CLICKED);   // Equivalent of complex macro BUTTON2_DOUBLE_CLICKED
        button2_triple_clicked = ncurses_mouse_mask(2, NCURSES_TRIPLE_CLICKED);   // Equivalent of complex macro BUTTON2_TRIPLE_CLICKED

        button3_released       = ncurses_mouse_mask(3, NCURSES_BUTTON_RELEASED);  // Equivalent of complex macro BUTTON3_RELEASED
        button3_pressed        = ncurses_mouse_mask(3, NCURSES_BUTTON_PRESSED);   // Equivalent of complex macro BUTTON3_PRESSED
        button3_clicked        = ncurses_mouse_mask(3, NCURSES_BUTTON_CLICKED);   // Equivalent of complex macro BUTTON3_CLICKED
        button3_double_clicked = ncurses_mouse_mask(3, NCURSES_DOUBLE_CLICKED);   // Equivalent of complex macro BUTTON3_DOUBLE_CLICKED
        button3_triple_clicked = ncurses_mouse_mask(3, NCURSES_TRIPLE_CLICKED);   // Equivalent of complex macro BUTTON3_TRIPLE_CLICKED

        button4_released       = ncurses_mouse_mask(4, NCURSES_BUTTON_RELEASED);  // Equivalent of complex macro BUTTON4_RELEASED
        button4_pressed        = ncurses_mouse_mask(4, NCURSES_BUTTON_PRESSED);   // Equivalent of complex macro BUTTON4_PRESSED
        button4_clicked        = ncurses_mouse_mask(4, NCURSES_BUTTON_CLICKED);   // Equivalent of complex macro BUTTON4_CLICKED
        button4_double_clicked = ncurses_mouse_mask(4, NCURSES_DOUBLE_CLICKED);   // Equivalent of complex macro BUTTON4_DOUBLE_CLICKED
        button4_triple_clicked = ncurses_mouse_mask(4, NCURSES_TRIPLE_CLICKED);   // Equivalent of complex macro BUTTON4_TRIPLE_CLICKED

#if NCURSES_MOUSE_VERSION > 1
        button5_released       = ncurses_mouse_mask(5, NCURSES_BUTTON_RELEASED);  // Equivalent of complex macro BUTTON5_RELEASED
        button5_pressed        = ncurses_mouse_mask(5, NCURSES_BUTTON_PRESSED);   // Equivalent of complex macro BUTTON5_PRESSED
        button5_clicked        = ncurses_mouse_mask(5, NCURSES_BUTTON_CLICKED);   // Equivalent of complex macro BUTTON5_CLICKED
        button5_double_clicked = ncurses_mouse_mask(5, NCURSES_DOUBLE_CLICKED);   // Equivalent of complex macro BUTTON5_DOUBLE_CLICKED
        button5_triple_clicked = ncurses_mouse_mask(5, NCURSES_TRIPLE_CLICKED);   // Equivalent of complex macro BUTTON5_TRIPLE_CLICKED

	mmask_t b = 6;
#else
        button1_reserved_event = ncurses_mouse_mask(1, NCURSES_RESERVED_EVENT);   // Equivalent of complex macro BUTTON1_RESERVED_EVENT
        button2_reserved_event = ncurses_mouse_mask(2, NCURSES_RESERVED_EVENT);   // Equivalent of complex macro BUTTON2_RESERVED_EVENT
        button3_reserved_event = ncurses_mouse_mask(3, NCURSES_RESERVED_EVENT);   // Equivalent of complex macro BUTTON3_RESERVED_EVENT
        button4_reserved_event = ncurses_mouse_mask(4, NCURSES_RESERVED_EVENT);   // Equivalent of complex macro BUTTON4_RESERVED_EVENT

	mmask_t b = 5;
#endif

        button_shift           = ncurses_mouse_mask(b, 0002L);                    // Equivalent of complex macro BUTTON_SHIFT
        button_ctrl            = ncurses_mouse_mask(b, 0001L);                    // Equivalent of complex macro BUTTON_CTRL
        button_alt             = ncurses_mouse_mask(b, 0004L);                    // Equivalent of complex macro BUTTON_ALT
        report_mouse_position  = ncurses_mouse_mask(b, 0010L);                    // Equivalent of complex macro REPORT_MOUSE_POSITION

        all_mouse_events       = report_mouse_position - 1;                       // Equivalent of complex macro ALL_MOUSE_EVENTS

        _initialised = true;
    }

    return _initialised;
};

// Equivalent of ncurses complex macro NCURSES_BITS
attr_t ncurses_bits(unsigned mask, int shift) {
    return (chtype)(mask) << (shift + NCURSES_ATTR_SHIFT);
}

// Equivalent of ncurses complex macro NCURSES_MOUSE_MASK
mmask_t ncurses_mouse_mask(mmask_t b, mmask_t m) {
#if NCURSES_MOUSE_VERSION > 1
    return m << ((b - 1) * 5);
#else
    return m << ((b - 1) * 6);
#endif
}
