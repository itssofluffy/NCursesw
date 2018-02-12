/*
    NCurseswError.swift

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

public enum NCurseswError: Error {
    case WindowsAlreadyInitialised
    case WindowsNotInitialised
    case AssumeDefaultColours
    case NCurseswSetup

    case InitialiseWindows
    case EndWindows
    case CBreak
    case NoCBreak
    case Echo
    case NoEcho
    case HalfDelay(tenths: TimeInterval)
    case InterruptFlush(on: Bool)
    case Raw
    case NoRaw
    case TypeAhead(fileDescriptor: CInt)
    case DoUpdate
    case MoveCursor(cursor: Coordinate)
    case SaveTerminalMode
    case SaveShellMode
    case ResetTerminalMode
    case ResetShellMode
    case ResetTTY
    case SaveTTY
    case MaxRipOffLines(count: Int)
    case RipOffLine(lines: Int)
    case SetCursor(to: CursorType)
    case Beep
    case Flash

    case NewWindow(size: Size, origin: Coordinate)
    case DeleteWindow
    case KeyPad(on: Bool)
    case Meta(on: Bool)
    case NoDelay(on: Bool)
    case NoTimeout(on: Bool)
    case MoveWindow(origin: Coordinate)
    case Duplicate
    case Overlay
    case OverWrite
    case Copy(origin: Coordinate, withOrigin: Coordinate, withSize: Size, destructive: Bool)
    case Refresh
    case UpdateWithoutRefresh
    case ReDraw
    case ReDrawLine(from: Int, lines: Int)
    case Erase
    case Clear
    case ClearToBottom
    case ClearToEndOfLine
    case Resize(size: Size)
    case SetBackground(character: ComplexCharacter)
    case GetBackground
    case Border(boxDrawingType: BoxDrawingType, attributes: Attributes, colourPair: ColourPair)
    case HorizontalLine(boxDrawingType: BoxDrawingType, attributes: Attributes, colourPair: ColourPair, length: Int)
    case VerticalLine(boxDrawingType: BoxDrawingType, attributes: Attributes, colourPair: ColourPair, length: Int)
    case PutCharacter(character: ComplexCharacter)
    case EchoCharacter(character: ComplexCharacter)
    case InsertCharacter(character: ComplexCharacter)
    case PutString(string: String, length: Int)
    case InsertString(string: String, length: Int)
    case ReadCharacter
    case ReadCharacters(length: Int)
    case UnReadCharacter(character: wchar_t)
    case DeleteCharacter
    case InsertLine
    case InsertDelete(lines: Int)
    case DeleteLine
    case GetAttributes
    case SetAttributes(attributes: Attributes, colourPair: ColourPair)
    case AttributesOn(attributes: Attributes)
    case AttributesOff(attributes: Attributes)
    case SetColour(colourPair: ColourPair)
    case ChangeAttributes(count: Int, windowAttributes: WindowAttributes)


    case StartColours
    case InitialisePair(pair: CShort, palette: ColourPalette)
    case InitialiseColour(colour: Colour, rgb: RGB)
    case ColourContent(colour: Colour)
    case PairContent(pair: CShort)

    case RGB(red: Int, green: Int, blue: Int)

    case ColourPair

    case NewPanel
    case DeletePanel
    case HidePanel
    case IsPanelHidden
    case ShowPanel
    case TopPanel
    case BottomPanel
    case MovePanel(origin: Coordinate)
    case ReplacePanel

    case ColourPairNotDefined(pair: CShort)

    case SetComplexCharacter(wideCharacter: wchar_t, attributes: Attributes, colourPair: ColourPair)
    case GetComplexCharacter
}

extension NCurseswError: CustomStringConvertible {
    public var description: String {
        let errorCode = "failed: ERR (#\(ERR)"

        switch self {
            case .WindowsAlreadyInitialised:
                return "windows already initialised"
            case .WindowsNotInitialised:
                return "windows not initialised"
            case .AssumeDefaultColours:
                return "assume_default_colors(-1, -1) \(errorCode)"
            case .NCurseswSetup:
                return "ncursesw_setup() failed"

            case .InitialiseWindows:
                return "initscr() \(errorCode)"
            case .EndWindows:
                return "endwin() \(errorCode)"
            case .CBreak:
                return "cbreak() \(errorCode)"
            case .NoCBreak:
                return "nocbreak() \(errorCode)"
            case .Echo:
                return "echo() \(errorCode)"
            case .NoEcho:
                return "noecho() \(errorCode)"
            case .HalfDelay(let tenths):
                return "halfdelay(\(tenths.deciseconds)) \(errorCode)"
            case .InterruptFlush(let on):
                return "intrflush(\(on)) \(errorCode)"
            case .Raw:
                return "raw() \(errorCode)"
            case .NoRaw:
                return "noraw() \(errorCode)"
            case .TypeAhead(let fileDescriptor):
                return "typeahead(\(fileDescriptor)) \(errorCode)"
            case .DoUpdate:
                return "doupdate() \(errorCode)"
            case .MoveCursor(let cursor):
                return "wmove(\(cursor)) \(errorCode)"
            case .SaveTerminalMode:
                return "def_prog_mode() \(errorCode)"
            case .SaveShellMode:
                return "def_shell_mode() \(errorCode)"
            case .ResetTerminalMode:
                return "reset_prog_mode() \(errorCode)"
            case .ResetShellMode:
                return "reset_shell_mode() \(errorCode)"
            case .ResetTTY:
                return "resetty() \(errorCode)"
            case .SaveTTY:
                return "savetty() \(errorCode)"
            case .MaxRipOffLines(let count):
                return "Maximum number of \(count) rip-off lines reached"
            case .RipOffLine(let lines):
                return "ripoffline(\(lines)) \(errorCode)"
            case .SetCursor(let to):
                return "curs_set(\(to) \(errorCode)"
            case .Beep:
                return "beep() \(errorCode)"
            case .Flash:
                return "flash() \(errorCode)"

            case .NewWindow(let size, let origin):
                return "newwin(\(size),\(origin)) \(errorCode)"
            case .DeleteWindow:
                return "delwin() \(errorCode)"
            case .KeyPad(let on):
                return "keypad(\(on) \(errorCode)"
            case .Meta(let on):
                return "meta(\(on) \(errorCode)"
            case .NoDelay(let on):
                return "nodelay(\(on) \(errorCode)"
            case .NoTimeout(let on):
                return "notimeout(\(on) \(errorCode)"
            case .MoveWindow(let origin):
                return "mvwin(\(origin)) \(errorCode)"
            case .Duplicate:
                return "dupwin() \(errorCode)"
            case .Overlay:
                return "overlay() \(errorCode)"
            case .OverWrite:
                return "overwrite() \(errorCode)"
            case .Copy(let origin, let withOrigin, let withSize, let destructive):
                return "copywin(\(origin),\(withOrigin),\(withSize),\(destructive)) \(errorCode)"
            case .Refresh:
                return "wrefresh() \(errorCode)"
            case .UpdateWithoutRefresh:
                return "wnoutrefresh() \(errorCode)"
            case .ReDraw:
                return "redrawwin() \(errorCode)"
            case .ReDrawLine(let from, let lines):
                return "wredrawln(\(from),\(lines)) \(errorCode)"
            case .Erase:
                return "werase() \(errorCode)"
            case .Clear:
                return "wclear() \(errorCode)"
            case .ClearToBottom:
                return "wclrtobot() \(errorCode)"
            case .ClearToEndOfLine:
                return "wclrtoeol() \(errorCode)"
            case .Resize(let size):
                return "wresize(\(size)) \(errorCode)"
            case .SetBackground(let character):
                return "wbkgrnd(\(character)) \(errorCode)"
            case .GetBackground:
                return "wgetbkgrnd() \(errorCode)"
            case .Border(let boxDrawingType, let attributes, let colourPair):
                return "wborder_set(\(boxDrawingType),\(attributes),\(colourPair)) \(errorCode)"
            case .HorizontalLine(let boxDrawingType, let attributes, let colourPair, let length):
                return "whline_set(\(boxDrawingType),\(attributes),\(colourPair),\(length)) \(errorCode)"
            case .VerticalLine(let boxDrawingType, let attributes, let colourPair, let length):
                return "wvline_set(\(boxDrawingType),\(attributes),\(colourPair),\(length)) \(errorCode)"
            case .PutCharacter(let character):
                return "wadd_ch(\(character)) \(errorCode)"
            case .EchoCharacter(let character):
                return "wecho_wchar(\(character)) \(errorCode)"
            case .InsertCharacter(let character):
                return "wins_wch(\(character)) \(errorCode)"
            case .PutString(let string, let length):
                return "waddnwstr(\(string),\(length)) \(errorCode)"
            case .InsertString(let string, let length):
                return "wins_wch(\(string),\(length)) \(errorCode)"
            case .ReadCharacter:
                return "wget_wch() \(errorCode)"
            case .ReadCharacters(let length):
                return "wgetn_wstr(\(length)) \(errorCode)"
            case .UnReadCharacter(let character):
                return "unget_wch(\(character)) \(errorCode)"
            case .DeleteCharacter:
                return "wdelch() \(errorCode)"
            case .InsertLine:
                return "winsertln() \(errorCode)"
            case .InsertDelete(let lines):
                return "winsdelln(\(lines)) \(errorCode)"
            case .DeleteLine:
                return "wdeleteln() \(errorCode)"
            case .GetAttributes:
                return "wattr_get() \(errorCode)"
            case .SetAttributes(let attributes, let colourPair):
                return "wattr_set(\(attributes),\(colourPair)) \(errorCode)"
            case .AttributesOn(let attributes):
                return "wattr_on(\(attributes)) \(errorCode)"
            case .AttributesOff(let attributes):
                return "wattr_off(\(attributes)) \(errorCode)"
            case .SetColour(let colourPair):
                return "wcolor_set(\(colourPair)) \(errorCode)"
            case .ChangeAttributes(let count, let windowAttributes):
                return "wchgat(\(count),\(windowAttributes)) \(errorCode)"

            case .StartColours:
                return "start_colour() \(errorCode)"
            case .InitialisePair(let pair, let palette):
                return "init_pair(\(pair),\(palette)) \(errorCode)"
            case .InitialiseColour(let colour, let rgb):
                return "init_color(\(colour),\(rgb)) \(errorCode)"
            case .ColourContent(let colour):
                return "color_content(\(colour)) \(errorCode)"
            case .PairContent(let pair):
                return "pair_content(\(pair)) \(errorCode)"

            case .RGB(let red, let green, let blue):
                return "invalid RGB value using red: \(red), green: \(green), blue: \(blue)"

            case .ColourPair:
                return "maximum number of colour pairs reached"

            case .NewPanel:
                return "new_panel() \(errorCode)"
            case .DeletePanel:
                return "del_panel() \(errorCode)"
            case .HidePanel:
                return "hide_panel() \(errorCode)"
            case .IsPanelHidden:
                return "panel_hidden() \(errorCode)"
            case .ShowPanel:
                return "show_panel() \(errorCode)"
            case .TopPanel:
                return "top_panel() \(errorCode)"
            case .BottomPanel:
                return "bottom_panel() \(errorCode)"
            case .MovePanel(let origin):
                return "move_panel(\(origin)) \(errorCode)"
            case .ReplacePanel:
                return "replace_panel() \(errorCode)"

            case .ColourPairNotDefined(let pair):
                return "colour pair \(pair) not defined"

            case .SetComplexCharacter(let wideCharacter, let attributes, let colourPair):
                return "setcchar(\(wideCharacter),\(attributes),\(colourPair)) \(errorCode)"
            case .GetComplexCharacter:
                return "getcchar() \(errorCode)"
        }
    }
}
