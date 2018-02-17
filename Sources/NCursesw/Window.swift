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
import ISFLibrary

public class Window: NCurseswWindow, Moveable {
    // http://invisible-island.net/ncurses/man/curs_window.3x.html
    public init(size: Size, origin: Coordinate) throws {
        precondition(Terminal.initialised, "Terminal.initialiseWindows() not called")

        guard let handle = newwin(size._height, size._width, origin._y, origin._x) else {
            throw NCurseswError.NewWindow(size: size, origin: origin)
        }

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
}

extension Window {
    public func move(to origin: Coordinate) throws {
        guard (mvwin(_handle, origin._y, origin._x) == OK) else {
            throw NCurseswError.MoveWindow(origin: origin)
        }
    }
}
