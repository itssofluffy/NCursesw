/*
    BoxDrawingType.swift

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

public enum BoxDrawingType {
    case Ascii
    case Light
    case LightRounded
    case Double
    case Thick

    public static let allValues = Array<BoxDrawingType>(arrayLiteral: .Ascii,
                                                                      .Light,
                                                                      .LightRounded,
                                                                      .Double,
                                                                      .Thick)

    public var rawValue: Int {
        switch self {
            case .Ascii:
                return 0
            case .Light:
                return 1
            case .LightRounded:
                return 2
            case .Double:
                return 3
            case .Thick:
                return 4
        }
    }
}

extension BoxDrawingType: CustomStringConvertible {
    public var description: String {
        switch self {
            case .Ascii:
                return "ascii"
            case .Light:
                return "light"
            case .LightRounded:
                return "light rounded"
            case .Double:
                return "double"
            case .Thick:
                return "thick"
        }
    }
}
