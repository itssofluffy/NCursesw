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

    // Base the rawValue on a 3x3 matrix of a box character so we can OR two raw values
    // together (see transform function) to determine the corrected BoxDrawingGraphic to use.
    // UpperHorizontalLine, LowerVerticalLine, LeftVerticalLine and RightVerticalLine have
    // pseudo values to make them unique for rawValue purposes.
    //
    // for example:
    //                        000
    // UpperLeftCorner : ┌ :  011 : 0b000011010
    //                        010
    //
    //                        000
    // HorizontalLine  : ─ :  111 : 0b000111000
    //                        000
    //
    //
    // input 1 : 0b000011010
    //           0b000111010 result : ┬ : UpperTee
    // input 2 : 0b000111000
    //
    // This will work with the exception of the origin of the graphic, if it is on the border
    // of the window we will calculate a Plus with horizontal and vertical line types so we
    // will need to take this into account.
    public init?(rawValue: Int) {
        switch rawValue {
            case 0b000011010:
                self = .UpperLeftCorner
            case 0b010011000:
                self = .LowerLeftCorner
            case 0b000110010:
                self = .UpperRightCorner
            case 0b010110000:
                self = .LowerRightCorner
            case 0b010110010:
                self = .RightTee
            case 0b010011010:
                self = .LeftTee
            case 0b010111000:
                self = .LowerTee
            case 0b000111010:
                self = .UpperTee
            case 0b000111000:
                self = .HorizontalLine
            case 0b111000000:
                self = .UpperHorizontalLine
            case 0b000000111:
                self = .LowerHorizontalLine
            case 0b010010010:
                self = .VerticalLine
            case 0b100100100:
                self = .LeftVerticalLine
            case 0b001001001:
                self = .RightVerticalLine
            case 0b010111010:
                self = .Plus
            default:
                return nil
        }
    }

    public var rawValue: Int {
        switch self {
            case .UpperLeftCorner:
                return 0b000011010
            case .LowerLeftCorner:
                return 0b010011000
            case .UpperRightCorner:
                return 0b000110010
            case .LowerRightCorner:
                return 0b010110000
            case .RightTee:
                return 0b010110010
            case .LeftTee:
                return 0b010011010
            case .LowerTee:
                return 0b010111000
            case .UpperTee:
                return 0b000111010
            case .HorizontalLine:
                return 0b000111000
            case .UpperHorizontalLine:
                return 0b111000000
            case .LowerHorizontalLine:
                return 0b000000111
            case .VerticalLine:
                return 0b010010010
            case .LeftVerticalLine:
                return 0b100100100
            case .RightVerticalLine:
                return 0b001001001
            case .Plus:
                return 0b010111010
        }
    }

    // optional because of UpperHorizontalLine, LowerHorizontalLine, LeftVerticalLine and RightVerticalLine
    // may not transform to a BoxDrawingGraphic we can deal with the predefined BoxGraphicType graphics,
    // this can be overriden by setting remap to true (default).
    public func transform(with: BoxDrawingGraphic, remap: Bool = true) -> BoxDrawingGraphic? {
        func _rawValue(of boxDrawingGraphic: BoxDrawingGraphic) -> Int {
            switch boxDrawingGraphic {
                case .UpperHorizontalLine, .LowerHorizontalLine:
                    return (remap) ? BoxDrawingGraphic.HorizontalLine.rawValue : boxDrawingGraphic.rawValue
                case .LeftVerticalLine, .RightVerticalLine:
                    return (remap) ? BoxDrawingGraphic.VerticalLine.rawValue : boxDrawingGraphic.rawValue
                default:
                    return boxDrawingGraphic.rawValue
            }
        }

        return BoxDrawingGraphic(rawValue: _rawValue(of: self) | _rawValue(of: with))
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
