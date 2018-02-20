/*
    SoftLabels.swift

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

import CNCursesw

public class SoftLabels {
    public static let sharedInstance = SoftLabels()

    private static var _maximumLabels: Int = 0
    private static var _maximumLabelSize: Int = 0

    public private(set) static var labels = Dictionary<Int, String>()

    private init() { }

    public class func initialise(with: SoftLabelType) throws {
        precondition(!Terminal.initialised, "Terminal.initialise() already called")

        guard (slk_init(with.rawValue) == OK) else {
            throw NCurseswError.SoftLabelInitialise(with: with)
        }

        switch with {
            case .ThreeTwoThree, .FourFour:
                _maximumLabels = 8
                _maximumLabelSize = 8
            case .FourFourFour, .FourFourFourIndex:
                _maximumLabels = 12
                _maximumLabelSize = 5
        }
    }

    public class func setLabel(_ number: Int, label: String, justification: Justification = .Left) throws {
        precondition(number > 0 && number <= _maximumLabels, "label number must be between 1 and \(_maximumLabels)")
        precondition(label.utf8.count <= _maximumLabelSize, "label length cannot be greater then \(_maximumLabelSize)")

        var wch = label._unicodeScalarCodePoints

        guard (slk_wset(CInt(number), &wch, justification.rawValue) == OK) else {
            throw NCurseswError.SoftLabelSet(number: number, label: label, justification: justification)
        }

        labels[number] = label
    }

    public class func refresh() throws {
        guard (slk_refresh() == OK) else {
            throw NCurseswError.SoftLabelRefresh
        }
    }

    public class func updateWithoutRefresh() throws {
        guard (slk_noutrefresh() == OK) else {
            throw NCurseswError.SoftLabelUpdateWithoutRefresh
        }
    }

    public class func clear() throws {
        guard (slk_clear() == OK) else {
            throw NCurseswError.SoftLabelClear
        }
    }

    public class func restore() throws {
        guard (slk_restore() == OK) else {
            throw NCurseswError.SoftLabelRestore
        }
    }

    public class func touch() throws {
        guard (slk_touch() == OK) else {
            throw NCurseswError.SoftLabelTouch
        }
    }

    public func setAttributes(to windowAttributes: WindowAttributes) throws {
        guard (slk_attr_set(windowAttributes.attributes.rawValue, CShort(windowAttributes.colourPair.rawValue), nil) == OK) else {
            throw NCurseswError.SoftLabelAttributesTo(windowAttributes: windowAttributes)
        }
    }

    public func setAttributes(on attributes: Attributes) throws {
        guard (slk_attr_on(attributes.rawValue, nil) == OK) else {
            throw NCurseswError.SoftLabelAttributesOn(attributes: attributes)
        }
    }

    public func setAttributes(off attributes: Attributes) throws {
        guard (slk_attr_off(attributes.rawValue, nil) == OK) else {
            throw NCurseswError.SoftLabelAttributesOff(attributes: attributes)
        }
    }

    public func setColour(to colourPair: ColourPair) throws {
        guard (extended_slk_color(colourPair.rawValue) == OK) else {
            throw NCurseswError.SoftLabelSetColour(colourPair: colourPair)
        }
    }
}
