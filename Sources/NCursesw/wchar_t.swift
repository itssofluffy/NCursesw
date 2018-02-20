/*
    wchar_t.swift

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

private let _fullLowCodePoint:  wchar_t = 0xff00
private let _fullHighCodePoint: wchar_t = 0xff5e
private let _halfLowCodePoint:  wchar_t = 0x0020
private let _halfHighCodePoint: wchar_t = 0x007e

extension wchar_t {
    internal var _isFullWidthCodePoint: Bool {
        return (self >= _fullLowCodePoint && self <= _fullHighCodePoint)
    }

    internal var _isNormalWidthCodePoint: Bool {
        return (self >= _halfLowCodePoint && self <= _halfHighCodePoint)
    }

    internal var _toNormalWidthCodePoint: wchar_t? {
        if (self._isFullWidthCodePoint) {
            return (self - _fullLowCodePoint) + _halfLowCodePoint
        }

        return nil
    }

    internal var _toFullWidthCodePoint: wchar_t? {
        if (self._isNormalWidthCodePoint) {
            return (self - _halfLowCodePoint) + _fullLowCodePoint
        }

        return nil
    }
}