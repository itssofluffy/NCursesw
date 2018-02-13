/*
    SubWindow.swift

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
import ISFLibrary

public class SubWindow: NCurseswWindow {
    private let _parent:  Window

    // http://invisible-island.net/ncurses/man/curs_window.3x.html
    internal init(window: Window, size: Size, origin: Coordinate) throws {
        guard let handle = subwin(window._handle, size._height, size._width, origin._y, origin._x) else {
            throw NCurseswError.SubWindow(size: size, origin: origin)
        }

        _parent = window

        super.init(handle: handle)
    }

    internal init(window: Window, size: Size, relative: Coordinate) throws {
        guard let handle = derwin(window._handle, size._height, size._width, relative._y, relative._x) else {
            throw NCurseswError.DerivedWindow(size: size, relative: relative)
        }

        _parent = window

        super.init(handle: handle)
    }

    //http://invisible-island.net/ncurses/man/curs_window.3x.html
    deinit {
        wrapper(do: {
                    guard (delwin(self._handle) == OK) else {
                        throw NCurseswError.DeleteWindow
                    }
                },
                catch: { failure in
                    ncurseswErrorLogger(failure)
                })
    }

    public override func move(to origin: Coordinate) throws {
        guard (mvderwin(_handle, origin._y, origin._x) == OK) else {
            throw NCurseswError.MoveDerivedWindow(origin: origin)
        }
    }
}
