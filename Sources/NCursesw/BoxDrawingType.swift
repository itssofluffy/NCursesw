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
    case Light(detail: BoxDrawingTypeDetail)
    case Heavy(detail: BoxDrawingTypeDetail)
    case Double
    case UserDefined(graphics: UserDefinedBoxDrawing)

    public var rawValue: Int {
        switch self {
            case .Ascii:
                return 0
            case .Light(let detail):
                return 1 + detail.rawValue
            case .Heavy(let detail):
                return 10 + detail.rawValue
            case .Double:
                return 20
            case .UserDefined:
                return 30
        }
    }
}

extension BoxDrawingType: CustomStringConvertible {
    public var description: String {
        switch self {
            case .Ascii:
                return "ascii"
            case .Light(let detail):
                return "light \(detail)"
            case .Heavy(let detail):
                return "heavy \(detail)"
            case .Double:
                return "double"
            case .UserDefined(let graphics):
                return "user defined (\(graphics))"
        }
    }
}
