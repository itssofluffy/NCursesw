/*
    RGB.swift

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

public struct RGB {
    public let red:   Int
    public let green: Int
    public let blue:  Int

    public init(red: Int, green: Int, blue: Int) throws {
        guard ((red >= 0 && red <= 1000) && (green >= 0 && green <= 1000) && (blue >= 0 && blue <= 1000)) else {
            throw NCurseswError.RGB(red: red, green: green, blue: blue)
        }

        self.red = red
        self.green = green
        self.blue = blue
    }

    internal init(red: CInt, green: CInt, blue: CInt) throws {
        try self.init(red: Int(red), green: Int(green), blue: Int(blue))
    }

    internal var _red: CInt {
        return CInt(red)
    }

    internal var _green: CInt {
        return CInt(green)
    }

    internal var _blue: CInt {
        return CInt(blue)
    }
}

extension RGB: CustomStringConvertible {
    public var description: String {
        return "red: \(red), green: \(green), blue: \(blue)"
    }
}
