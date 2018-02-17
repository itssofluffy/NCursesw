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
import ISFLibrary

public private(set) var colourPairs: Dictionary<CInt, ColourPair> = [0 : ColourPair()]

internal func _getColourPair(with: CShort) throws -> ColourPair {
    let pair = CInt(with)

    if let colourPair = colourPairs[pair] {
        return colourPair
    }

    throw NCurseswError.ColourPairNotDefined(pair: pair)
}

public func resetColourPairs() {
    precondition(Terminal.initialised, "Terminal.initialiseWindows() not called")

    reset_color_pairs()

    colourPairs.removeAll()
    colourPairs[0] = ColourPair()
}

public func getColourPair(with palette: ColourPalette) -> ColourPair? {
    precondition(Terminal.initialised, "Terminal.initialiseWindows() not called")

    let pairNumber = find_pair(palette.foreground.rawValue, palette.background.rawValue)

    return (pairNumber == ERR) ?  nil : colourPairs[pairNumber]
}

public func getColourPair(with attribute: attr_t) -> ColourPair? {
    if let colourPair = colourPairs[PAIR_NUMBER(CInt(attribute))] {
        return colourPair
    }

    return nil
}

public class ColourPair {
    private var _free:  Bool
    public let palette: ColourPalette

    public init() {
        _free = false
        palette = ColourPalette.default
        rawValue = 0
    }

    public init(palette: ColourPalette, free: Bool = false) throws {
        precondition(Terminal.initialised, "Terminal.initialiseWindows() not called")

        if (palette == ColourPalette.default) {
            precondition(!free, "default colour pair cannot be freed")

            _free = false
            self.palette = ColourPalette.default
            rawValue = 0
        } else {
            let pairNumber = alloc_pair(palette.foreground.rawValue, palette.background.rawValue)

            guard (pairNumber != ERR) else {
                throw NCurseswError.AllocatePair(palette: palette)
            }

            _free = free
            self.palette = palette
            rawValue = pairNumber

            colourPairs[pairNumber] = self
        }
    }

    deinit {
        if (_free) {
            wrapper(do: {
                        guard (free_pair(self.rawValue) == OK) else {
                            throw NCurseswError.FreePair(pair: self.rawValue)
                        }
                    },
                    catch: { failure in
                        ncurseswErrorLogger(failure)
                    })
        }
    }

    public private(set) var rawValue: CInt

    public var attribute: attr_t {
        return attr_t(COLOR_PAIR(rawValue))
    }
}

extension ColourPair: CustomStringConvertible {
    public var description: String {
        return "pair: \(rawValue), palette: (\(palette))"
    }
}
