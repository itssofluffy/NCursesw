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

    private init() { }

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

        if (hasColours) {
            try startColours()
        }

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
