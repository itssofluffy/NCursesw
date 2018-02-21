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
    case AlreadyInitialised
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
    case Newline
    case NoNewline
    case DoUpdate
    case MoveCursor(cursor: Coordinate)
    case SaveTerminalMode
    case SaveShellMode
    case ResetTerminalMode
    case ResetShellMode
    case ResetTTY
    case SaveTTY
    case RipOffLine(from: Orientation, lines: Int)
    case SetCursor(to: CursorType)
    case Beep
    case Flash

    case SoftLabelInitialise(with: SoftLabelType)
    case SoftLabelSet(number: Int, label: String, justification: Justification)
    case SoftLabelRefresh
    case SoftLabelUpdateWithoutRefresh
    case SoftLabelClear
    case SoftLabelRestore
    case SoftLabelTouch
    case SoftLabelAttributesTo(windowAttributes: WindowAttributes)
    case SoftLabelAttributesOn(attributes: Attributes)
    case SoftLabelAttributesOff(attributes: Attributes)
    case SoftLabelSetColour(colourPair: ColourPair)

    case NewWindow(size: Size, origin: Coordinate)
    case RegionAlreadyExists
    case Region(size: Size, origin: Coordinate)
    case DerivedRegion(size: Size, relative: Coordinate)
    case DeleteWindow
    case KeyPad(to: Bool)
    case Meta(to: Bool)
    case NoDelay(to: Bool)
    case NoTimeout(to: Bool)
    case MoveWindow(origin: Coordinate)
    case MoveDerivedWindow(origin: Coordinate)
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
    case HorizontalLine(boxDrawingGraphic: ComplexCharacter, length: Int)
    case VerticalLine(boxDrawingGraphic: ComplexCharacter, length: Int)
    case PutCharacter(character: ComplexCharacter)
    case EchoCharacter(character: ComplexCharacter)
    case InsertCharacter(character: ComplexCharacter)
    case PutString(string: String, length: Int)
    case InsertString(string: String, length: Int)
    case ReadCharacter
    case ReadCharacters(length: Int)
    case UnReadCharacter(character: Character)
    case DeleteCharacter
    case InsertLine
    case InsertDelete(lines: Int)
    case DeleteLine
    case GetAttributes
    case AttributesTo(windowAttributes: WindowAttributes)
    case AttributesOn(attributes: Attributes)
    case AttributesOff(attributes: Attributes)
    case SetColour(colourPair: ColourPair)
    case WindowAttributesOn(windowAttributes: WindowAttributes)
    case WindowAttributesOff(windowAttributes: WindowAttributes)
    case TouchWindow
    case TouchLine(start: Int, count: Int)
    case UnTouchWindow
    case WTouchLine(start: Int, count: Int, change: Bool)
    case ClearOnRefresh(value: Bool)
    case InsertDeleteLine(value: Bool)
    case LeaveCursor(value: Bool)
    case SetScrollRegion(top: Int, bottom: Int)
    case ScrollRegionOnEnd(value: Bool)

    case StartColours
    case AllocatePair(palette: ColourPalette)
    case FreePair(pair: CInt)
    case InitialiseColour(colour: Colour, rgb: RGB)
    case ColourContent(colour: Colour)

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

    case ColourPairNotDefined(pair: CInt)

    case SetComplexCharacter(wideCharacter: wchar_t, attributes: Attributes, colourPair: ColourPair)
    case GetComplexCharacter
}

extension NCurseswError: CustomStringConvertible {
    public var description: String {
        let errorCode = "failed: ERR (#\(ERR))"

        switch self {
            case .AlreadyInitialised:
                return "already initialised"
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
            case .Newline:
                return "nl() \(errorCode)"
            case .NoNewline:
                return "nonl() \(errorCode)"
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
            case .RipOffLine(let from, let lines):
                return "ripoffline(\(from),\(lines)) \(errorCode)"
            case .SetCursor(let to):
                return "curs_set(\(to) \(errorCode)"
            case .Beep:
                return "beep() \(errorCode)"
            case .Flash:
                return "flash() \(errorCode)"

            case .SoftLabelInitialise(let with):
                return "slk_init(\(with)) \(errorCode)"
            case .SoftLabelSet(let number, let label, let justification):
                return "slk_wset(\(number),\(label),\(justification)) \(errorCode)"
            case .SoftLabelRefresh:
                return "slk_refresh() \(errorCode)"
            case .SoftLabelUpdateWithoutRefresh:
                return "slk_noutrefresh() \(errorCode)"
            case .SoftLabelClear:
                return "slk_clear() \(errorCode)"
            case .SoftLabelRestore:
                return "slk_restore() \(errorCode)"
            case .SoftLabelTouch:
                return "slk_touch() \(errorCode)"
            case .SoftLabelAttributesTo(let windowAttributes):
                return "slk_attr_set(\(windowAttributes)) \(errorCode)"
            case .SoftLabelAttributesOn(let attributes):
                return "slk_attr_on(\(attributes)) \(errorCode)"
            case .SoftLabelAttributesOff(let attributes):
                return "slk_attr_off(\(attributes)) \(errorCode)"
            case .SoftLabelSetColour(let colourPair):
                return "extended_slk_color(\(colourPair)) \(errorCode)"

            case .NewWindow(let size, let origin):
                return "newwin(\(size),\(origin)) \(errorCode)"
            case .RegionAlreadyExists:
                return "region already defined"
            case .Region(let size, let origin):
                return "subwin(\(size),\(origin)) \(errorCode)"
            case .DerivedRegion(let size, let relative):
                return "derwin(\(size),\(relative)) \(errorCode)"
            case .DeleteWindow:
                return "delwin() \(errorCode)"
            case .KeyPad(let to):
                return "keypad(\(to) \(errorCode)"
            case .Meta(let to):
                return "meta(\(to) \(errorCode)"
            case .NoDelay(let to):
                return "nodelay(\(to) \(errorCode)"
            case .NoTimeout(let to):
                return "notimeout(\(to) \(errorCode)"
            case .MoveWindow(let origin):
                return "mvwin(\(origin)) \(errorCode)"
            case .MoveDerivedWindow(let origin):
                return "mvderwin(\(origin)) \(errorCode)"
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
            case .HorizontalLine(let boxDrawingGraphic, let length):
                return "whline_set(\(boxDrawingGraphic),\(length)) \(errorCode)"
            case .VerticalLine(let boxDrawingGraphic, let length):
                return "wvline_set(\(boxDrawingGraphic),\(length)) \(errorCode)"
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
            case .AttributesTo(let windowAttributes):
                return "wattr_set(\(windowAttributes)) \(errorCode)"
            case .AttributesOn(let attributes):
                return "wattr_on(\(attributes)) \(errorCode)"
            case .AttributesOff(let attributes):
                return "wattr_off(\(attributes)) \(errorCode)"
            case .SetColour(let colourPair):
                return "wcolor_set(\(colourPair)) \(errorCode)"
            case .WindowAttributesOn(let windowAttributes):
                return "wattr_on(\(windowAttributes)) \(errorCode)"
            case .WindowAttributesOff(let windowAttributes):
                return "wattr_off(\(windowAttributes)) \(errorCode)"
            case .TouchWindow:
                return "touchwin() \(errorCode)"
            case .TouchLine(let start, let count):
                return "touchline(\(start),\(count)) \(errorCode)"
            case .UnTouchWindow:
                return "untouchwin() \(errorCode)"
            case .WTouchLine(let start, let count, let change):
                return "wtouchln(\(start),\(count),\(change)) \(errorCode)"
            case .ClearOnRefresh(let value):
                return "clearok(\(value)) \(errorCode)"
            case .InsertDeleteLine(let value):
                return "idlok(\(value)) \(errorCode)"
            case .LeaveCursor(let value):
                return "leaveok(\(value)) \(errorCode)"
            case .SetScrollRegion(let top, let bottom):
                return "wsetscrreg(\(top),\(bottom)) \(errorCode)"
            case .ScrollRegionOnEnd(let value):
                return "scrollok(\(value)) \(errorCode)"

            case .StartColours:
                return "start_colour() \(errorCode)"
            case .AllocatePair(let palette):
                return "alloc_pair(\(palette)) \(errorCode)"
            case .FreePair(let pair):
                return "free_pair(\(pair)) \(errorCode)"
            case .InitialiseColour(let colour, let rgb):
                return "init_color(\(colour),\(rgb)) \(errorCode)"
            case .ColourContent(let colour):
                return "color_content(\(colour)) \(errorCode)"

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
