/*
    MouseEvent.swift

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

import CNCurseswExtensions

public struct MouseEvent: OptionSet {
    public init(rawValue: mmask_t) {
        self.rawValue = rawValue
    }

    public let rawValue: mmask_t

    public static let Button1Released      = MouseEvent(rawValue: button1_released)        // mouse button 1 up
    public static let Button1Pressed       = MouseEvent(rawValue: button1_pressed)         // mouse button 1 down
    public static let Button1Clicked       = MouseEvent(rawValue: button1_clicked)         // mouse button 1 clicked
    public static let Button1DoubleClicked = MouseEvent(rawValue: button1_double_clicked)  // mouse button 1 double clicked
    public static let Button1TripleClicked = MouseEvent(rawValue: button1_triple_clicked)  // mouse button 1 triple clicked

    public static let Button2Released      = MouseEvent(rawValue: button2_released)        // mouse button 2 up
    public static let Button2Pressed       = MouseEvent(rawValue: button2_pressed)         // mouse button 2 down
    public static let Button2Clicked       = MouseEvent(rawValue: button2_clicked)         // mouse button 2 clicked
    public static let Button2DoubleClicked = MouseEvent(rawValue: button2_double_clicked)  // mouse button 2 double clicked
    public static let Button2TripleClicked = MouseEvent(rawValue: button2_triple_clicked)  // mouse button 2 triple clicked

    public static let Button3Released      = MouseEvent(rawValue: button3_released)        // mouse button 3 up
    public static let Button3Pressed       = MouseEvent(rawValue: button3_pressed)         // mouse button 3 down
    public static let Button3Clicked       = MouseEvent(rawValue: button3_clicked)         // mouse button 3 clicked
    public static let Button3DoubleClicked = MouseEvent(rawValue: button3_double_clicked)  // mouse button 3 double clicked
    public static let Button3TripleClicked = MouseEvent(rawValue: button3_triple_clicked)  // mouse button 3 triple clicked

    public static let Button4Released      = MouseEvent(rawValue: button4_released)        // mouse button 4 up
    public static let Button4Pressed       = MouseEvent(rawValue: button4_pressed)         // mouse button 4 down
    public static let Button4Clicked       = MouseEvent(rawValue: button4_clicked)         // mouse button 4 clicked
    public static let Button4DoubleClicked = MouseEvent(rawValue: button4_double_clicked)  // mouse button 4 double clicked
    public static let Button4TripleClicked = MouseEvent(rawValue: button4_triple_clicked)  // mouse button 4 triple clicked

#if arch(arm64) || arch(x86_64)                                                            // 64-bit - Equivalent of NCURSES_MOUSE_VERSION > 1
    public static let Button5Released      = MouseEvent(rawValue: button5_released)        // mouse button 5 up
    public static let Button5Pressed       = MouseEvent(rawValue: button5_pressed)         // mouse button 5 down
    public static let Button5Clicked       = MouseEvent(rawValue: button5_clicked)         // mouse button 5 clicked
    public static let Button5DoubleClicked = MouseEvent(rawValue: button5_double_clicked)  // mouse button 5 double clicked
    public static let Button5TripleClicked = MouseEvent(rawValue: button5_triple_clicked)  // mouse button 5 triple clicked
#else                                                                                      // 32-bit - Equivalent of NCURSES_MOUSE_VERSION == 1
    public static let Button1ReservedEvent = MouseEvent(rawValue: button1_reserved_event)  // mouse button 1 reserved event
    public static let Button2ReservedEvent = MouseEvent(rawValue: button2_reserved_event)  // mouse button 2 reserved event
    public static let Button3ReservedEvent = MouseEvent(rawValue: button3_reserved_event)  // mouse button 3 reserved event
    public static let Button4ReservedEvent = MouseEvent(rawValue: button4_reserved_event)  // mouse button 4 reserved event
#endif

    public static let ButtonShift          = MouseEvent(rawValue: button_shift)            // shift was down during button state change
    public static let ButtonCtrl           = MouseEvent(rawValue: button_ctrl)             // control was down during button state change
    public static let ButtonAlt            = MouseEvent(rawValue: button_alt)              // alt was down during button state change
    public static let ReportMousePosition  = MouseEvent(rawValue: report_mouse_position)   // report mouse movement

    public static let AllMouseEvents       = MouseEvent(rawValue: all_mouse_events)        // report all button state changes
}
