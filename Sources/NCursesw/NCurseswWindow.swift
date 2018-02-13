/*
    NCurseswWindow.swift

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

public class NCurseswWindow {
    internal var _handle: WindowHandle

    public init(handle: WindowHandle) {
        _handle = handle
    }
}

// http://invisible-island.net/ncurses/man/curs_getyx.3x.html
extension NCurseswWindow {
    public var size: Size {
        return Size(height: getmaxy(_handle), width: getmaxx(_handle))
    }

    public var origin: Coordinate {
        return Coordinate(y: getbegy(_handle), x: getbegx(_handle))
    }

    public var cursor: Coordinate {
        get {
            return Coordinate(y: getcury(_handle), x: getcurx(_handle))
        }
        set (origin) {
            wrapper(do: {
                        guard (wmove(self._handle, origin._y, origin._x) == OK) else {
                            throw NCurseswError.MoveCursor(cursor: origin)
                        }
                    },
                    catch: { failure in
                        ncurseswErrorLogger(failure)
                    })
        }
    }
}

extension NCurseswWindow {
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

extension NCurseswWindow {
    public func duplicate() throws -> NCurseswWindow {
        guard let handle = dupwin(_handle) else {
            throw NCurseswError.Duplicate
        }

        return NCurseswWindow(handle: handle)
    }

    public func overlay(with window: NCurseswWindow) throws {
        guard (CNCursesw.overlay(window._handle, _handle) == OK) else {
            throw NCurseswError.Overlay
        }
    }

    public func overWrite(with window: NCurseswWindow) throws {
        guard (overwrite(window._handle, _handle) == OK) else {
            throw NCurseswError.OverWrite
        }
    }

    public func copy(with window: NCurseswWindow, origin: Coordinate, withOrigin: Coordinate, withSize: Size, destructive: Bool = true) throws {
        guard (copywin(window._handle, _handle,
                       origin._y, origin._y,
                       withOrigin._y, withOrigin._x,
                       withSize._height, withSize._width,
                       NCursesw._ncurseswBool(destructive)) == OK) else {
            throw NCurseswError.Copy(origin: origin, withOrigin: withOrigin, withSize: withSize, destructive: destructive)
        }
    }
}

// http://invisible-island.net/ncurses/man/curs_refresh.3x.html
extension NCurseswWindow {
    public func refresh() throws {
        guard (wrefresh(_handle) == OK) else {
            throw NCurseswError.Refresh
        }
    }

    public func updateWithoutRefresh() throws {
        guard (wnoutrefresh(_handle) == OK) else {
            throw NCurseswError.UpdateWithoutRefresh
        }
    }

    public func redraw() throws {
        guard (redrawwin(_handle) == OK) else {
            throw NCurseswError.ReDraw
        }
    }

    public func redraw(from line: Int, lines count: Int) throws {
        guard (wredrawln(_handle, CInt(line), CInt(count)) == OK) else {
            throw NCurseswError.ReDrawLine(from: line, lines: count)
        }
    }
}

// http://invisible-island.net/ncurses/man/curs_clear.3x.html
extension NCurseswWindow {
    public func erase() throws {
        guard (werase(_handle) == OK) else {
            throw NCurseswError.Erase
        }
    }

    public func clear() throws {
        guard (wclear(_handle) == OK) else {
            throw NCurseswError.Clear
        }
    }

    public func clearToBottom() throws {
        guard (wclrtobot(_handle) == OK) else {
            throw NCurseswError.ClearToBottom
        }
    }

    public func clearToEndOfLine() throws {
        guard (wclrtoeol(_handle) == OK) else {
            throw NCurseswError.ClearToEndOfLine
        }
    }
}

// http://invisible-island.net/ncurses/man/wresize.3x.html
extension NCurseswWindow {
    public func resize(size: Size) throws {
        guard (wresize(_handle, size._height, size._width) == OK) else {
            throw NCurseswError.Resize(size: size)
        }
    }
}

extension NCurseswWindow {
    public func setBackground(character: ComplexCharacter) throws {
        var wch = character._rawValue

        guard (wbkgrnd(_handle, &wch) == OK) else {
            throw NCurseswError.SetBackground(character: character)
        }
    }

    public func backgroundSet(character: ComplexCharacter) {
        var wch = character._rawValue

        wbkgrndset(_handle, &wch)
    }

    public func getBackground() throws -> ComplexCharacter {
        var wch = cchar_t()

        guard (wgetbkgrnd(_handle, &wch) == OK) else {
            throw NCurseswError.GetBackground
        }

        return try ComplexCharacter(rawValue: wch)
    }
}

extension NCurseswWindow {
    public func border(_ boxDrawingType: BoxDrawingType = .Light(detail: .Normal),
                       attributes: Attributes = .Normal,
                       colourPair: ColourPair = ColourPair()) throws {
        let boxDrawings = try BoxDrawing(boxDrawingType, attributes: attributes, colourPair: colourPair)

        var ls = boxDrawings._graphic(.LeftVerticalLine)
        var rs = boxDrawings._graphic(.RightVerticalLine)
        var ts = boxDrawings._graphic(.UpperHorizontalLine)
        var bs = boxDrawings._graphic(.LowerHorizontalLine)
        var ul = boxDrawings._graphic(.UpperLeftCorner)
        var ur = boxDrawings._graphic(.UpperRightCorner)
        var ll = boxDrawings._graphic(.LowerLeftCorner)
        var lr = boxDrawings._graphic(.LowerRightCorner)

        guard (wborder_set(_handle, &ls, &rs, &ts, &bs, &ul, &ur, &ll, &lr) == OK) else {
            throw NCurseswError.Border(boxDrawingType: boxDrawingType, attributes: attributes, colourPair: colourPair)
        }
    }

    public func horizontalLine(_ boxDrawingType: BoxDrawingType = .Light(detail: .Normal),
                               attributes: Attributes = .Normal,
                               colourPair: ColourPair = ColourPair(),
                               length: Int) throws {
        var hl = try BoxDrawing(boxDrawingType, attributes: attributes, colourPair: colourPair)._graphic(.HorizontalLine)

        guard (whline_set(_handle, &hl, CInt(length)) == OK) else {
            throw NCurseswError.HorizontalLine(boxDrawingType: boxDrawingType, attributes: attributes, colourPair: colourPair, length: length)
        }
    }

    public func horizontalLine(origin: Coordinate,
                               _ boxDrawingType: BoxDrawingType = .Light(detail: .Normal),
                               attributes: Attributes = .Normal,
                               colourPair: ColourPair = ColourPair(),
                               length: Int) throws {
        cursor = origin

        try horizontalLine(boxDrawingType, length: length)
    }

    public func verticalLine(_ boxDrawingType: BoxDrawingType = .Light(detail: .Normal),
                             attributes: Attributes = .Normal,
                             colourPair: ColourPair = ColourPair(),
                             length: Int) throws {
        var vl = try BoxDrawing(boxDrawingType, attributes: attributes, colourPair: colourPair)._graphic(.VerticalLine)

        guard (wvline_set(_handle, &vl, CInt(length)) == OK) else {
            throw NCurseswError.VerticalLine(boxDrawingType: boxDrawingType, attributes: attributes, colourPair: colourPair, length: length)
        }
    }

    public func verticalLine(origin: Coordinate,
                             _ boxDrawingType: BoxDrawingType = .Light(detail: .Normal),
                             attributes: Attributes = .Normal,
                             colourPair: ColourPair = ColourPair(),
                             length: Int) throws {
        cursor = origin

        try verticalLine(boxDrawingType, attributes: attributes, colourPair: colourPair, length: length)
    }
}

extension NCurseswWindow {
    public func print(character: ComplexCharacter) throws {
        var wch = character._rawValue

        guard (wadd_wch(_handle, &wch) == OK) else {
            throw NCurseswError.PutCharacter(character: character)
        }
    }

    public func print(character: ComplexCharacter, origin: Coordinate) throws {
        cursor = origin

        try print(character: character)
    }

    public func echo(character: ComplexCharacter) throws {
        var wch = character._rawValue

        guard (wecho_wchar(_handle, &wch) == OK) else {
            throw NCurseswError.EchoCharacter(character: character)
        }
    }

    public func echo(character: ComplexCharacter, origin: Coordinate) throws {
        cursor = origin

        try echo(character: character)
    }
}

extension NCurseswWindow {
    public func print(character: Character) throws {
        try print(character: ComplexCharacter(character.unicodeScalarCodePoint))
    }

    public func print(character: Character, origin: Coordinate) throws {
        cursor = origin

        try print(character: character)
    }

    public func echo(character: Character) throws {
        try echo(character: ComplexCharacter(character.unicodeScalarCodePoint))
    }

    public func echo(character: Character, origin: Coordinate) throws {
        cursor = origin

        try echo(character: character)
    }
}

extension NCurseswWindow {
    public func insert(character: ComplexCharacter) throws {
        var wch = character._rawValue

        guard (wins_wch(_handle, &wch) == OK) else {
            throw NCurseswError.InsertCharacter(character: character)
        }
    }

    public func insert(character: ComplexCharacter, origin: Coordinate) throws {
        cursor = origin

        try insert(character: character)
    }
}

/*
extension NCurseswWindow {
    public func insert(character: Character) throws {
        try insert(character: ComplexCharacter(wideCharacter: CWideChar(String(character))!))
    }

    public func insert(character: Character, origin: Coordinate) throws {
        cursor = origin

        try insert(character: character)
    }
}
*/

extension NCurseswWindow {
    public func print(string: String, length: Int = -1) throws {
        let length = (length < 0) ? string.utf8.count : length
        var wch = string.unicodeScalars.flatMap { wchar_t($0.value) }

        guard (waddnwstr(_handle, &wch, CInt(length)) == OK) else {
            throw NCurseswError.PutString(string: string, length: length)
        }
    }

    public func print(string: String, origin: Coordinate, length: Int = -1) throws {
        cursor = origin

        try print(string: string, length: length)
    }
}

extension NCurseswWindow {
    public func insert(string: String, length: Int = -1) throws {
        let length = (length < 0) ? string.utf8.count : length
        var wch = string.unicodeScalars.flatMap { wchar_t($0.value) }

        guard (wins_nwstr(_handle, &wch, CInt(length)) == OK) else {
            throw NCurseswError.InsertString(string: string, length: length)
        }
    }

    public func insert(string: String, origin: Coordinate, length: Int = -1) throws {
        cursor = origin

        try insert(string: string, length: length)
    }
}

extension NCurseswWindow {
    public func read() throws -> UIResult<UnicodeScalar?> {
        var wch = wint_t()

        let returnCode = wget_wch(_handle, &wch)

        var keyCode: Bool {
            return (returnCode == KEY_CODE_YES)
        }

        guard (returnCode == OK || keyCode) else {
            throw NCurseswError.ReadCharacter
        }

        return (keyCode) ? UIResult(KeyCode(rawValue: wch)) : UIResult(UnicodeScalar(wch))
    }

    public func read(origin: Coordinate) throws -> UIResult<UnicodeScalar?> {
        cursor = origin

        return try read()
    }

    public func unRead(character: wchar_t) throws {
        guard (unget_wch(character) == OK) else {
            throw NCurseswError.UnReadCharacter(character: character)
        }
    }
}

extension NCurseswWindow {
    public func read() throws -> UIResult<Character?> {
        let result: UIResult<UnicodeScalar?> = try read()

        return (result.isKeyCode) ? UIResult(result.keyCode!) : UIResult(result.value.map { Character($0!) })
    }

    public func read(origin: Coordinate) throws -> UIResult<Character?> {
        cursor = origin

        return try read()
    }

    public func unRead(character: Character) throws {
        try unRead(character: character.unicodeScalarCodePoint)
    }
}

extension NCurseswWindow {
    public func read(length: Int) throws -> Array<UnicodeScalar?> {
        var wstr = Array<wint_t>()

        let returnCode = wgetn_wstr(_handle, &wstr, CInt(length))

        guard (returnCode == OK || returnCode == WEOF) else {
            throw NCurseswError.ReadCharacters(length: length)
        }

        return wstr.map { UnicodeScalar($0) }
    }

    public func read(origin: Coordinate, length: Int) throws -> Array<UnicodeScalar?> {
        cursor = origin

        return try read(length: length)
    }
}

extension NCurseswWindow {
    public func read(length: Int) throws -> Array<Character?> {
        let unicodeScalars: Array<UnicodeScalar?> = try read(length: length)

        return unicodeScalars.map { Character($0!) }
    }

    public func read(origin: Coordinate, length: Int) throws -> Array<Character?> {
        cursor = origin

        return try read(length: length)
    }
}

extension NCurseswWindow {
    public func deleteCharacter() throws {
        guard (wdelch(_handle) == OK) else {
            throw NCurseswError.DeleteCharacter
        }
    }

    public func deleteCharacter(origin: Coordinate) throws {
        cursor = origin

        try deleteCharacter()
    }
}

extension NCurseswWindow {
    public func insertLine() throws {
        guard (winsertln(_handle) == OK) else {
            throw NCurseswError.InsertLine
        }
    }

    public func insertLine(origin: Coordinate) throws {
        cursor = origin

        try insertLine()
    }

    public func insertDelete(lines: Int) throws {
        guard (winsdelln(_handle, CInt(lines)) == OK) else {
            throw NCurseswError.InsertDelete(lines: lines)
        }
    }

    public func insertDelete(lines: Int, origin: Coordinate) throws {
        cursor = origin

        try insertDelete(lines: lines)
    }

    public func deleteLine() throws {
        guard (wdeleteln(_handle) == OK) else {
            throw NCurseswError.DeleteLine
        }
    }

    public func deleteLine(origin: Coordinate) throws {
        cursor = origin

        try deleteLine()
    }
}

extension NCurseswWindow {
    public func getAttributes() throws -> WindowAttributes {
        var attrs = attr_t()
        var pair = CShort()

        guard (wattr_get(_handle, &attrs, &pair, nil) == OK) else {
            throw NCurseswError.GetAttributes
        }

        return try WindowAttributes(attributes: Attributes(rawValue: attrs), colourPair: getColour(pair: pair))
    }

    public func getAttributes(origin: Coordinate) throws -> WindowAttributes {
        cursor = origin

        return try getAttributes()
    }

    public func setAttributes(attributes: Attributes, colourPair: ColourPair) throws {
        guard (wattr_set(_handle, attributes.rawValue, CShort(colourPair.rawValue), nil) == OK) else {
            throw NCurseswError.SetAttributes(attributes: attributes, colourPair: colourPair)
        }
    }

    public func setAttributes(attributes: Attributes, colourPair: ColourPair, origin: Coordinate) throws {
        cursor = origin

        try setAttributes(attributes: attributes, colourPair: colourPair)
    }

    public func attributesOn(attributes: Attributes) throws {
        guard (wattr_on(_handle, attributes.rawValue, nil) == OK) else {
            throw NCurseswError.AttributesOn(attributes: attributes)
        }
    }

    public func attributesOn(attributes: Attributes, origin: Coordinate) throws {
        cursor = origin

        try attributesOn(attributes: attributes)
    }

    public func attributesOff(attributes: Attributes) throws {
        guard (wattr_off(_handle, attributes.rawValue, nil) == OK) else {
            throw NCurseswError.AttributesOn(attributes: attributes)
        }
    }

    public func attributesOff(attributes: Attributes, origin: Coordinate) throws {
        cursor = origin

        try attributesOff(attributes: attributes)
    }

    public func setColour(colourPair: ColourPair) throws {
        guard (wcolor_set(_handle, CShort(colourPair.rawValue), nil) == OK) else {
            throw NCurseswError.SetColour(colourPair: colourPair)
        }
    }

    public func setColour(colourPair: ColourPair, origin: Coordinate) throws {
        cursor = origin

        try setColour(colourPair: colourPair)
    }

    public func changeAttributes(count: Int, windowAttributes: WindowAttributes) throws {
        guard (wchgat(_handle, CInt(count), windowAttributes.attributes.rawValue, CShort(windowAttributes.colourPair.rawValue), nil) == OK) else {
            throw NCurseswError.ChangeAttributes(count: count, windowAttributes: windowAttributes)
        }
    }

    public func changeAttributes(count: Int, windowAttributes: WindowAttributes, origin: Coordinate) throws {
        cursor = origin

        try changeAttributes(count: count, windowAttributes: windowAttributes)
    }
}

extension NCurseswWindow {
    public func touch() throws {
        guard (touchwin(_handle) == OK) else {
            throw NCurseswError.TouchWindow
        }
    }

    public func touchLine(start: Int, count: Int) throws {
        guard (touchline(_handle, CInt(start), CInt(count)) == OK) else {
            throw NCurseswError.TouchLine(start: start, count: count)
        }
    }

    public func unTouch() throws {
        guard (untouchwin(_handle) == OK) else {
            throw NCurseswError.UnTouchWindow
        }
    }

    public func touchLine(start: Int, count: Int, change: Bool) throws {
        guard (wtouchln(_handle, CInt(start), CInt(count), NCursesw._ncurseswBool(change)) == OK) else {
            throw NCurseswError.WTouchLine(start: start, count: count, change: change)
        }
    }

    public func isTouched(line: Int) -> Bool {
        return is_linetouched(_handle, CInt(line))
    }

    public func isTouched() -> Bool {
        return is_wintouched(_handle)
    }
}

extension NCurseswWindow: Hashable {
    public var hashValue: Int {
        return _handle.hashValue
    }
}

extension NCurseswWindow: Equatable {
    public static func ==(lhs: NCurseswWindow, rhs: NCurseswWindow) -> Bool {
        return (lhs._handle == rhs._handle)
    }
}