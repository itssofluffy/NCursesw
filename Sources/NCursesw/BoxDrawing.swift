/*
    BoxDrawing.swift

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

private struct GraphicsMatrixKey {
    let type:    BoxDrawingType
    let graphic: BoxDrawingGraphic

    init(_ type: BoxDrawingType, _ graphic: BoxDrawingGraphic) {
        self.type = type
        self.graphic = graphic
    }
}

extension GraphicsMatrixKey: Hashable {
    var hashValue: Int {
        return (type.rawValue << 8) + graphic.rawValue
    }
}

extension GraphicsMatrixKey: Equatable {
    static func ==(lhs: GraphicsMatrixKey, rhs: GraphicsMatrixKey) -> Bool {
        return (lhs.type == rhs.type && lhs.graphic == rhs.graphic)
    }
}

private let __graphicsMatrix: Dictionary<GraphicsMatrixKey, wchar_t> = [GraphicsMatrixKey(.Ascii       , .UpperLeftCorner     ) : 0x002b,
                                                                        GraphicsMatrixKey(.Ascii       , .LowerLeftCorner     ) : 0x002b,
                                                                        GraphicsMatrixKey(.Ascii       , .UpperRightCorner    ) : 0x002b,
                                                                        GraphicsMatrixKey(.Ascii       , .LowerRightCorner    ) : 0x002b,
                                                                        GraphicsMatrixKey(.Ascii       , .RightTee            ) : 0x002b,
                                                                        GraphicsMatrixKey(.Ascii       , .LeftTee             ) : 0x002b,
                                                                        GraphicsMatrixKey(.Ascii       , .LowerTee            ) : 0x002b,
                                                                        GraphicsMatrixKey(.Ascii       , .UpperTee            ) : 0x002b,
                                                                        GraphicsMatrixKey(.Ascii       , .HorizontalLine      ) : 0x002d,
                                                                        GraphicsMatrixKey(.Ascii       , .UpperHorizontalLine ) : 0x002d,
                                                                        GraphicsMatrixKey(.Ascii       , .LowerHorizontalLine ) : 0x002d,
                                                                        GraphicsMatrixKey(.Ascii       , .VerticalLine        ) : 0x007c,
                                                                        GraphicsMatrixKey(.Ascii       , .LeftVerticalLine    ) : 0x007c,
                                                                        GraphicsMatrixKey(.Ascii       , .RightVerticalLine   ) : 0x007c,
                                                                        GraphicsMatrixKey(.Ascii       , .Plus                ) : 0x002b,
                                                                        GraphicsMatrixKey(.Light       , .UpperLeftCorner     ) : 0x250c,
                                                                        GraphicsMatrixKey(.Light       , .LowerLeftCorner     ) : 0x2514,
                                                                        GraphicsMatrixKey(.Light       , .UpperRightCorner    ) : 0x2510,
                                                                        GraphicsMatrixKey(.Light       , .LowerRightCorner    ) : 0x2518,
                                                                        GraphicsMatrixKey(.Light       , .RightTee            ) : 0x2524,
                                                                        GraphicsMatrixKey(.Light       , .LeftTee             ) : 0x251c,
                                                                        GraphicsMatrixKey(.Light       , .LowerTee            ) : 0x2534,
                                                                        GraphicsMatrixKey(.Light       , .UpperTee            ) : 0x252c,
                                                                        GraphicsMatrixKey(.Light       , .HorizontalLine      ) : 0x2500,
                                                                        GraphicsMatrixKey(.Light       , .UpperHorizontalLine ) : 0x2500,
                                                                        GraphicsMatrixKey(.Light       , .LowerHorizontalLine ) : 0x2500,
                                                                        GraphicsMatrixKey(.Light       , .VerticalLine        ) : 0x2502,
                                                                        GraphicsMatrixKey(.Light       , .LeftVerticalLine    ) : 0x2502,
                                                                        GraphicsMatrixKey(.Light       , .RightVerticalLine   ) : 0x2502,
                                                                        GraphicsMatrixKey(.Light       , .Plus                ) : 0x253c,
                                                                        GraphicsMatrixKey(.LightRounded, .UpperLeftCorner     ) : 0x256d,
                                                                        GraphicsMatrixKey(.LightRounded, .LowerLeftCorner     ) : 0x2570,
                                                                        GraphicsMatrixKey(.LightRounded, .UpperRightCorner    ) : 0x256e,
                                                                        GraphicsMatrixKey(.LightRounded, .LowerRightCorner    ) : 0x256f,
                                                                        GraphicsMatrixKey(.LightRounded, .RightTee            ) : 0x2524,
                                                                        GraphicsMatrixKey(.LightRounded, .LeftTee             ) : 0x251c,
                                                                        GraphicsMatrixKey(.LightRounded, .LowerTee            ) : 0x2534,
                                                                        GraphicsMatrixKey(.LightRounded, .UpperTee            ) : 0x252c,
                                                                        GraphicsMatrixKey(.LightRounded, .HorizontalLine      ) : 0x2500,
                                                                        GraphicsMatrixKey(.LightRounded, .UpperHorizontalLine ) : 0x2500,
                                                                        GraphicsMatrixKey(.LightRounded, .LowerHorizontalLine ) : 0x2500,
                                                                        GraphicsMatrixKey(.LightRounded, .VerticalLine        ) : 0x2502,
                                                                        GraphicsMatrixKey(.LightRounded, .LeftVerticalLine    ) : 0x2502,
                                                                        GraphicsMatrixKey(.LightRounded, .RightVerticalLine   ) : 0x2502,
                                                                        GraphicsMatrixKey(.LightRounded, .Plus                ) : 0x253c,
                                                                        GraphicsMatrixKey(.Double      , .UpperLeftCorner     ) : 0x2554,
                                                                        GraphicsMatrixKey(.Double      , .LowerLeftCorner     ) : 0x255a,
                                                                        GraphicsMatrixKey(.Double      , .UpperRightCorner    ) : 0x2557,
                                                                        GraphicsMatrixKey(.Double      , .LowerRightCorner    ) : 0x255d,
                                                                        GraphicsMatrixKey(.Double      , .RightTee            ) : 0x2563,
                                                                        GraphicsMatrixKey(.Double      , .LeftTee             ) : 0x2560,
                                                                        GraphicsMatrixKey(.Double      , .LowerTee            ) : 0x2569,
                                                                        GraphicsMatrixKey(.Double      , .UpperTee            ) : 0x2566,
                                                                        GraphicsMatrixKey(.Double      , .HorizontalLine      ) : 0x2550,
                                                                        GraphicsMatrixKey(.Double      , .UpperHorizontalLine ) : 0x2550,
                                                                        GraphicsMatrixKey(.Double      , .LowerHorizontalLine ) : 0x2550,
                                                                        GraphicsMatrixKey(.Double      , .VerticalLine        ) : 0x2551,
                                                                        GraphicsMatrixKey(.Double      , .LeftVerticalLine    ) : 0x2551,
                                                                        GraphicsMatrixKey(.Double      , .RightVerticalLine   ) : 0x2551,
                                                                        GraphicsMatrixKey(.Double      , .Plus                ) : 0x256c,
                                                                        GraphicsMatrixKey(.Thick       , .UpperLeftCorner     ) : 0x250f,
                                                                        GraphicsMatrixKey(.Thick       , .LowerLeftCorner     ) : 0x2517,
                                                                        GraphicsMatrixKey(.Thick       , .UpperRightCorner    ) : 0x2513,
                                                                        GraphicsMatrixKey(.Thick       , .LowerRightCorner    ) : 0x251b,
                                                                        GraphicsMatrixKey(.Thick       , .RightTee            ) : 0x252b,
                                                                        GraphicsMatrixKey(.Thick       , .LeftTee             ) : 0x2523,
                                                                        GraphicsMatrixKey(.Thick       , .LowerTee            ) : 0x253b,
                                                                        GraphicsMatrixKey(.Thick       , .UpperTee            ) : 0x2533,
                                                                        GraphicsMatrixKey(.Thick       , .HorizontalLine      ) : 0x2501,
                                                                        GraphicsMatrixKey(.Thick       , .UpperHorizontalLine ) : 0x2501,
                                                                        GraphicsMatrixKey(.Thick       , .LowerHorizontalLine ) : 0x2501,
                                                                        GraphicsMatrixKey(.Thick       , .VerticalLine        ) : 0x2503,
                                                                        GraphicsMatrixKey(.Thick       , .LeftVerticalLine    ) : 0x2503,
                                                                        GraphicsMatrixKey(.Thick       , .RightVerticalLine   ) : 0x2503,
                                                                        GraphicsMatrixKey(.Thick       , .Plus                ) : 0x254b]

private var _graphicsMatrix = Dictionary<GraphicsMatrixKey, ComplexCharacter>()

private var _initialised = false

public struct BoxDrawing {
    private let _boxDrawingType: BoxDrawingType

    public init(_ boxDrawingType: BoxDrawingType = .Light, attributes: Attributes = .Normal, colourPair: ColourPair = ColourPair()) throws {
        _boxDrawingType = boxDrawingType

        if (!_initialised) {
            try BoxDrawingType.allValues.forEach { boxDrawingType in
                try BoxDrawingGraphic.allValues.forEach { boxDrawingGraphic in
                    let matrixKey = GraphicsMatrixKey(boxDrawingType, boxDrawingGraphic)

                    _graphicsMatrix[matrixKey] = try ComplexCharacter(__graphicsMatrix[matrixKey]!, attributes: attributes, colourPair: colourPair)
                }
            }

            _initialised = true
        }
    }

    public func graphic(_ graphic: BoxDrawingGraphic) -> ComplexCharacter {
        return _graphicsMatrix[GraphicsMatrixKey(_boxDrawingType, graphic)]!
    }

    internal func _graphic(_ graphic: BoxDrawingGraphic) -> CChar_t {
        return withUnsafePointer(to: &_graphicsMatrix[GraphicsMatrixKey(_boxDrawingType, graphic)]!._rawValue) { CChar_t($0) }
    }
}
