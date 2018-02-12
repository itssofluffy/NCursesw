/*
    BoxDrawingGraphic.swift

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

public enum BoxDrawingGraphic {
    case UpperLeftCorner
    case LowerLeftCorner
    case UpperRightCorner
    case LowerRightCorner
    case RightTee
    case LeftTee
    case LowerTee
    case UpperTee
    case HorizontalLine
    case UpperHorizontalLine
    case LowerHorizontalLine
    case VerticalLine
    case LeftVerticalLine
    case RightVerticalLine
    case Plus

    internal static let _allValues = Array<BoxDrawingGraphic>(arrayLiteral: .UpperLeftCorner,
                                                                            .LowerLeftCorner,
                                                                            .UpperRightCorner,
                                                                            .LowerRightCorner,
                                                                            .RightTee,
                                                                            .LeftTee,
                                                                            .LowerTee,
                                                                            .UpperTee,
                                                                            .HorizontalLine,
                                                                            .UpperHorizontalLine,
                                                                            .LowerHorizontalLine,
                                                                            .VerticalLine,
                                                                            .LeftVerticalLine,
                                                                            .RightVerticalLine,
                                                                            .Plus)

    public var rawValue: Int {
        switch self {
            case .UpperLeftCorner:
                return 0
            case .LowerLeftCorner:
                return 1
            case .UpperRightCorner:
                return 2
            case .LowerRightCorner:
                return 3
            case .RightTee:
                return 4
            case .LeftTee:
                return 5
            case .LowerTee:
                return 6
            case .UpperTee:
                return 7
            case .HorizontalLine:
                return 8
            case .UpperHorizontalLine:
                return 9
            case .LowerHorizontalLine:
                return 10
            case .VerticalLine:
                return 11
            case .LeftVerticalLine:
                return 12
            case .RightVerticalLine:
                return 13
            case .Plus:
                return 14
        }
    }
}

extension BoxDrawingGraphic: CustomStringConvertible {
    public var description: String {
        switch self {
            case .UpperLeftCorner:
                return "upper left corner"
            case .LowerLeftCorner:
                return "lower left corner"
            case .UpperRightCorner:
                return "upper right corner"
            case .LowerRightCorner:
                return "lower right corner"
            case .RightTee:
                return "right tee"
            case .LeftTee:
                return "left tee"
            case .LowerTee:
                return "lower tee"
            case .UpperTee:
                return "upper tee"
            case .HorizontalLine:
                return "horizontal line"
            case .UpperHorizontalLine:
                return "upper horizontal line"
            case .LowerHorizontalLine:
                return "lower horizontal line"
            case .VerticalLine:
                return "vertical line"
            case .LeftVerticalLine:
                return "left vertical line"
            case .RightVerticalLine:
                return "right vertical line"
            case .Plus:
                return "plus"
        }
    }
}
