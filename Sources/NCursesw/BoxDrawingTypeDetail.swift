/*
    BoxDrawingTypeDetail.swift

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

public enum BoxDrawingTypeDetail {
    case Normal
    case LeftDash
    case RightDash
    case DoubleDash
    case TripleDash
    case QuadrupleDash

    public static let allValues = Array<BoxDrawingTypeDetail>(arrayLiteral: .Normal,
                                                                            .LeftDash,
                                                                            .RightDash,
                                                                            .DoubleDash,
                                                                            .TripleDash,
                                                                            .QuadrupleDash)

    public var rawValue: Int {
        switch self {
            case .Normal:
                return 0
            case .LeftDash:
                return 1
            case .RightDash:
                return 2
            case .DoubleDash:
                return 3
            case .TripleDash:
                return 4
            case .QuadrupleDash:
                return 5
        }
    }
}

extension BoxDrawingTypeDetail: CustomStringConvertible {
    public var description: String {
        switch self {
            case .Normal:
                return "normal"
            case .LeftDash:
                return "left dash"
            case .RightDash:
                return "right dash"
            case .DoubleDash:
                return "double dash"
            case .TripleDash:
                return "triple dash"
            case .QuadrupleDash:
                return "quadruple dash"
        }
    }
}
