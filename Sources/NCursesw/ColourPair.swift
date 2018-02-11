/*
    ColourPair.swift

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

private var _pairNumber: CShort = 1
private var _colourPairs: Dictionary<CShort, ColourPair> = [0 : ColourPair()]

public func getColour(pair: CShort) throws -> ColourPair {
    if let colourPair = _colourPairs[pair] {
        return colourPair
    }

    throw NCurseswError.ColourPairNotDefined(pair: pair)
}

public func findColourPair(with palette: ColourPalette) -> ColourPair? {
    for pair in _colourPairs {
        if (pair.value.palette == palette) {
            return pair.value
        }
    }

    return nil
}

public struct ColourPair {
    public let number: Int
    public let palette: ColourPalette

    public init() {
        number = 0
        palette = ColourPalette(foreground: .Default, background: .Default)
    }

    public init(palette: ColourPalette) throws {
        guard (_pairNumber <= Terminal.colourPairs) else {
            throw NCurseswError.ColourPair
        }

        try Terminal.initialisePair(pair: _pairNumber, palette: palette)

        number = Int(_pairNumber)
        self.palette = palette

        _colourPairs[_pairNumber] = self

        _pairNumber = _pairNumber + 1
    }

    public var rawValue: CInt {
        return CInt(number)
    }
}

extension ColourPair: CustomStringConvertible {
    public var description: String {
        return "pair: \(number), palette: (\(palette))"
    }
}
