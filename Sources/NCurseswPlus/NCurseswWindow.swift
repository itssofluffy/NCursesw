/*
    NCurseswWindow.swift

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

import NCursesw

extension NCurseswWindow {
    public func box(_ boxDrawingType: BoxDrawingType = .Light(detail: .Normal),
                    origin: Coordinate,
                    size: Size,
                    attributes: Attributes = .Normal,
                    colourPair: ColourPair = ColourPair()) throws {
        precondition(origin.y >= 0,"origin.y must be >= 0")
        precondition(origin.x >= 0,"origin.x must be >= 0")
        precondition(size.height >= 1, "size.height must be >= 1")
        precondition(size.width >= 1, "size.width must be >= 1")

        let boxDrawingGraphics = try BoxDrawing(boxDrawingType, attributes: attributes, colourPair: colourPair)

        let upperRight = Coordinate(y: origin.y, x: origin.x + size.width)
        let lowerLeft  = Coordinate(y: origin.y + size.height, x: origin.x)
        let lowerRight = Coordinate(y: lowerLeft.y, x: upperRight.x)

        let lineWidth = (upperRight.x - origin.x) - 1
        let lineHeight = (lowerLeft.y - origin.y) - 1

        try print(character: boxDrawingGraphics.graphic(.UpperLeftCorner), origin: origin)
        try print(character: boxDrawingGraphics.graphic(.UpperRightCorner), origin: upperRight)
        try print(character: boxDrawingGraphics.graphic(.LowerLeftCorner), origin: lowerLeft)
        try print(character: boxDrawingGraphics.graphic(.LowerRightCorner), origin: lowerRight)

        if (lineWidth > 1) {
            try horizontalLine(boxDrawingGraphics.graphic(.HorizontalLine), origin: Coordinate(y: origin.y, x: origin.x + 1), length: lineWidth)
            try horizontalLine(boxDrawingGraphics.graphic(.HorizontalLine), origin: Coordinate(y: lowerLeft.y, x: lowerLeft.x + 1), length: lineWidth)
        }

        if (lineHeight > 1) {
            try verticalLine(boxDrawingGraphics.graphic(.VerticalLine), origin: Coordinate(y: origin.y + 1, x: origin.x), length: lineHeight)
            try verticalLine(boxDrawingGraphics.graphic(.VerticalLine), origin: Coordinate(y: upperRight.y + 1, x: upperRight.x), length: lineHeight)
        }
    }
}
