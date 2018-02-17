/*
    ComplexCharacter.swift

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

public struct ComplexCharacter {
    public let wideCharacter: wchar_t
    public var character: Character? {
        if let unicodeScalar = UnicodeScalar(UInt32(wideCharacter)) {
            return Character(unicodeScalar)
        }

        return nil
    }
    public let attributes: Attributes
    public let colourPair: ColourPair

    internal private(set) var _rawValue: cchar_t

    public init(_ wideCharacter: wchar_t, attributes: Attributes = .Normal, colourPair: ColourPair = ColourPair()) throws {
        _rawValue = cchar_t()

        var wch = Array<wchar_t>(repeating: 0x00, count: Int(CCHARW_MAX))
        wch[0] = wideCharacter

        guard (setcchar(&_rawValue, &wch, attributes.rawValue, CShort(colourPair.rawValue), nil) == OK) else {
            throw NCurseswError.SetComplexCharacter(wideCharacter: wideCharacter, attributes: attributes, colourPair: colourPair)
        }

        self.wideCharacter = wideCharacter
        self.attributes = attributes
        self.colourPair = colourPair
    }

    internal init(rawValue: cchar_t) throws {
        var wcval = rawValue
        var wch = wchar_t()
        var attrs = attr_t()
        var colourPair = CShort()

        guard (getcchar(&wcval, &wch, &attrs, &colourPair, nil) == OK) else {
            throw NCurseswError.GetComplexCharacter
        }

        self.wideCharacter = wch
        self.attributes = Attributes(rawValue: attrs)
        self.colourPair = try _getColourPair(with: colourPair)

        _rawValue = wcval
    }
}

extension ComplexCharacter: CustomStringConvertible {
    public var description: String {
        return "wideCharacter: \(wideCharacter), character: \(character!), attributes: (\(attributes)), colourPair: (\(colourPair))"
    }
}
