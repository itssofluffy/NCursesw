/*
    Attributes.swift

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

public struct Attributes: OptionSet {
    public init(rawValue: attr_t) {
        self.rawValue = rawValue
    }

    public let rawValue: attr_t

    public static let Normal     = Attributes(rawValue: wa_normal)
    public static let Attribute  = Attributes(rawValue: wa_attributes)
    public static let Standout   = Attributes(rawValue: wa_standout)
    public static let Underline  = Attributes(rawValue: wa_underline)
    public static let Reverse    = Attributes(rawValue: wa_reverse)
    public static let Blink      = Attributes(rawValue: wa_blink)
    public static let Dim        = Attributes(rawValue: wa_dim)
    public static let Bold       = Attributes(rawValue: wa_bold)
    public static let AltCharSet = Attributes(rawValue: wa_altcharset)
    public static let Invisible  = Attributes(rawValue: wa_invis)
    public static let Protect    = Attributes(rawValue: wa_protect)
    public static let Horizontal = Attributes(rawValue: wa_horizontal)
    public static let Left       = Attributes(rawValue: wa_left)
    public static let Low        = Attributes(rawValue: wa_low)
    public static let Right      = Attributes(rawValue: wa_right)
    public static let Top        = Attributes(rawValue: wa_top)
    public static let Vertical   = Attributes(rawValue: wa_vertical)
    public static let Italic     = Attributes(rawValue: wa_italic)
}

extension Attributes: CustomStringConvertible {
    public var description: String {
        var description: String = ""

        var seperator: String {
            if (!description.isEmpty) {
                description += ", "
            }

            return ""
        }

        if (self.contains(.Normal)) {
            description += seperator + "normal"
        }

        if (self.contains(.Attribute)) {
            description += seperator + "attribute"
        }

        if (self.contains(.Standout)) {
            description += seperator + "standout"
        }

        if (self.contains(.Underline)) {
            description += seperator + "underline"
        }

        if (self.contains(.Reverse)) {
            description += seperator + "reverse"
        }

        if (self.contains(.Blink)) {
            description += seperator + "blink"
        }

        if (self.contains(.Dim)) {
            description += seperator + "dim"
        }

        if (self.contains(.Bold)) {
            description += seperator + "bold"
        }

        if (self.contains(.AltCharSet)) {
            description += seperator + "alternate character set"
        }

        if (self.contains(.Invisible)) {
            description += seperator + "invisible"
        }

        if (self.contains(.Protect)) {
            description += seperator + "protect"
        }

        if (self.contains(.Horizontal)) {
            description += seperator + "horizontal"
        }

        if (self.contains(.Left)) {
            description += seperator + "left"
        }

        if (self.contains(.Low)) {
            description += seperator + "low"
        }

        if (self.contains(.Right)) {
            description += seperator + "right"
        }

        if (self.contains(.Top)) {
            description += seperator + "top"
        }

        if (self.contains(.Vertical)) {
            description += seperator + "vertical"
        }

        if (self.contains(.Italic)) {
            description += seperator + "italic"
        }

        return description
    }
}
