/*
    UIResult.swift

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

/// Either a Value value or an KeyCode
public enum UIResult<T> {
    case Value(T)             // Value wraps a T value
    case KeyPressed(KeyCode)  // KeyPressed wraps an KeyCode

    /// Constructs a wrapping of a `value`.
    public init(_ value: T) {
        self = .Value(value)
    }

    /// Constructs a wrapping of `KeyCode`.
    public init(_ keyCode: KeyCode) {
        self = .KeyPressed(keyCode)
    }

    /// Convenience getter for the value
    public var value: T? {
        switch self {
            case .Value(let value):
                return value
            case .KeyPressed:
                return nil
        }
    }

    /// Convenience getter for the KeyCode
    public var keyCode: KeyCode? {
        switch self {
            case .Value:
                return nil
            case .KeyPressed(let keyCode):
                return keyCode
        }
    }

    /// Test whether the result is a KeyCode.
    public var isKeyCode: Bool {
        switch self {
            case .Value:
                return false
            case .KeyPressed:
                return true
        }
    }
}
