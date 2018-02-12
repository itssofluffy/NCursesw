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

private let __graphicsMatrix: Dictionary<GraphicsMatrixKey, wchar_t> =
    [GraphicsMatrixKey(.Ascii,                       .UpperLeftCorner     ) : 0x002b,
     GraphicsMatrixKey(.Ascii,                       .LowerLeftCorner     ) : 0x002b,
     GraphicsMatrixKey(.Ascii,                       .UpperRightCorner    ) : 0x002b,
     GraphicsMatrixKey(.Ascii,                       .LowerRightCorner    ) : 0x002b,
     GraphicsMatrixKey(.Ascii,                       .RightTee            ) : 0x002b,
     GraphicsMatrixKey(.Ascii,                       .LeftTee             ) : 0x002b,
     GraphicsMatrixKey(.Ascii,                       .LowerTee            ) : 0x002b,
     GraphicsMatrixKey(.Ascii,                       .UpperTee            ) : 0x002b,
     GraphicsMatrixKey(.Ascii,                       .HorizontalLine      ) : 0x002d,
     GraphicsMatrixKey(.Ascii,                       .UpperHorizontalLine ) : 0x002d,
     GraphicsMatrixKey(.Ascii,                       .LowerHorizontalLine ) : 0x002d,
     GraphicsMatrixKey(.Ascii,                       .VerticalLine        ) : 0x007c,
     GraphicsMatrixKey(.Ascii,                       .LeftVerticalLine    ) : 0x007c,
     GraphicsMatrixKey(.Ascii,                       .RightVerticalLine   ) : 0x007c,
     GraphicsMatrixKey(.Ascii,                       .Plus                ) : 0x002b,

     GraphicsMatrixKey(.Light(type: .Normal),        .UpperLeftCorner     ) : 0x250c,
     GraphicsMatrixKey(.Light(type: .Normal),        .LowerLeftCorner     ) : 0x2514,
     GraphicsMatrixKey(.Light(type: .Normal),        .UpperRightCorner    ) : 0x2510,
     GraphicsMatrixKey(.Light(type: .Normal),        .LowerRightCorner    ) : 0x2518,
     GraphicsMatrixKey(.Light(type: .Normal),        .RightTee            ) : 0x2524,
     GraphicsMatrixKey(.Light(type: .Normal),        .LeftTee             ) : 0x251c,
     GraphicsMatrixKey(.Light(type: .Normal),        .LowerTee            ) : 0x2534,
     GraphicsMatrixKey(.Light(type: .Normal),        .UpperTee            ) : 0x252c,
     GraphicsMatrixKey(.Light(type: .Normal),        .HorizontalLine      ) : 0x2500,
     GraphicsMatrixKey(.Light(type: .Normal),        .UpperHorizontalLine ) : 0x2500,
     GraphicsMatrixKey(.Light(type: .Normal),        .LowerHorizontalLine ) : 0x2500,
     GraphicsMatrixKey(.Light(type: .Normal),        .VerticalLine        ) : 0x2502,
     GraphicsMatrixKey(.Light(type: .Normal),        .LeftVerticalLine    ) : 0x2502,
     GraphicsMatrixKey(.Light(type: .Normal),        .RightVerticalLine   ) : 0x2502,
     GraphicsMatrixKey(.Light(type: .Normal),        .Plus                ) : 0x253c,

     GraphicsMatrixKey(.Light(type: .Rounded),       .UpperLeftCorner     ) : 0x256d,
     GraphicsMatrixKey(.Light(type: .Rounded),       .LowerLeftCorner     ) : 0x2570,
     GraphicsMatrixKey(.Light(type: .Rounded),       .UpperRightCorner    ) : 0x256e,
     GraphicsMatrixKey(.Light(type: .Rounded),       .LowerRightCorner    ) : 0x256f,
     GraphicsMatrixKey(.Light(type: .Rounded),       .RightTee            ) : 0x2524,
     GraphicsMatrixKey(.Light(type: .Rounded),       .LeftTee             ) : 0x251c,
     GraphicsMatrixKey(.Light(type: .Rounded),       .LowerTee            ) : 0x2534,
     GraphicsMatrixKey(.Light(type: .Rounded),       .UpperTee            ) : 0x252c,
     GraphicsMatrixKey(.Light(type: .Rounded),       .HorizontalLine      ) : 0x2500,
     GraphicsMatrixKey(.Light(type: .Rounded),       .UpperHorizontalLine ) : 0x2500,
     GraphicsMatrixKey(.Light(type: .Rounded),       .LowerHorizontalLine ) : 0x2500,
     GraphicsMatrixKey(.Light(type: .Rounded),       .VerticalLine        ) : 0x2502,
     GraphicsMatrixKey(.Light(type: .Rounded),       .LeftVerticalLine    ) : 0x2502,
     GraphicsMatrixKey(.Light(type: .Rounded),       .RightVerticalLine   ) : 0x2502,
     GraphicsMatrixKey(.Light(type: .Rounded),       .Plus                ) : 0x253c,

     GraphicsMatrixKey(.Light(type: .DoubleDash),    .UpperLeftCorner     ) : 0x250c,
     GraphicsMatrixKey(.Light(type: .DoubleDash),    .LowerLeftCorner     ) : 0x2514,
     GraphicsMatrixKey(.Light(type: .DoubleDash),    .UpperRightCorner    ) : 0x2510,
     GraphicsMatrixKey(.Light(type: .DoubleDash),    .LowerRightCorner    ) : 0x2518,
     GraphicsMatrixKey(.Light(type: .DoubleDash),    .RightTee            ) : 0x2524,
     GraphicsMatrixKey(.Light(type: .DoubleDash),    .LeftTee             ) : 0x251c,
     GraphicsMatrixKey(.Light(type: .DoubleDash),    .LowerTee            ) : 0x2534,
     GraphicsMatrixKey(.Light(type: .DoubleDash),    .UpperTee            ) : 0x252c,
     GraphicsMatrixKey(.Light(type: .DoubleDash),    .HorizontalLine      ) : 0x254c,
     GraphicsMatrixKey(.Light(type: .DoubleDash),    .UpperHorizontalLine ) : 0x254c,
     GraphicsMatrixKey(.Light(type: .DoubleDash),    .LowerHorizontalLine ) : 0x254c,
     GraphicsMatrixKey(.Light(type: .DoubleDash),    .VerticalLine        ) : 0x254e,
     GraphicsMatrixKey(.Light(type: .DoubleDash),    .LeftVerticalLine    ) : 0x254e,
     GraphicsMatrixKey(.Light(type: .DoubleDash),    .RightVerticalLine   ) : 0x254e,
     GraphicsMatrixKey(.Light(type: .DoubleDash),    .Plus                ) : 0x253c,

     GraphicsMatrixKey(.Light(type: .TripleDash),    .UpperLeftCorner     ) : 0x250c,
     GraphicsMatrixKey(.Light(type: .TripleDash),    .LowerLeftCorner     ) : 0x2514,
     GraphicsMatrixKey(.Light(type: .TripleDash),    .UpperRightCorner    ) : 0x2510,
     GraphicsMatrixKey(.Light(type: .TripleDash),    .LowerRightCorner    ) : 0x2518,
     GraphicsMatrixKey(.Light(type: .TripleDash),    .RightTee            ) : 0x2524,
     GraphicsMatrixKey(.Light(type: .TripleDash),    .LeftTee             ) : 0x251c,
     GraphicsMatrixKey(.Light(type: .TripleDash),    .LowerTee            ) : 0x2534,
     GraphicsMatrixKey(.Light(type: .TripleDash),    .UpperTee            ) : 0x252c,
     GraphicsMatrixKey(.Light(type: .TripleDash),    .HorizontalLine      ) : 0x2504,
     GraphicsMatrixKey(.Light(type: .TripleDash),    .UpperHorizontalLine ) : 0x2504,
     GraphicsMatrixKey(.Light(type: .TripleDash),    .LowerHorizontalLine ) : 0x2504,
     GraphicsMatrixKey(.Light(type: .TripleDash),    .VerticalLine        ) : 0x2506,
     GraphicsMatrixKey(.Light(type: .TripleDash),    .LeftVerticalLine    ) : 0x2506,
     GraphicsMatrixKey(.Light(type: .TripleDash),    .RightVerticalLine   ) : 0x2506,
     GraphicsMatrixKey(.Light(type: .TripleDash),    .Plus                ) : 0x253c,

     GraphicsMatrixKey(.Light(type: .QuadrupleDash), .UpperLeftCorner     ) : 0x250c,
     GraphicsMatrixKey(.Light(type: .QuadrupleDash), .LowerLeftCorner     ) : 0x2514,
     GraphicsMatrixKey(.Light(type: .QuadrupleDash), .UpperRightCorner    ) : 0x2510,
     GraphicsMatrixKey(.Light(type: .QuadrupleDash), .LowerRightCorner    ) : 0x2518,
     GraphicsMatrixKey(.Light(type: .QuadrupleDash), .RightTee            ) : 0x2524,
     GraphicsMatrixKey(.Light(type: .QuadrupleDash), .LeftTee             ) : 0x251c,
     GraphicsMatrixKey(.Light(type: .QuadrupleDash), .LowerTee            ) : 0x2534,
     GraphicsMatrixKey(.Light(type: .QuadrupleDash), .UpperTee            ) : 0x252c,
     GraphicsMatrixKey(.Light(type: .QuadrupleDash), .HorizontalLine      ) : 0x2508,
     GraphicsMatrixKey(.Light(type: .QuadrupleDash), .UpperHorizontalLine ) : 0x2508,
     GraphicsMatrixKey(.Light(type: .QuadrupleDash), .LowerHorizontalLine ) : 0x2508,
     GraphicsMatrixKey(.Light(type: .QuadrupleDash), .VerticalLine        ) : 0x250a,
     GraphicsMatrixKey(.Light(type: .QuadrupleDash), .LeftVerticalLine    ) : 0x250a,
     GraphicsMatrixKey(.Light(type: .QuadrupleDash), .RightVerticalLine   ) : 0x250a,
     GraphicsMatrixKey(.Light(type: .QuadrupleDash), .Plus                ) : 0x253c,

     GraphicsMatrixKey(.Heavy(type: .Normal),        .UpperLeftCorner     ) : 0x250f,
     GraphicsMatrixKey(.Heavy(type: .Normal),        .LowerLeftCorner     ) : 0x2517,
     GraphicsMatrixKey(.Heavy(type: .Normal),        .UpperRightCorner    ) : 0x2513,
     GraphicsMatrixKey(.Heavy(type: .Normal),        .LowerRightCorner    ) : 0x251b,
     GraphicsMatrixKey(.Heavy(type: .Normal),        .RightTee            ) : 0x252b,
     GraphicsMatrixKey(.Heavy(type: .Normal),        .LeftTee             ) : 0x2523,
     GraphicsMatrixKey(.Heavy(type: .Normal),        .LowerTee            ) : 0x253b,
     GraphicsMatrixKey(.Heavy(type: .Normal),        .UpperTee            ) : 0x2533,
     GraphicsMatrixKey(.Heavy(type: .Normal),        .HorizontalLine      ) : 0x2501,
     GraphicsMatrixKey(.Heavy(type: .Normal),        .UpperHorizontalLine ) : 0x2501,
     GraphicsMatrixKey(.Heavy(type: .Normal),        .LowerHorizontalLine ) : 0x2501,
     GraphicsMatrixKey(.Heavy(type: .Normal),        .VerticalLine        ) : 0x2503,
     GraphicsMatrixKey(.Heavy(type: .Normal),        .LeftVerticalLine    ) : 0x2503,
     GraphicsMatrixKey(.Heavy(type: .Normal),        .RightVerticalLine   ) : 0x2503,
     GraphicsMatrixKey(.Heavy(type: .Normal),        .Plus                ) : 0x254b,

     GraphicsMatrixKey(.Heavy(type: .DoubleDash),    .UpperLeftCorner     ) : 0x250f,
     GraphicsMatrixKey(.Heavy(type: .DoubleDash),    .LowerLeftCorner     ) : 0x2517,
     GraphicsMatrixKey(.Heavy(type: .DoubleDash),    .UpperRightCorner    ) : 0x2513,
     GraphicsMatrixKey(.Heavy(type: .DoubleDash),    .LowerRightCorner    ) : 0x251b,
     GraphicsMatrixKey(.Heavy(type: .DoubleDash),    .RightTee            ) : 0x252b,
     GraphicsMatrixKey(.Heavy(type: .DoubleDash),    .LeftTee             ) : 0x2523,
     GraphicsMatrixKey(.Heavy(type: .DoubleDash),    .LowerTee            ) : 0x253b,
     GraphicsMatrixKey(.Heavy(type: .DoubleDash),    .UpperTee            ) : 0x2533,
     GraphicsMatrixKey(.Heavy(type: .DoubleDash),    .HorizontalLine      ) : 0x254d,
     GraphicsMatrixKey(.Heavy(type: .DoubleDash),    .UpperHorizontalLine ) : 0x254d,
     GraphicsMatrixKey(.Heavy(type: .DoubleDash),    .LowerHorizontalLine ) : 0x254d,
     GraphicsMatrixKey(.Heavy(type: .DoubleDash),    .VerticalLine        ) : 0x254f,
     GraphicsMatrixKey(.Heavy(type: .DoubleDash),    .LeftVerticalLine    ) : 0x254f,
     GraphicsMatrixKey(.Heavy(type: .DoubleDash),    .RightVerticalLine   ) : 0x254f,
     GraphicsMatrixKey(.Heavy(type: .DoubleDash),    .Plus                ) : 0x254b,

     GraphicsMatrixKey(.Heavy(type: .TripleDash),    .UpperLeftCorner     ) : 0x250f,
     GraphicsMatrixKey(.Heavy(type: .TripleDash),    .LowerLeftCorner     ) : 0x2517,
     GraphicsMatrixKey(.Heavy(type: .TripleDash),    .UpperRightCorner    ) : 0x2513,
     GraphicsMatrixKey(.Heavy(type: .TripleDash),    .LowerRightCorner    ) : 0x251b,
     GraphicsMatrixKey(.Heavy(type: .TripleDash),    .RightTee            ) : 0x252b,
     GraphicsMatrixKey(.Heavy(type: .TripleDash),    .LeftTee             ) : 0x2523,
     GraphicsMatrixKey(.Heavy(type: .TripleDash),    .LowerTee            ) : 0x253b,
     GraphicsMatrixKey(.Heavy(type: .TripleDash),    .UpperTee            ) : 0x2533,
     GraphicsMatrixKey(.Heavy(type: .TripleDash),    .HorizontalLine      ) : 0x2505,
     GraphicsMatrixKey(.Heavy(type: .TripleDash),    .UpperHorizontalLine ) : 0x2505,
     GraphicsMatrixKey(.Heavy(type: .TripleDash),    .LowerHorizontalLine ) : 0x2505,
     GraphicsMatrixKey(.Heavy(type: .TripleDash),    .VerticalLine        ) : 0x2507,
     GraphicsMatrixKey(.Heavy(type: .TripleDash),    .LeftVerticalLine    ) : 0x2507,
     GraphicsMatrixKey(.Heavy(type: .TripleDash),    .RightVerticalLine   ) : 0x2507,
     GraphicsMatrixKey(.Heavy(type: .TripleDash),    .Plus                ) : 0x254b,

     GraphicsMatrixKey(.Heavy(type: .QuadrupleDash), .UpperLeftCorner     ) : 0x250f,
     GraphicsMatrixKey(.Heavy(type: .QuadrupleDash), .LowerLeftCorner     ) : 0x2517,
     GraphicsMatrixKey(.Heavy(type: .QuadrupleDash), .UpperRightCorner    ) : 0x2513,
     GraphicsMatrixKey(.Heavy(type: .QuadrupleDash), .LowerRightCorner    ) : 0x251b,
     GraphicsMatrixKey(.Heavy(type: .QuadrupleDash), .RightTee            ) : 0x252b,
     GraphicsMatrixKey(.Heavy(type: .QuadrupleDash), .LeftTee             ) : 0x2523,
     GraphicsMatrixKey(.Heavy(type: .QuadrupleDash), .LowerTee            ) : 0x253b,
     GraphicsMatrixKey(.Heavy(type: .QuadrupleDash), .UpperTee            ) : 0x2533,
     GraphicsMatrixKey(.Heavy(type: .QuadrupleDash), .HorizontalLine      ) : 0x2509,
     GraphicsMatrixKey(.Heavy(type: .QuadrupleDash), .UpperHorizontalLine ) : 0x2509,
     GraphicsMatrixKey(.Heavy(type: .QuadrupleDash), .LowerHorizontalLine ) : 0x2509,
     GraphicsMatrixKey(.Heavy(type: .QuadrupleDash), .VerticalLine        ) : 0x250b,
     GraphicsMatrixKey(.Heavy(type: .QuadrupleDash), .LeftVerticalLine    ) : 0x250b,
     GraphicsMatrixKey(.Heavy(type: .QuadrupleDash), .RightVerticalLine   ) : 0x250b,
     GraphicsMatrixKey(.Heavy(type: .QuadrupleDash), .Plus                ) : 0x254b,

     GraphicsMatrixKey(.Double,                      .UpperLeftCorner     ) : 0x2554,
     GraphicsMatrixKey(.Double,                      .LowerLeftCorner     ) : 0x255a,
     GraphicsMatrixKey(.Double,                      .UpperRightCorner    ) : 0x2557,
     GraphicsMatrixKey(.Double,                      .LowerRightCorner    ) : 0x255d,
     GraphicsMatrixKey(.Double,                      .RightTee            ) : 0x2563,
     GraphicsMatrixKey(.Double,                      .LeftTee             ) : 0x2560,
     GraphicsMatrixKey(.Double,                      .LowerTee            ) : 0x2569,
     GraphicsMatrixKey(.Double,                      .UpperTee            ) : 0x2566,
     GraphicsMatrixKey(.Double,                      .HorizontalLine      ) : 0x2550,
     GraphicsMatrixKey(.Double,                      .UpperHorizontalLine ) : 0x2550,
     GraphicsMatrixKey(.Double,                      .LowerHorizontalLine ) : 0x2550,
     GraphicsMatrixKey(.Double,                      .VerticalLine        ) : 0x2551,
     GraphicsMatrixKey(.Double,                      .LeftVerticalLine    ) : 0x2551,
     GraphicsMatrixKey(.Double,                      .RightVerticalLine   ) : 0x2551,
     GraphicsMatrixKey(.Double,                      .Plus                ) : 0x256c]

private var _graphicsMatrix = Dictionary<GraphicsMatrixKey, ComplexCharacter>()

private var _initialised = false

public struct BoxDrawing {
    private let _boxDrawingType: BoxDrawingType

    public init(_ boxDrawingType: BoxDrawingType = .Light(type: .Normal),
                attributes:       Attributes = .Normal,
                colourPair:       ColourPair = ColourPair()) throws {
        _boxDrawingType = boxDrawingType

        if (!_initialised) {
            try BoxDrawingType.allValues.forEach { boxDrawingType in
                try BoxDrawingGraphic.allValues.forEach { boxDrawingGraphic in
                    let matrixKey = GraphicsMatrixKey(boxDrawingType, boxDrawingGraphic)

                    _graphicsMatrix[matrixKey] = try ComplexCharacter(__graphicsMatrix[matrixKey]!,
                                                                      attributes: attributes,
                                                                      colourPair: colourPair)
                }
            }

            _initialised = true
        }
    }

    public func graphic(_ graphic: BoxDrawingGraphic) -> ComplexCharacter {
        return _graphicsMatrix[GraphicsMatrixKey(_boxDrawingType, graphic)]!
    }

    internal func _graphic(_ graphic: BoxDrawingGraphic) -> cchar_t {
        return _graphicsMatrix[GraphicsMatrixKey(_boxDrawingType, graphic)]!._rawValue
    }
}
