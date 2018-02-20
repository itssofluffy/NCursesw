/*
    SoftLabelType.swift

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

public enum SoftLabelType {
    case ThreeTwoThree      //  indicates a 3-2-3 arrangement of the labels.
    case FourFour           //  indicates a 4-4 arrangement
    case FourFourFour       //  indicates the PC-like 4-4-4 mode.
    case FourFourFourIndex  //  is again the PC-like 4-4-4 mode, but in addition an index line is generated.

    public var rawValue: CInt {
        switch self {
            case .ThreeTwoThree:
                return 0
            case .FourFour:
                return 1
            case .FourFourFour:
                return 2
            case .FourFourFourIndex:
                return 3
        }
    }
}
