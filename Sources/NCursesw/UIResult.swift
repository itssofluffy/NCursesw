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

/// Either a Value of T, KeyCode, neither (Timeout) or T and KeyCode.
public enum UIResult<T> {
    case Value(T)                         // Value wraps a T value
    case KeyPressed(KeyCode)              // KeyPressed wraps an KeyCode
    case Timeout                          // Timed out.
    case ValueAndKeyPressed(T, KeyCode)   // ValueAndKeyPressed wraps a T value and KeyCode.

    /// Constructs a wrapping of a `T`.
    internal init(_ value: T) {
        self = .Value(value)
    }

    /// Constructs a wrapping of `KeyCode`.
    internal init(_ keyCode: KeyCode) {
        self = .KeyPressed(keyCode)
    }

    /// Construct a wrapping for `Timeout`.
    internal init() {
        self = .Timeout
    }

    /// Construct a wrapping of a `T` and `KeyCode` combination.
    internal init(_ value: T, _ keyCode: KeyCode) {
        self = .ValueAndKeyPressed(value, keyCode)
    }

    /// Convenience getter for the `T`.
    public var value: T? {
        switch self {
            case .Value(let value):
                return value
            case .ValueAndKeyPressed(let value, _):
                return value
            default:
                return nil
        }
    }

    /// Convenience getter for the `KeyCode`.
    public var keyCode: KeyCode? {
        switch self {
            case .KeyPressed(let keyCode):
                return keyCode
            case .ValueAndKeyPressed(_, let keyCode):
                return keyCode
            default:
                return nil
        }
    }

    /// Test whether the result is a `KeyCode`.
    public var hasKeyCode: Bool {
        switch self {
            case .Value, .Timeout:
                return false
            default:
                return true
        }
    }

    /// Test whether the result is a Timeout.
    public var hasTimedout: Bool {
        switch self {
            case .Timeout:
                return true
            default:
                return false
        }
    }
}
