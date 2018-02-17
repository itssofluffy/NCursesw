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
    let type:    Int
    let graphic: Int

    init(_ type: BoxDrawingType, _ graphic: BoxDrawingGraphic) {
        self.type = type.rawValue
        self.graphic = graphic.rawValue
    }
}

extension GraphicsMatrixKey: Hashable {
    var hashValue: Int {
        return (type << 8) + graphic
    }
}

extension GraphicsMatrixKey: Equatable {
    static func ==(lhs: GraphicsMatrixKey, rhs: GraphicsMatrixKey) -> Bool {
        return (lhs.type == rhs.type && lhs.graphic == rhs.graphic)
    }
}

private let _graphicsMatrix: Dictionary<GraphicsMatrixKey, wchar_t> =
    [GraphicsMatrixKey(.Ascii,                         .UpperLeftCorner     ) : 0x002b,
     GraphicsMatrixKey(.Ascii,                         .LowerLeftCorner     ) : 0x002b,
     GraphicsMatrixKey(.Ascii,                         .UpperRightCorner    ) : 0x002b,
     GraphicsMatrixKey(.Ascii,                         .LowerRightCorner    ) : 0x002b,
     GraphicsMatrixKey(.Ascii,                         .RightTee            ) : 0x002b,
     GraphicsMatrixKey(.Ascii,                         .LeftTee             ) : 0x002b,
     GraphicsMatrixKey(.Ascii,                         .LowerTee            ) : 0x002b,
     GraphicsMatrixKey(.Ascii,                         .UpperTee            ) : 0x002b,
     GraphicsMatrixKey(.Ascii,                         .HorizontalLine      ) : 0x002d,
     GraphicsMatrixKey(.Ascii,                         .UpperHorizontalLine ) : 0x002d,
     GraphicsMatrixKey(.Ascii,                         .LowerHorizontalLine ) : 0x002d,
     GraphicsMatrixKey(.Ascii,                         .VerticalLine        ) : 0x007c,
     GraphicsMatrixKey(.Ascii,                         .LeftVerticalLine    ) : 0x007c,
     GraphicsMatrixKey(.Ascii,                         .RightVerticalLine   ) : 0x007c,
     GraphicsMatrixKey(.Ascii,                         .Plus                ) : 0x002b,

     GraphicsMatrixKey(.Light(detail: .Normal),        .UpperLeftCorner     ) : 0x250c,
     GraphicsMatrixKey(.Light(detail: .Normal),        .LowerLeftCorner     ) : 0x2514,
     GraphicsMatrixKey(.Light(detail: .Normal),        .UpperRightCorner    ) : 0x2510,
     GraphicsMatrixKey(.Light(detail: .Normal),        .LowerRightCorner    ) : 0x2518,
     GraphicsMatrixKey(.Light(detail: .Normal),        .RightTee            ) : 0x2524,
     GraphicsMatrixKey(.Light(detail: .Normal),        .LeftTee             ) : 0x251c,
     GraphicsMatrixKey(.Light(detail: .Normal),        .LowerTee            ) : 0x2534,
     GraphicsMatrixKey(.Light(detail: .Normal),        .UpperTee            ) : 0x252c,
     GraphicsMatrixKey(.Light(detail: .Normal),        .HorizontalLine      ) : 0x2500,
     GraphicsMatrixKey(.Light(detail: .Normal),        .UpperHorizontalLine ) : 0x2500,
     GraphicsMatrixKey(.Light(detail: .Normal),        .LowerHorizontalLine ) : 0x2500,
     GraphicsMatrixKey(.Light(detail: .Normal),        .VerticalLine        ) : 0x2502,
     GraphicsMatrixKey(.Light(detail: .Normal),        .LeftVerticalLine    ) : 0x2502,
     GraphicsMatrixKey(.Light(detail: .Normal),        .RightVerticalLine   ) : 0x2502,
     GraphicsMatrixKey(.Light(detail: .Normal),        .Plus                ) : 0x253c,

     GraphicsMatrixKey(.Light(detail: .DoubleDash),    .UpperLeftCorner     ) : 0x250c,
     GraphicsMatrixKey(.Light(detail: .DoubleDash),    .LowerLeftCorner     ) : 0x2514,
     GraphicsMatrixKey(.Light(detail: .DoubleDash),    .UpperRightCorner    ) : 0x2510,
     GraphicsMatrixKey(.Light(detail: .DoubleDash),    .LowerRightCorner    ) : 0x2518,
     GraphicsMatrixKey(.Light(detail: .DoubleDash),    .RightTee            ) : 0x2524,
     GraphicsMatrixKey(.Light(detail: .DoubleDash),    .LeftTee             ) : 0x251c,
     GraphicsMatrixKey(.Light(detail: .DoubleDash),    .LowerTee            ) : 0x2534,
     GraphicsMatrixKey(.Light(detail: .DoubleDash),    .UpperTee            ) : 0x252c,
     GraphicsMatrixKey(.Light(detail: .DoubleDash),    .HorizontalLine      ) : 0x254c,
     GraphicsMatrixKey(.Light(detail: .DoubleDash),    .UpperHorizontalLine ) : 0x254c,
     GraphicsMatrixKey(.Light(detail: .DoubleDash),    .LowerHorizontalLine ) : 0x254c,
     GraphicsMatrixKey(.Light(detail: .DoubleDash),    .VerticalLine        ) : 0x254e,
     GraphicsMatrixKey(.Light(detail: .DoubleDash),    .LeftVerticalLine    ) : 0x254e,
     GraphicsMatrixKey(.Light(detail: .DoubleDash),    .RightVerticalLine   ) : 0x254e,
     GraphicsMatrixKey(.Light(detail: .DoubleDash),    .Plus                ) : 0x253c,

     GraphicsMatrixKey(.Light(detail: .TripleDash),    .UpperLeftCorner     ) : 0x250c,
     GraphicsMatrixKey(.Light(detail: .TripleDash),    .LowerLeftCorner     ) : 0x2514,
     GraphicsMatrixKey(.Light(detail: .TripleDash),    .UpperRightCorner    ) : 0x2510,
     GraphicsMatrixKey(.Light(detail: .TripleDash),    .LowerRightCorner    ) : 0x2518,
     GraphicsMatrixKey(.Light(detail: .TripleDash),    .RightTee            ) : 0x2524,
     GraphicsMatrixKey(.Light(detail: .TripleDash),    .LeftTee             ) : 0x251c,
     GraphicsMatrixKey(.Light(detail: .TripleDash),    .LowerTee            ) : 0x2534,
     GraphicsMatrixKey(.Light(detail: .TripleDash),    .UpperTee            ) : 0x252c,
     GraphicsMatrixKey(.Light(detail: .TripleDash),    .HorizontalLine      ) : 0x2504,
     GraphicsMatrixKey(.Light(detail: .TripleDash),    .UpperHorizontalLine ) : 0x2504,
     GraphicsMatrixKey(.Light(detail: .TripleDash),    .LowerHorizontalLine ) : 0x2504,
     GraphicsMatrixKey(.Light(detail: .TripleDash),    .VerticalLine        ) : 0x2506,
     GraphicsMatrixKey(.Light(detail: .TripleDash),    .LeftVerticalLine    ) : 0x2506,
     GraphicsMatrixKey(.Light(detail: .TripleDash),    .RightVerticalLine   ) : 0x2506,
     GraphicsMatrixKey(.Light(detail: .TripleDash),    .Plus                ) : 0x253c,

     GraphicsMatrixKey(.Light(detail: .QuadrupleDash), .UpperLeftCorner     ) : 0x250c,
     GraphicsMatrixKey(.Light(detail: .QuadrupleDash), .LowerLeftCorner     ) : 0x2514,
     GraphicsMatrixKey(.Light(detail: .QuadrupleDash), .UpperRightCorner    ) : 0x2510,
     GraphicsMatrixKey(.Light(detail: .QuadrupleDash), .LowerRightCorner    ) : 0x2518,
     GraphicsMatrixKey(.Light(detail: .QuadrupleDash), .RightTee            ) : 0x2524,
     GraphicsMatrixKey(.Light(detail: .QuadrupleDash), .LeftTee             ) : 0x251c,
     GraphicsMatrixKey(.Light(detail: .QuadrupleDash), .LowerTee            ) : 0x2534,
     GraphicsMatrixKey(.Light(detail: .QuadrupleDash), .UpperTee            ) : 0x252c,
     GraphicsMatrixKey(.Light(detail: .QuadrupleDash), .HorizontalLine      ) : 0x2508,
     GraphicsMatrixKey(.Light(detail: .QuadrupleDash), .UpperHorizontalLine ) : 0x2508,
     GraphicsMatrixKey(.Light(detail: .QuadrupleDash), .LowerHorizontalLine ) : 0x2508,
     GraphicsMatrixKey(.Light(detail: .QuadrupleDash), .VerticalLine        ) : 0x250a,
     GraphicsMatrixKey(.Light(detail: .QuadrupleDash), .LeftVerticalLine    ) : 0x250a,
     GraphicsMatrixKey(.Light(detail: .QuadrupleDash), .RightVerticalLine   ) : 0x250a,
     GraphicsMatrixKey(.Light(detail: .QuadrupleDash), .Plus                ) : 0x253c,

     GraphicsMatrixKey(.Heavy(detail: .Normal),        .UpperLeftCorner     ) : 0x250f,
     GraphicsMatrixKey(.Heavy(detail: .Normal),        .LowerLeftCorner     ) : 0x2517,
     GraphicsMatrixKey(.Heavy(detail: .Normal),        .UpperRightCorner    ) : 0x2513,
     GraphicsMatrixKey(.Heavy(detail: .Normal),        .LowerRightCorner    ) : 0x251b,
     GraphicsMatrixKey(.Heavy(detail: .Normal),        .RightTee            ) : 0x252b,
     GraphicsMatrixKey(.Heavy(detail: .Normal),        .LeftTee             ) : 0x2523,
     GraphicsMatrixKey(.Heavy(detail: .Normal),        .LowerTee            ) : 0x253b,
     GraphicsMatrixKey(.Heavy(detail: .Normal),        .UpperTee            ) : 0x2533,
     GraphicsMatrixKey(.Heavy(detail: .Normal),        .HorizontalLine      ) : 0x2501,
     GraphicsMatrixKey(.Heavy(detail: .Normal),        .UpperHorizontalLine ) : 0x2501,
     GraphicsMatrixKey(.Heavy(detail: .Normal),        .LowerHorizontalLine ) : 0x2501,
     GraphicsMatrixKey(.Heavy(detail: .Normal),        .VerticalLine        ) : 0x2503,
     GraphicsMatrixKey(.Heavy(detail: .Normal),        .LeftVerticalLine    ) : 0x2503,
     GraphicsMatrixKey(.Heavy(detail: .Normal),        .RightVerticalLine   ) : 0x2503,
     GraphicsMatrixKey(.Heavy(detail: .Normal),        .Plus                ) : 0x254b,

     GraphicsMatrixKey(.Heavy(detail: .DoubleDash),    .UpperLeftCorner     ) : 0x250f,
     GraphicsMatrixKey(.Heavy(detail: .DoubleDash),    .LowerLeftCorner     ) : 0x2517,
     GraphicsMatrixKey(.Heavy(detail: .DoubleDash),    .UpperRightCorner    ) : 0x2513,
     GraphicsMatrixKey(.Heavy(detail: .DoubleDash),    .LowerRightCorner    ) : 0x251b,
     GraphicsMatrixKey(.Heavy(detail: .DoubleDash),    .RightTee            ) : 0x252b,
     GraphicsMatrixKey(.Heavy(detail: .DoubleDash),    .LeftTee             ) : 0x2523,
     GraphicsMatrixKey(.Heavy(detail: .DoubleDash),    .LowerTee            ) : 0x253b,
     GraphicsMatrixKey(.Heavy(detail: .DoubleDash),    .UpperTee            ) : 0x2533,
     GraphicsMatrixKey(.Heavy(detail: .DoubleDash),    .HorizontalLine      ) : 0x254d,
     GraphicsMatrixKey(.Heavy(detail: .DoubleDash),    .UpperHorizontalLine ) : 0x254d,
     GraphicsMatrixKey(.Heavy(detail: .DoubleDash),    .LowerHorizontalLine ) : 0x254d,
     GraphicsMatrixKey(.Heavy(detail: .DoubleDash),    .VerticalLine        ) : 0x254f,
     GraphicsMatrixKey(.Heavy(detail: .DoubleDash),    .LeftVerticalLine    ) : 0x254f,
     GraphicsMatrixKey(.Heavy(detail: .DoubleDash),    .RightVerticalLine   ) : 0x254f,
     GraphicsMatrixKey(.Heavy(detail: .DoubleDash),    .Plus                ) : 0x254b,

     GraphicsMatrixKey(.Heavy(detail: .TripleDash),    .UpperLeftCorner     ) : 0x250f,
     GraphicsMatrixKey(.Heavy(detail: .TripleDash),    .LowerLeftCorner     ) : 0x2517,
     GraphicsMatrixKey(.Heavy(detail: .TripleDash),    .UpperRightCorner    ) : 0x2513,
     GraphicsMatrixKey(.Heavy(detail: .TripleDash),    .LowerRightCorner    ) : 0x251b,
     GraphicsMatrixKey(.Heavy(detail: .TripleDash),    .RightTee            ) : 0x252b,
     GraphicsMatrixKey(.Heavy(detail: .TripleDash),    .LeftTee             ) : 0x2523,
     GraphicsMatrixKey(.Heavy(detail: .TripleDash),    .LowerTee            ) : 0x253b,
     GraphicsMatrixKey(.Heavy(detail: .TripleDash),    .UpperTee            ) : 0x2533,
     GraphicsMatrixKey(.Heavy(detail: .TripleDash),    .HorizontalLine      ) : 0x2505,
     GraphicsMatrixKey(.Heavy(detail: .TripleDash),    .UpperHorizontalLine ) : 0x2505,
     GraphicsMatrixKey(.Heavy(detail: .TripleDash),    .LowerHorizontalLine ) : 0x2505,
     GraphicsMatrixKey(.Heavy(detail: .TripleDash),    .VerticalLine        ) : 0x2507,
     GraphicsMatrixKey(.Heavy(detail: .TripleDash),    .LeftVerticalLine    ) : 0x2507,
     GraphicsMatrixKey(.Heavy(detail: .TripleDash),    .RightVerticalLine   ) : 0x2507,
     GraphicsMatrixKey(.Heavy(detail: .TripleDash),    .Plus                ) : 0x254b,

     GraphicsMatrixKey(.Heavy(detail: .QuadrupleDash), .UpperLeftCorner     ) : 0x250f,
     GraphicsMatrixKey(.Heavy(detail: .QuadrupleDash), .LowerLeftCorner     ) : 0x2517,
     GraphicsMatrixKey(.Heavy(detail: .QuadrupleDash), .UpperRightCorner    ) : 0x2513,
     GraphicsMatrixKey(.Heavy(detail: .QuadrupleDash), .LowerRightCorner    ) : 0x251b,
     GraphicsMatrixKey(.Heavy(detail: .QuadrupleDash), .RightTee            ) : 0x252b,
     GraphicsMatrixKey(.Heavy(detail: .QuadrupleDash), .LeftTee             ) : 0x2523,
     GraphicsMatrixKey(.Heavy(detail: .QuadrupleDash), .LowerTee            ) : 0x253b,
     GraphicsMatrixKey(.Heavy(detail: .QuadrupleDash), .UpperTee            ) : 0x2533,
     GraphicsMatrixKey(.Heavy(detail: .QuadrupleDash), .HorizontalLine      ) : 0x2509,
     GraphicsMatrixKey(.Heavy(detail: .QuadrupleDash), .UpperHorizontalLine ) : 0x2509,
     GraphicsMatrixKey(.Heavy(detail: .QuadrupleDash), .LowerHorizontalLine ) : 0x2509,
     GraphicsMatrixKey(.Heavy(detail: .QuadrupleDash), .VerticalLine        ) : 0x250b,
     GraphicsMatrixKey(.Heavy(detail: .QuadrupleDash), .LeftVerticalLine    ) : 0x250b,
     GraphicsMatrixKey(.Heavy(detail: .QuadrupleDash), .RightVerticalLine   ) : 0x250b,
     GraphicsMatrixKey(.Heavy(detail: .QuadrupleDash), .Plus                ) : 0x254b,

     GraphicsMatrixKey(.Double,                        .UpperLeftCorner     ) : 0x2554,
     GraphicsMatrixKey(.Double,                        .LowerLeftCorner     ) : 0x255a,
     GraphicsMatrixKey(.Double,                        .UpperRightCorner    ) : 0x2557,
     GraphicsMatrixKey(.Double,                        .LowerRightCorner    ) : 0x255d,
     GraphicsMatrixKey(.Double,                        .RightTee            ) : 0x2563,
     GraphicsMatrixKey(.Double,                        .LeftTee             ) : 0x2560,
     GraphicsMatrixKey(.Double,                        .LowerTee            ) : 0x2569,
     GraphicsMatrixKey(.Double,                        .UpperTee            ) : 0x2566,
     GraphicsMatrixKey(.Double,                        .HorizontalLine      ) : 0x2550,
     GraphicsMatrixKey(.Double,                        .UpperHorizontalLine ) : 0x2550,
     GraphicsMatrixKey(.Double,                        .LowerHorizontalLine ) : 0x2550,
     GraphicsMatrixKey(.Double,                        .VerticalLine        ) : 0x2551,
     GraphicsMatrixKey(.Double,                        .LeftVerticalLine    ) : 0x2551,
     GraphicsMatrixKey(.Double,                        .RightVerticalLine   ) : 0x2551,
     GraphicsMatrixKey(.Double,                        .Plus                ) : 0x256c]

public struct BoxDrawing {
    private let _boxDrawingType: BoxDrawingType
    private var _boxDrawingGraphic = Dictionary<BoxDrawingGraphic, ComplexCharacter>()

    public init(_ boxDrawingType: BoxDrawingType = .Light(detail: .Normal),
                attributes:       Attributes = .Normal,
                colourPair:       ColourPair = ColourPair()) throws {
        _boxDrawingType = boxDrawingType

        switch _boxDrawingType {
            case .UserDefined(let userdefined):
                _boxDrawingGraphic = userdefined.graphic
            default:
                try BoxDrawingGraphic._allValues.forEach {
                    let matrixKey = GraphicsMatrixKey(_boxDrawingType, $0)

                    _boxDrawingGraphic[$0] = try ComplexCharacter(_graphicsMatrix[matrixKey]!,
                                                                  attributes: attributes,
                                                                  colourPair: colourPair)
                }
        }
    }

    public func graphic(_ graphic: BoxDrawingGraphic) -> ComplexCharacter {
        return _boxDrawingGraphic[graphic]!
    }

    internal func _graphic(_ graphic: BoxDrawingGraphic) -> cchar_t {
        return self.graphic(graphic)._rawValue
    }
}
