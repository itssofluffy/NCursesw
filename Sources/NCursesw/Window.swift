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

public class Window {
    internal var _handle: WindowHandle
    private let _initialWindow: Bool

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

    private init(handle: WindowHandle, size: Size) {
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

// http://invisible-island.net/ncurses/man/curs_getyx.3x.html
extension Window {
    public var size: Size {
        return Terminal.getSize(handle: _handle)
    }

    public var origin: Coordinate {
        return Terminal.getOrigin(handle: _handle)
    }

    public var cursor: Coordinate {
        get {
            return Terminal.getCursor(handle: _handle)
        }
        set {
            wrapper(do: {
                        try Terminal.setCursor(handle: self._handle, origin: newValue)
                    },
                    catch: { failure in
                        ncurseswErrorLogger(failure)
                    })
        }
    }
}

// http://invisible-island.net/ncurses/man/curs_inopts.3x.html
extension Window {
    public func keypad(_ on: Bool) throws {
        guard (CNCursesw.keypad(_handle, on) == OK) else {
            throw NCurseswError.KeyPad(on: on)
        }
    }

    public func meta(_ on: Bool) throws {
        guard (CNCursesw.meta(_handle, on) == OK) else {
            throw NCurseswError.Meta(on: on)
        }
    }

    public func noDelay(_ on: Bool) throws {
        guard (nodelay(_handle, on) == OK) else {
            throw NCurseswError.NoDelay(on: on)
        }
    }

    public func noTimeout(_ on: Bool) throws {
        guard (notimeout(_handle, on) == OK) else {
            throw NCurseswError.NoTimeout(on: on)
        }
    }

    public func timeout(delay: TimeInterval) {
        wtimeout(_handle, CInt(delay.milliseconds))
    }
}

// http://invisible-island.net/ncurses/man/curs_window.3x.html
extension Window {
    public func move(to origin: Coordinate) throws {
        guard (mvwin(_handle, origin._y, origin._x) == OK) else {
            throw NCurseswError.MoveWindow(origin: origin)
        }
    }

    public func duplicate() throws -> Window {
        guard let handle = dupwin(_handle) else {
            throw NCurseswError.Duplicate
        }

        return Window(handle: handle, size: size)
    }
}

// http://invisible-island.net/ncurses/man/curs_overlay.3x.html
extension Window {
    public func overlay(with window: Window) throws {
        guard (CNCursesw.overlay(window._handle, _handle) == OK) else {
            throw NCurseswError.Overlay
        }
    }

    public func overWrite(with window: Window) throws {
        guard (overwrite(window._handle, _handle) == OK) else {
            throw NCurseswError.OverWrite
        }
    }

    public func copy(with window: Window, origin: Coordinate, withOrigin: Coordinate, withSize: Size, destructive: Bool = true) throws {
        guard (copywin(window._handle, _handle, origin._y, origin._y, withOrigin._y, withOrigin._x, withSize._height, withSize._width, NCursesw._ncurseswBool(destructive)) == OK) else {
            throw NCurseswError.Copy(origin: origin, withOrigin: withOrigin, withSize: withSize, destructive: destructive)
        }
    }
}

extension Window {
    public func refresh() throws {
        try Terminal.refresh(handle: _handle)
    }

    public func updateWithoutRefresh() throws {
        try Terminal.updateWithoutRefresh(handle: _handle)
    }

    public func redraw() throws {
        try Terminal.redraw(handle: _handle)
    }

    public func redraw(from line: Int, lines count: Int) throws {
        try Terminal.redraw(handle: _handle, from: line, lines: count)
    }

    public func erase() throws {
        try Terminal.erase(handle: _handle)
    }

    public func clear() throws {
        try Terminal.clear(handle: _handle)
    }

    public func clearToBottom() throws {
        try Terminal.clearToBottom(handle: _handle)
    }

    public func clearToEndOfLine() throws {
        try Terminal.clearToEndOfLine(handle: _handle)
    }

    public func resize(to size: Size) throws {
        try Terminal.resize(handle: _handle, size: size)
    }
}

extension Window {
    public func border(_ boxDrawingType: BoxDrawingType = .Light) throws {
        try Terminal.border(handle: _handle, boxDrawingType: boxDrawingType)
    }

    public func horizontalLine(_ boxDrawingType: BoxDrawingType = .Light, length: Int) throws {
        try Terminal.horizontalLine(handle: _handle, boxDrawingType: boxDrawingType, length: length)
    }

    public func horizontalLine(origin: Coordinate, _ boxDrawingType: BoxDrawingType = .Light, length: Int) throws {
        try Terminal.horizontalLine(handle: _handle, origin: origin, boxDrawingType: boxDrawingType, length: length)
    }

    public func verticalLine(_ boxDrawingType: BoxDrawingType = .Light, length: Int) throws {
        try Terminal.verticalLine(handle: _handle, boxDrawingType: boxDrawingType, length: length)
    }

    public func verticalLine(origin: Coordinate, _ boxDrawingType: BoxDrawingType = .Light, length: Int) throws {
        try Terminal.verticalLine(handle: _handle, origin: origin, boxDrawingType: boxDrawingType, length: length)
    }
}

extension Window {
    public func put(character: ComplexCharacter) throws {
        try Terminal.put(handle: _handle, character: character)
    }

    public func put(character: ComplexCharacter, origin: Coordinate) throws {
        try Terminal.put(handle: _handle, character: character, origin: origin)
    }

    public func echo(character: ComplexCharacter) throws {
        try Terminal.echo(handle: _handle, character: character)
    }

    public func echo(character: ComplexCharacter, origin: Coordinate) throws {
        try Terminal.echo(handle: _handle, character: character, origin: origin)
    }

    public func put(string: String, length: Int = -1) throws {
        try Terminal.put(handle: _handle, string: string, length: length)
    }

    public func put(string: String, origin: Coordinate, length: Int = -1) throws {
        try Terminal.put(handle: _handle, string: string, origin: origin, length: length)
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
