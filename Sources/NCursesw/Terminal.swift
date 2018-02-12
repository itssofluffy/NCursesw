/*
    Terminal.swift

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
import CNCurseswExtensions
import Foundation
import ISFLibrary

public class Terminal {
    public static let sharedInstance = Terminal()

    private static var _initialWindowHandle: WindowHandle? = nil

    public static var initialised: Bool {
        if let _ = _initialWindowHandle {
            return true
        }

        return false
    }

    public private(set) static var locale: String = ""

    public private(set) static var ripOffCount = 0

    public static let origin = Coordinate(y: 0, x: 0)

    public static var size: Size {
        return Size(height: lines, width: columns)
    }

    public private(set) static var coloursStarted = false
}

// http://invisible-island.net/ncurses/man/ncurses.3x.html#h3-Initialization
extension Terminal {
    public class func initialiseWindows() throws -> Window {
        guard (!initialised) else {
            throw NCurseswError.WindowsAlreadyInitialised
        }

        locale = String(cString: setlocale(LC_ALL, ""))

        guard (ncursesw_setup()) else {
            throw NCurseswError.NCurseswSetup
        }

        guard let handle = initscr() else {
            throw NCurseswError.InitialiseWindows
        }

        guard (assume_default_colors(-1, -1) == OK) else {
            throw NCurseswError.AssumeDefaultColours
        }

        /* TODO: this is causing a segmentation fault when calling wborder_set() probabbly not initialising colour properly?
        if (hasColours) {
            try startColours()
        }
        */

        defer {
            _initialWindowHandle = handle
        }

        return Window(handle: handle)
    }

    public class func endWindows() throws {
        if (initialised) {
            guard (endwin() == OK) else {
                throw NCurseswError.EndWindows
            }
        }

        _initialWindowHandle = nil
        ripOffCount = 0
        coloursStarted = false
    }

    public static var isEndWindows: Bool {
        return isendwin()
    }
}

// http://invisible-island.net/ncurses/man/curs_inopts.3x.html
extension Terminal {
    public class func cBreak() throws {
        guard (cbreak() == OK) else {
            throw NCurseswError.CBreak
        }
    }

    public class func nocBreak() throws {
        guard (nocbreak() == OK) else {
            throw NCurseswError.NoCBreak
        }
    }

    public class func echo() throws {
        guard (CNCursesw.echo() == OK) else {
            throw NCurseswError.Echo
        }
    }

    public class func noEcho() throws {
        guard (noecho() == OK) else {
            throw NCurseswError.NoEcho
        }
    }

    public class func halfDelay(tenths: TimeInterval) throws {
        guard (halfdelay(CInt(tenths.deciseconds)) == OK) else {
            throw NCurseswError.HalfDelay(tenths: tenths)
        }
    }

    public class func interruptFlush(_ on: Bool) throws {
        guard (intrflush(nil, on) == OK) else {
            throw NCurseswError.InterruptFlush(on: on)
        }
    }

    public class func raw() throws {
        guard (CNCursesw.raw() == OK) else {
            throw NCurseswError.Raw
        }
    }

    public class func noRaw() throws {
        guard (noraw() == OK) else {
            throw NCurseswError.NoRaw
        }
    }

    public class func noInputQueueFlush() {
        noqiflush()
    }

    public class func inputQueueFlush() {
        qiflush()
    }

    public class func typeAhead(fileDescriptor: CInt) throws {
        guard (typeahead(fileDescriptor) == OK) else {
            throw NCurseswError.TypeAhead(fileDescriptor: fileDescriptor)
        }
    }
}

// http://invisible-island.net/ncurses/man/curs_kernel.3x.html
extension Terminal {
    public class func saveTerminalMode() throws {
        guard (def_prog_mode() == OK) else {
            throw NCurseswError.SaveTerminalMode
        }
    }

    public class func saveShellMode() throws {
        guard (def_shell_mode() == OK) else {
            throw NCurseswError.SaveShellMode
        }
    }

    public class func resetTerminalMode() throws {
        guard (reset_prog_mode() == OK) else {
            throw NCurseswError.ResetTerminalMode
        }
    }

    public class func resetShellMode() throws {
        guard (reset_shell_mode() == OK) else {
            throw NCurseswError.ResetShellMode
        }
    }

    public class func resetTTY() throws {
        guard (resetty() == OK) else {
            throw NCurseswError.ResetTTY
        }
    }

    public class func saveTTY() throws {
        guard (savetty() == OK) else {
            throw NCurseswError.SaveTTY
        }
    }

    public class func ripOffLine(lines: Int, ripWindow: @escaping RipOffWindowHandle) throws {
        guard (ripOffCount < NCursesw._maxRipOffLines) else {
            throw NCurseswError.MaxRipOffLines(count: NCursesw._maxRipOffLines)
        }

        guard (ripoffline(CInt(lines), ripWindow) == OK) else {
            throw NCurseswError.RipOffLine(lines: lines)
        }

        ripOffCount = ripOffCount + 1
    }

    public class func setCursor(to: CursorType) throws {
        guard (curs_set(to.rawValue) == OK) else {
            throw NCurseswError.SetCursor(to: to)
        }
    }

    //public class func namps(...       // pause for a number of milliseconds
}

// http://invisible-island.net/ncurses/man/curs_beep.3x.html
extension Terminal {
    public class func beep() throws {
        guard (CNCursesw.beep() == OK) else {
            throw NCurseswError.Beep
        }
    }

    public class func flash() throws {
        guard (CNCursesw.flash() == OK) else {
            throw NCurseswError.Flash
        }
    }
}

// http://invisible-island.net/ncurses/man/curs_refresh.3x.html
extension Terminal {
    public class func refresh(handle: WindowHandle) throws {
        guard (wrefresh(handle) == OK) else {
            throw NCurseswError.Refresh
        }
    }

    public class func updateWithoutRefresh(handle: WindowHandle) throws {
        guard (wnoutrefresh(handle) == OK) else {
            throw NCurseswError.UpdateWithoutRefresh
        }
    }

    public class func redraw(handle: WindowHandle) throws {
        guard (redrawwin(handle) == OK) else {
            throw NCurseswError.ReDraw
        }
    }

    public class func redraw(handle: WindowHandle, from line: Int, lines count: Int) throws {
        guard (wredrawln(handle, CInt(line), CInt(count)) == OK) else {
            throw NCurseswError.ReDrawLine(from: line, lines: count)
        }
    }
}

// http://invisible-island.net/ncurses/man/curs_clear.3x.html
extension Terminal {
    public class func erase(handle: WindowHandle) throws {
        guard (werase(handle) == OK) else {
            throw NCurseswError.Erase
        }
    }

    public class func clear(handle: WindowHandle) throws {
        guard (wclear(handle) == OK) else {
            throw NCurseswError.Clear
        }
    }

    public class func clearToBottom(handle: WindowHandle) throws {
        guard (wclrtobot(handle) == OK) else {
            throw NCurseswError.ClearToBottom
        }
    }

    public class func clearToEndOfLine(handle: WindowHandle) throws {
        guard (wclrtoeol(handle) == OK) else {
            throw NCurseswError.ClearToEndOfLine
        }
    }
}

// http://invisible-island.net/ncurses/man/wresize.3x.html
extension Terminal {
    public class func resize(handle: WindowHandle, size: Size) throws {
        guard (wresize(handle, size._height, size._width) == OK) else {
            throw NCurseswError.Resize(size: size)
        }
    }
}

extension Terminal {
    public class func setBackground(handle: WindowHandle, character: ComplexCharacter) throws {
        var wch = character._rawValue

        guard (wbkgrnd(handle, &wch) == OK) else {
            throw NCurseswError.SetBackground(character: character)
        }
    }

    public class func backgroundSet(handle: WindowHandle, character: ComplexCharacter) {
        var wch = character._rawValue

        wbkgrndset(handle, &wch)
    }

    public class func getBackground(handle: WindowHandle) throws -> ComplexCharacter {
        var wch = cchar_t()

        guard (wgetbkgrnd(handle, &wch) == OK) else {
            throw NCurseswError.GetBackground
        }

        return try ComplexCharacter(rawValue: wch)
    }
}

extension Terminal {
    public class func border(handle: WindowHandle,
                             boxDrawingType: BoxDrawingType = .Light,
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

        guard (wborder_set(handle, &ls, &rs, &ts, &bs, &ul, &ur, &ll, &lr) == OK) else {
            throw NCurseswError.Border(boxDrawingType: boxDrawingType, attributes: attributes, colourPair: colourPair)
        }
    }

    public class func horizontalLine(handle: WindowHandle,
                                     boxDrawingType: BoxDrawingType = .Light,
                                     attributes: Attributes = .Normal,
                                     colourPair: ColourPair = ColourPair(),
                                     length: Int) throws {
        var hl = try BoxDrawing(boxDrawingType, attributes: attributes, colourPair: colourPair)._graphic(.HorizontalLine)

        guard (whline_set(handle, &hl, CInt(length)) == OK) else {
            throw NCurseswError.HorizontalLine(boxDrawingType: boxDrawingType, attributes: attributes, colourPair: colourPair, length: length)
        }
    }

    public class func horizontalLine(handle: WindowHandle,
                                     origin: Coordinate,
                                     boxDrawingType: BoxDrawingType = .Light,
                                     attributes: Attributes = .Normal,
                                     colourPair: ColourPair = ColourPair(),
                                     length: Int) throws {
        try setCursor(handle: handle, origin: origin)

        try horizontalLine(handle: handle, boxDrawingType: boxDrawingType, length: length)
    }

    public class func verticalLine(handle: WindowHandle,
                                   boxDrawingType: BoxDrawingType = .Light,
                                   attributes: Attributes = .Normal,
                                   colourPair: ColourPair = ColourPair(),
                                   length: Int) throws {
        var vl = try BoxDrawing(boxDrawingType, attributes: attributes, colourPair: colourPair)._graphic(.VerticalLine)

        guard (wvline_set(handle, &vl, CInt(length)) == OK) else {
            throw NCurseswError.VerticalLine(boxDrawingType: boxDrawingType, attributes: attributes, colourPair: colourPair, length: length)
        }
    }

    public class func verticalLine(handle: WindowHandle,
                                   origin: Coordinate,
                                   boxDrawingType: BoxDrawingType = .Light,
                                   attributes: Attributes = .Normal,
                                   colourPair: ColourPair = ColourPair(),
                                   length: Int) throws {
        try setCursor(handle: handle, origin: origin)

        try verticalLine(handle: handle, boxDrawingType: boxDrawingType, attributes: attributes, colourPair: colourPair, length: length)
    }
}

extension Terminal {
    public class func put(handle: WindowHandle, character: ComplexCharacter) throws {
        var wch = character._rawValue

        guard (wadd_wch(handle, &wch) == OK) else {
            throw NCurseswError.PutCharacter(character: character)
        }
    }

    public class func put(handle: WindowHandle, character: ComplexCharacter, origin: Coordinate) throws {
        try setCursor(handle: handle, origin: origin)

        try put(handle: handle, character: character)
    }

    public class func echo(handle: WindowHandle, character: ComplexCharacter) throws {
        var wch = character._rawValue

        guard (wecho_wchar(handle, &wch) == OK) else {
            throw NCurseswError.EchoCharacter(character: character)
        }
    }

    public class func echo(handle: WindowHandle, character: ComplexCharacter, origin: Coordinate) throws {
        try setCursor(handle: handle, origin: origin)

        try echo(handle: handle, character: character)
    }
}

/*
extension Terminal {
    public class func put(handle: WindowHandle, character: Character) throws {
        try put(handle: handle, character: ComplexCharacter(wideCharacter: character))
    }

    public class func put(handle: WindowHandle, character: Character, origin: Coordinate) throws {
        try setCursor(handle: handle, origin: origin)

        try put(handle: handle, character: character)
    }

    public class func echo(handle: WindowHandle, character: Character) throws {
        try echo(handle: handle, character: ComplexCharacter(wideCharacter: CWideChar(String(character))!))
    }

    public class func echo(handle: WindowHandle, character: Character, origin: Coordinate) throws {
        try setCursor(handle: handle, origin: origin)

        try echo(handle: handle, character: character)
    }
}
*/

extension Terminal {
    public class func insert(handle: WindowHandle, character: ComplexCharacter) throws {
        var wch = character._rawValue

        guard (wins_wch(handle, &wch) == OK) else {
            throw NCurseswError.InsertCharacter(character: character)
        }
    }

    public class func insert(handle: WindowHandle, character: ComplexCharacter, origin: Coordinate) throws {
        try setCursor(handle: handle, origin: origin)

        try insert(handle: handle, character: character)
    }
}

/*
extension Terminal {
    public class func insert(handle: WindowHandle, character: Character) throws {
        try insert(handle: handle, character: ComplexCharacter(wideCharacter: CWideChar(String(character))!))
    }

    public class func insert(handle: WindowHandle, character: Character, origin: Coordinate) throws {
        try setCursor(handle: handle, origin: origin)

        try insert(handle: handle, character: character)
    }
}
*/

extension Terminal {
    public class func put(handle: WindowHandle, string: String, length: Int = -1) throws {
        let length = (length < 0) ? string.utf8.count : length
        var wch = string.unicodeScalars.flatMap { wchar_t($0.value) }

        guard (waddnwstr(handle, &wch, CInt(length)) == OK) else {
            throw NCurseswError.PutString(string: string, length: length)
        }
    }

    public class func put(handle: WindowHandle, string: String, origin: Coordinate, length: Int = -1) throws {
        try setCursor(handle: handle, origin: origin)

        try put(handle: handle, string: string, length: length)
    }
}

extension Terminal {
    public class func insert(handle: WindowHandle, string: String, length: Int = -1) throws {
        let length = (length < 0) ? string.utf8.count : length
        var wch = string.unicodeScalars.flatMap { wchar_t($0.value) }

        guard (wins_nwstr(handle, &wch, CInt(length)) == OK) else {
            throw NCurseswError.InsertString(string: string, length: length)
        }
    }

    public class func insert(handle: WindowHandle, string: String, origin: Coordinate, length: Int = -1) throws {
        try setCursor(handle: handle, origin: origin)

        try insert(handle: handle, string: string, length: length)
    }
}

extension Terminal {
    public class func read(handle: WindowHandle) throws -> UIResult<UnicodeScalar?> {
        var wch = wint_t()

        let returnCode = wget_wch(handle, &wch)

        var keyCode: Bool {
            return (returnCode == KEY_CODE_YES)
        }

        guard (returnCode == OK || keyCode) else {
            throw NCurseswError.ReadCharacter
        }

        return (keyCode) ? UIResult(KeyCode(rawValue: wch)) : UIResult(UnicodeScalar(wch))
    }

    public class func read(handle: WindowHandle, origin: Coordinate) throws -> UIResult<UnicodeScalar?> {
        try setCursor(handle: handle, origin: origin)

        return try read(handle: handle)
    }

    public class func unRead(character: UnicodeScalar) throws {
        let wch = wchar_t(UInt32(character))

        guard (unget_wch(wch) == OK) else {
            throw NCurseswError.UnReadCharacter(character: character)
        }
    }
}

extension Terminal {
    public class func read(handle: WindowHandle) throws -> UIResult<Character?> {
        let result: UIResult<UnicodeScalar?> = try read(handle: handle)

        return (result.isKeyCode) ? UIResult(result.keyCode!) : UIResult(result.value.map { Character($0!) })
    }

    public class func read(handle: WindowHandle, origin: Coordinate) throws -> UIResult<Character?> {
        try setCursor(handle: handle, origin: origin)

        return try read(handle: handle)
    }

    public class func unRead(character: Character) throws {
        let scalars = String(character).unicodeScalars

        try unRead(character: scalars[scalars.startIndex])
    }
}

extension Terminal {
    public class func read(handle: WindowHandle, length: Int) throws -> Array<UnicodeScalar?> {
        var wstr = Array<wint_t>()

        let returnCode = wgetn_wstr(handle, &wstr, CInt(length))

        guard (returnCode == OK || returnCode == WEOF) else {
            throw NCurseswError.ReadCharacters(length: length)
        }

        return wstr.map { UnicodeScalar($0) }
    }

    public class func read(handle: WindowHandle, origin: Coordinate, length: Int) throws -> Array<UnicodeScalar?> {
        try setCursor(handle: handle, origin: origin)

        return try read(handle: handle, length: length)
    }
}

extension Terminal {
    public class func read(handle: WindowHandle, length: Int) throws -> Array<Character?> {
        let unicodeScalars: Array<UnicodeScalar?> = try read(handle: handle, length: length)

        return unicodeScalars.map { Character($0!) }
    }

    public class func read(handle: WindowHandle, origin: Coordinate, length: Int) throws -> Array<Character?> {
        try setCursor(handle: handle, origin: origin)

        return try read(handle: handle, length: length)
    }
}

extension Terminal {
    public class func deleteCharacter(handle: WindowHandle) throws {
        guard (wdelch(handle) == OK) else {
            throw NCurseswError.DeleteCharacter
        }
    }

    public class func deleteCharacter(handle: WindowHandle, origin: Coordinate) throws {
        try setCursor(handle: handle, origin: origin)

        try deleteCharacter(handle: handle)
    }
}

extension Terminal {
    public class func insertLine(handle: WindowHandle) throws {
        guard (winsertln(handle) == OK) else {
            throw NCurseswError.InsertLine
        }
    }

    public class func insertLine(handle: WindowHandle, origin: Coordinate) throws {
        try setCursor(handle: handle, origin: origin)

        try insertLine(handle: handle)
    }

    public class func insertDelete(handle: WindowHandle, lines: Int) throws {
        guard (winsdelln(handle, CInt(lines)) == OK) else {
            throw NCurseswError.InsertDelete(lines: lines)
        }
    }

    public class func insertDelete(handle: WindowHandle, lines: Int, origin: Coordinate) throws {
        try setCursor(handle: handle, origin: origin)

        try insertDelete(handle: handle, lines: lines)
    }

    public class func deleteLine(handle: WindowHandle) throws {
        guard (wdeleteln(handle) == OK) else {
            throw NCurseswError.DeleteLine
        }
    }

    public class func deleteLine(handle: WindowHandle, origin: Coordinate) throws {
        try setCursor(handle: handle, origin: origin)

        try deleteLine(handle: handle)
    }
}

extension Terminal {
    public class func getAttributes(handle: WindowHandle) throws -> WindowAttributes {
        var attrs = attr_t()
        var pair = CShort()

        guard (wattr_get(handle, &attrs, &pair, nil) == OK) else {
            throw NCurseswError.GetAttributes
        }

        return try WindowAttributes(attributes: Attributes(rawValue: attrs), colourPair: getColour(pair: pair))
    }

    public class func getAttributes(handle: WindowHandle, origin: Coordinate) throws -> WindowAttributes {
        try setCursor(handle: handle, origin: origin)

        return try getAttributes(handle: handle)
    }

    public class func setAttributes(handle: WindowHandle, attributes: Attributes, colourPair: ColourPair) throws {
        guard (wattr_set(handle, attributes.rawValue, CShort(colourPair.rawValue), nil) == OK) else {
            throw NCurseswError.SetAttributes(attributes: attributes, colourPair: colourPair)
        }
    }

    public class func setAttributes(handle: WindowHandle, attributes: Attributes, colourPair: ColourPair, origin: Coordinate) throws {
        try setCursor(handle: handle, origin: origin)

        try setAttributes(handle: handle, attributes: attributes, colourPair: colourPair)
    }

    public class func attributesOn(handle: WindowHandle, attributes: Attributes) throws {
        guard (wattr_on(handle, attributes.rawValue, nil) == OK) else {
            throw NCurseswError.AttributesOn(attributes: attributes)
        }
    }

    public class func attributesOn(handle: WindowHandle, attributes: Attributes, origin: Coordinate) throws {
        try setCursor(handle: handle, origin: origin)

        try attributesOn(handle: handle, attributes: attributes)
    }

    public class func attributesOff(handle: WindowHandle, attributes: Attributes) throws {
        guard (wattr_off(handle, attributes.rawValue, nil) == OK) else {
            throw NCurseswError.AttributesOn(attributes: attributes)
        }
    }

    public class func attributesOff(handle: WindowHandle, attributes: Attributes, origin: Coordinate) throws {
        try setCursor(handle: handle, origin: origin)

        try attributesOff(handle: handle, attributes: attributes)
    }

    public class func setColour(handle: WindowHandle, colourPair: ColourPair) throws {
        guard (wcolor_set(handle, CShort(colourPair.rawValue), nil) == OK) else {
            throw NCurseswError.SetColour(colourPair: colourPair)
        }
    }

    public class func setColour(handle: WindowHandle, colourPair: ColourPair, origin: Coordinate) throws {
        try setCursor(handle: handle, origin: origin)

        try setColour(handle: handle, colourPair: colourPair)
    }

    public class func changeAttributes(handle: WindowHandle, count: Int, windowAttributes: WindowAttributes) throws {
        guard (wchgat(handle, CInt(count), windowAttributes.attributes.rawValue, CShort(windowAttributes.colourPair.rawValue), nil) == OK) else {
            throw NCurseswError.ChangeAttributes(count: count, windowAttributes: windowAttributes)
        }
    }

    public class func changeAttributes(handle: WindowHandle, count: Int, windowAttributes: WindowAttributes, origin: Coordinate) throws {
        try setCursor(handle: handle, origin: origin)

        try changeAttributes(handle: handle, count: count, windowAttributes: windowAttributes)
    }

}

// http://invisible-island.net/ncurses/man/curs_variables.3x.html
extension Terminal {
    public static var colourPairs: Int {
        return Int(COLOR_PAIRS)
    }

    public static var colours: Int {
        return Int(COLORS)
    }

    public static var columns: Int {
        return Int(COLS)
    }

    public static var escpaeDelay: TimeInterval {
        return TimeInterval(milliseconds: Int(ESCDELAY))
    }

    public static var lines: Int {
        return Int(LINES)
    }

    public static var tabSize: Int {
        return Int(TABSIZE)
    }

    public static var currentScreen: WindowHandle {
        return CNCursesw.curscr
    }

    public static var newScreen: WindowHandle {
        return CNCursesw.newscr
    }

    public static var standardScreen: WindowHandle {
        return CNCursesw.stdscr
    }
}

// http://invisible-island.net/ncurses/man/curs_color.3x.html
extension Terminal {
    public class func startColours() throws {
        guard (start_color() == OK) else {
            throw NCurseswError.StartColours
        }

        coloursStarted = true
    }

    public static var hasColours: Bool {
        return has_colors()
    }

    public static var canChangeColours: Bool {
        return can_change_color()
    }

    public class func initialisePair(pair: CShort, palette: ColourPalette) throws {
        guard (init_pair(pair, palette.foreground.rawValue, palette.background.rawValue) == OK) else {
            throw NCurseswError.InitialisePair(pair: pair, palette: palette)
        }
    }

    public class func initialiseColour(colour: Colour, rgb: RGB) throws {
        guard (init_color(colour.rawValue, rgb._red, rgb._green, rgb._blue) == OK) else {
            throw NCurseswError.InitialiseColour(colour: colour, rgb: rgb)
        }
    }

    public class func colourContent(colour: Colour) throws -> RGB {
        var red: CShort = 0
        var green: CShort = 0
        var blue: CShort = 0

        guard (color_content(colour.rawValue, &red, &green, &blue) == OK) else {
            throw NCurseswError.ColourContent(colour: colour)
        }

        return try RGB(red: red, green: green, blue: blue)
    }

    public class func pairContent(pair: CShort) throws -> ColourPalette {
        var foreground: CShort = 0
        var background: CShort = 0

        guard (pair_content(pair, &foreground, &background) == OK) else {
            throw NCurseswError.PairContent(pair: pair)
        }

        return ColourPalette(foreground: Colour(rawValue: foreground), background: Colour(rawValue: background))
    }
}

// http://invisible-island.net/ncurses/man/curs_refresh.3x.html
extension Terminal {
    public class func doUpdate() throws {
        guard (doupdate() == OK) else {
            throw NCurseswError.DoUpdate
        }
    }
}

// http://invisible-island.net/ncurses/man/curs_getyx.3x.html
extension Terminal {
    public class func getSize(handle: WindowHandle) -> Size {
        return Size(height: getmaxy(handle), width: getmaxx(handle))
    }

    public class func getOrigin(handle: WindowHandle) -> Coordinate {
        return Coordinate(y: getbegy(handle), x: getbegx(handle))
    }

    public class func getCursor(handle: WindowHandle) -> Coordinate {
        return Coordinate(y: getcury(handle), x: getcurx(handle))
    }

    public class func setCursor(handle: WindowHandle, origin: Coordinate) throws {
        guard (wmove(handle, origin._y, origin._x) == OK) else {
            throw NCurseswError.MoveCursor(cursor: origin)
        }
    }
}
