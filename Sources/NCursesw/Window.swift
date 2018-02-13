/*
    Window.swift

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
import Foundation
import ISFLibrary

public class Window: WindowProtocol {
    internal var _handle: WindowHandle
    private let _initialWindow: Bool

    public var subWindow: SubWindow? = nil

    // http://invisible-island.net/ncurses/man/curs_window.3x.html
    public init(size: Size, origin: Coordinate) throws {
        guard (Terminal.initialised) else {
            throw NCurseswError.WindowsNotInitialised
        }

        guard let handle = newwin(size._height, size._width, origin._y, origin._x) else {
            throw NCurseswError.NewWindow(size: size, origin: origin)
        }

        self._handle = handle

        _initialWindow = false
    }

    internal init(handle: WindowHandle) {
        self._handle = handle

        _initialWindow = true
    }

    internal init(handle: WindowHandle, size: Size) {
        self._handle = handle

        _initialWindow = false
    }

    //http://invisible-island.net/ncurses/man/curs_window.3x.html
    deinit {
        wrapper(do: {
                    if (!self._initialWindow) {
                        guard (delwin(self._handle) == OK) else {
                            throw NCurseswError.DeleteWindow
                        }
                    }
                },
                catch: { failure in
                    ncurseswErrorLogger(failure)
                })
    }
}

extension Window {
    public func createSubWindow(size: Size, origin: Coordinate) throws {
        subWindow = try SubWindow(window: self, size: size, origin: origin)
    }

    public func createSubWindow(window: Window, size: Size, relative: Coordinate) throws {
        subWindow = try SubWindow(window: self, size: size, relative: relative)
    }
}

extension Window: Hashable {
    public var hashValue: Int {
        return _handle.hashValue
    }
}

extension Window: Equatable {
    public static func ==(lhs: Window, rhs: Window) -> Bool {
        return (lhs._handle == rhs._handle)
    }
}
