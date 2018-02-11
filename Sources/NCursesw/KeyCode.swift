/*
    KeyCode.swift

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

private let _keyCode: Dictionary<CInt, String> = [KEY_BREAK     : "break key",
                                                  KEY_SRESET    : "soft (partial) reset",
                                                  KEY_RESET     : "reset or hard reset",
                                                  KEY_DOWN      : "down-arrow key",
                                                  KEY_UP        : "up-arrow key",
                                                  KEY_LEFT      : "left-arrow key",
                                                  KEY_RIGHT     : "right-arrow key",
                                                  KEY_HOME      : "home key",
                                                  KEY_BACKSPACE : "backspace key",
                                                  KEY_DL        : "delete-line key",
                                                  KEY_IL        : "insert-line key",
                                                  KEY_DC        : "delete-character key",
                                                  KEY_IC        : "insert-character key",
                                                  KEY_EIC       : "sent by rmir or smir in insert mode",
                                                  KEY_CLEAR     : "clear-screen or erase key",
                                                  KEY_EOS       : "clear-to-end-of-screen key",
                                                  KEY_EOL       : "clear-to-end-of-line key",
                                                  KEY_SF        : "scroll-forward key",
                                                  KEY_SR        : "scroll-backward key",
                                                  KEY_NPAGE     : "next-page key",
                                                  KEY_PPAGE     : "previous-page key",
                                                  KEY_STAB      : "set-tab key",
                                                  KEY_CTAB      : "clear-tab key",
                                                  KEY_CATAB     : "clear-all-tabs key",
                                                  KEY_ENTER     : "enter/send key",
                                                  KEY_PRINT     : "print key",
                                                  KEY_LL        : "lower-left key (home down)",
                                                  KEY_A1        : "upper left of keypad",
                                                  KEY_A3        : "upper right of keypad",
                                                  KEY_B2        : "center of keypad",
                                                  KEY_C1        : "lower left of keypad",
                                                  KEY_C3        : "lower right of keypad",
                                                  KEY_BTAB      : "back-tab key",
                                                  KEY_BEG       : "begin key",
                                                  KEY_CANCEL    : "cancel key",
                                                  KEY_CLOSE     : "close key",
                                                  KEY_COMMAND   : "command key",
                                                  KEY_COPY      : "copy key",
                                                  KEY_CREATE    : "create key",
                                                  KEY_END       : "end key",
                                                  KEY_EXIT      : "exit key",
                                                  KEY_FIND      : "find key",
                                                  KEY_HELP      : "help key",
                                                  KEY_MARK      : "mark key",
                                                  KEY_MESSAGE   : "message key",
                                                  KEY_MOVE      : "move key",
                                                  KEY_NEXT      : "next key",
                                                  KEY_OPEN      : "open key",
                                                  KEY_OPTIONS   : "options key",
                                                  KEY_PREVIOUS  : "previous key",
                                                  KEY_REDO      : "redo key",
                                                  KEY_REFERENCE : "reference key",
                                                  KEY_REFRESH   : "refresh key",
                                                  KEY_REPLACE   : "replace key",
                                                  KEY_RESTART   : "restart key",
                                                  KEY_RESUME    : "resume key",
                                                  KEY_SAVE      : "save key",
                                                  KEY_SBEG      : "shifted begin key",
                                                  KEY_SCANCEL   : "shifted cancel key",
                                                  KEY_SCOMMAND  : "shifted command key",
                                                  KEY_SCOPY     : "shifted copy key",
                                                  KEY_SCREATE   : "shifted create key",
                                                  KEY_SDC       : "shifted delete-character key",
                                                  KEY_SDL       : "shifted delete-line key",
                                                  KEY_SELECT    : "select key",
                                                  KEY_SEND      : "shifted end key",
                                                  KEY_SEOL      : "shifted clear-to-end-of-line key",
                                                  KEY_SEXIT     : "shifted exit key",
                                                  KEY_SFIND     : "shifted find key",
                                                  KEY_SHELP     : "shifted help key",
                                                  KEY_SHOME     : "shifted home key",
                                                  KEY_SIC       : "shifted insert-character key",
                                                  KEY_SLEFT     : "shifted left-arrow key",
                                                  KEY_SMESSAGE  : "shifted message key",
                                                  KEY_SMOVE     : "shifted move key",
                                                  KEY_SNEXT     : "shifted next key",
                                                  KEY_SOPTIONS  : "shifted options key",
                                                  KEY_SPREVIOUS : "shifted previous key",
                                                  KEY_SPRINT    : "shifted print key",
                                                  KEY_SREDO     : "shifted redo key",
                                                  KEY_SREPLACE  : "shifted replace key",
                                                  KEY_SRIGHT    : "shifted right-arrow key",
                                                  KEY_SRSUME    : "shifted resume key",
                                                  KEY_SSAVE     : "shifted save key",
                                                  KEY_SSUSPEND  : "shifted suspend key",
                                                  KEY_SUNDO     : "shifted undo key",
                                                  KEY_SUSPEND   : "suspend key",
                                                  KEY_UNDO      : "undo key",
                                                  KEY_MOUSE     : "mouse event has occurred",
                                                  KEY_RESIZE    : "Terminal resize event",
                                                  KEY_EVENT     : "We were interrupted by an event"]

public enum KeyCode {
    case Break                     // Break key (unreliable)
    case SoftReset                 // Soft (partial) reset (unreliable)
    case Reset                     // Reset or hard reset (unreliable)
    case DownArrow                 // down-arrow key
    case UpArrow                   // up-arrow key
    case LeftArrow                 // left-arrow key
    case RightArrow                // right-arrow key
    case Home                      // home key
    case Backspace                 // backspace key
    case FunctionKey(number: Int)  // Function keys. Space for 64
    case DeleteLine                // delete-line key
    case InsertLine                // insert-line key
    case DeleteCharacter           // delete-character key
    case InsertCharacter           // insert-character key
    case InsertMode                // sent by rmir or smir in insert mode
    case Erase                     // clear-screen or erase key
    case ClearToEndOfScreen        // clear-to-end-of-screen key
    case ClearToEndOfLine          // clear-to-end-of-line key
    case ScrollForward             // scroll-forward key
    case ScrollBackward            // scroll-backward key
    case NextPage                  // next-page key
    case PreviousPage              // previous-page key
    case SetTab                    // set-tab key
    case ClearTab                  // clear-tab key
    case ClearAllTabs              // clear-all-tabs key
    case Enter                     // enter/send key
    case Print                     // print key
    case HomeDown                  // lower-left key (home down)
    case KeyPadUpperLeft           // upper left of keypad
    case KeyPadUpperRight          // upper right of keypad
    case KeyPadCenter              // center of keypad
    case KeyPadLowerLeft           // lower left of keypad
    case KeyPadLowerRight          // lower right of keypad
    case BackTab                   // back-tab key
    case Begin                     // begin key
    case Cancel                    // cancel key
    case Close                     // close key
    case Command                   // command key
    case Copy                      // copy key
    case Create                    // create key
    case End                       // end key
    case Exit                      // exit key
    case Find                      // find key
    case Help                      // help key
    case Mark                      // mark key
    case Message                   // message key
    case Move                      // move key
    case Next                      // next key
    case Open                      // open key
    case Options                   // options key
    case Previous                  // previous key
    case Redo                      // redo key
    case Reference                 // reference key
    case Refresh                   // refresh key
    case Replace                   // replace key
    case Restart                   // restart key
    case Resume                    // resume key
    case Save                      // save key
    case ShiftBegin                // shifted begin key
    case ShiftCancel               // shifted cancel key
    case ShiftCommand              // shifted command key
    case ShiftCopy                 // shifted copy key
    case ShiftCreate               // shifted create key
    case ShiftDeleteCharacter      // shifted delete-character key
    case ShiftDeleteLine           // shifted delete-line key
    case Select                    // select key
    case ShiftEnd                  // shifted end key
    case ShiftClearToEndOfLine     // shifted clear-to-end-of-line key
    case ShiftExit                 // shifted exit key
    case ShiftFind                 // shifted find key
    case ShiftHelp                 // shifted help key
    case ShiftHome                 // shifted home key
    case ShiftInsertCharacter      // shifted insert-character key
    case ShiftLeftArrow            // shifted left-arrow key
    case ShiftMessage              // shifted message key
    case ShiftMove                 // shifted move key
    case ShiftNext                 // shifted next key
    case ShiftOptions              // shifted options key
    case ShiftPrevious             // shifted previous key
    case ShiftPrint                // shifted print key
    case ShiftRedo                 // shifted redo key
    case ShiftReplace              // shifted replace key
    case ShiftRightArrow           // shifted right-arrow key
    case ShiftResume               // shifted resume key
    case ShiftSave                 // shifted save key
    case ShiftSuspend              // shifted suspend key
    case ShiftUndo                 // shifted undo key
    case Suspend                   // suspend key
    case Undo                      // undo key
    case MouseEvent                // Mouse event has occurred
    case ResizeEvent               // Terminal resize event
    case Event                     // We were interrupted by an event
    case Unknown(value: Int)

    public init(rawValue: wint_t) {
        let rawValue = CInt(rawValue)

        switch rawValue {
            case KEY_BREAK:
                self = .Break
            case KEY_SRESET:
                self = .SoftReset
            case KEY_RESET:
                self = .Reset
            case KEY_DOWN:
                self = .DownArrow
            case KEY_UP:
                self = .UpArrow
            case KEY_LEFT:
                self = .LeftArrow
            case KEY_RIGHT:
                self = .RightArrow
            case KEY_HOME:
                self = .Home
            case KEY_BACKSPACE:
                self = .Backspace
            case KEY_F0 + 1 ... KEY_F0 + 64:
                self = .FunctionKey(number: Int(rawValue - KEY_F0))
            case KEY_DL:
                self = .DeleteLine
            case KEY_IL:
                self = .InsertLine
            case KEY_DC:
                self = .DeleteCharacter
            case KEY_IC:
                self = .InsertCharacter
            case KEY_EIC:
                self = .InsertMode
            case KEY_CLEAR:
                self = .Erase
            case KEY_EOS:
                self = .ClearToEndOfScreen
            case KEY_EOL:
                self = .ClearToEndOfLine
            case KEY_SF:
                self = .ScrollForward
            case KEY_SR:
                self = .ScrollBackward
            case KEY_NPAGE:
                self = .NextPage
            case KEY_PPAGE:
                self = .PreviousPage
            case KEY_STAB:
                self = .SetTab
            case KEY_CTAB:
                self = .ClearTab
            case KEY_CATAB:
                self = .ClearAllTabs
            case KEY_ENTER:
                self = .Enter
            case KEY_PRINT:
                self = .Print
            case KEY_LL:
                self = .HomeDown
            case KEY_A1:
                self = .KeyPadUpperLeft
            case KEY_A3:
                self = .KeyPadUpperRight
            case KEY_B2:
                self = .KeyPadCenter
            case KEY_C1:
                self = .KeyPadLowerLeft
            case KEY_C3:
                self = .KeyPadLowerRight
            case KEY_BTAB:
                self = .BackTab
            case KEY_BEG:
                self = .Begin
            case KEY_CANCEL:
                self = .Cancel
            case KEY_CLOSE:
                self = .Close
            case KEY_COMMAND:
                self = .Command
            case KEY_COPY:
                self = .Copy
            case KEY_CREATE:
                self = .Create
            case KEY_END:
                self = .End
            case KEY_EXIT:
                self = .Exit
            case KEY_FIND:
                self = .Find
            case KEY_HELP:
                self = .Help
            case KEY_MARK:
                self = .Mark
            case KEY_MESSAGE:
                self = .Message
            case KEY_MOVE:
                self = .Move
            case KEY_NEXT:
                self = .Next
            case KEY_OPEN:
                self = .Open
            case KEY_OPTIONS:
                self = .Options
            case KEY_PREVIOUS:
                self = .Previous
            case KEY_REDO:
                self = .Redo
            case KEY_REFERENCE:
                self = .Reference
            case KEY_REFRESH:
                self = .Refresh
            case KEY_REPLACE:
                self = .Replace
            case KEY_RESTART:
                self = .Restart
            case KEY_RESUME:
                self = .Resume
            case KEY_SAVE:
                self = .Save
            case KEY_SBEG:
                self = .ShiftBegin
            case KEY_SCANCEL:
                self = .ShiftCancel
            case KEY_SCOMMAND:
                self = .ShiftCommand
            case KEY_SCOPY:
                self = .ShiftCopy
            case KEY_SCREATE:
                self = .ShiftCreate
            case KEY_SDC:
                self = .ShiftDeleteCharacter
            case KEY_SDL:
                self = .ShiftDeleteLine
            case KEY_SELECT:
                self = .Select
            case KEY_SEND:
                self = .ShiftEnd
            case KEY_SEOL:
                self = .ShiftClearToEndOfLine
            case KEY_SEXIT:
                self = .ShiftExit
            case KEY_SFIND:
                self = .ShiftFind
            case KEY_SHELP:
                self = .ShiftHelp
            case KEY_SHOME:
                self = .ShiftHome
            case KEY_SIC:
                self = .ShiftInsertCharacter
            case KEY_SLEFT:
                self = .ShiftLeftArrow
            case KEY_SMESSAGE:
                self = .ShiftMessage
            case KEY_SMOVE:
                self = .ShiftMove
            case KEY_SNEXT:
                self = .ShiftNext
            case KEY_SOPTIONS:
                self = .ShiftOptions
            case KEY_SPREVIOUS:
                self = .ShiftPrevious
            case KEY_SPRINT:
                self = .ShiftPrint
            case KEY_SREDO:
                self = .ShiftRedo
            case KEY_SREPLACE:
                self = .ShiftReplace
            case KEY_SRIGHT:
                self = .ShiftRightArrow
            case KEY_SRSUME:
                self = .ShiftResume
            case KEY_SSAVE:
                self = .ShiftSave
            case KEY_SSUSPEND:
                self = .ShiftSuspend
            case KEY_SUNDO:
                self = .ShiftUndo
            case KEY_SUSPEND:
                self = .Suspend
            case KEY_UNDO:
                self = .Undo
            case KEY_MOUSE:
                self = .MouseEvent
            case KEY_RESIZE:
                self = .ResizeEvent
            case KEY_EVENT:
                self = .Event
            default:
                self = .Unknown(value: Int(rawValue))
        }
    }

    public var rawValue: wint_t {
        var rawValue: CInt = -1

        switch self {
            case .Break:
                rawValue = KEY_BREAK
            case .SoftReset:
                rawValue = KEY_SRESET
            case .Reset:
                rawValue = KEY_RESET
            case .DownArrow:
                rawValue = KEY_DOWN
            case .UpArrow:
                rawValue = KEY_UP
            case .LeftArrow:
                rawValue = KEY_LEFT
            case .RightArrow:
                rawValue = KEY_RIGHT
            case .Home:
                rawValue = KEY_HOME
            case .Backspace:
                rawValue = KEY_BACKSPACE
            case .FunctionKey(let number):
                rawValue = KEY_F0 + CInt(number)
            case .DeleteLine:
                rawValue = KEY_DL
            case .InsertLine:
                rawValue = KEY_IL
            case .DeleteCharacter:
                rawValue = KEY_DC
            case .InsertCharacter:
                rawValue = KEY_IC
            case .InsertMode:
                rawValue = KEY_EIC
            case .Erase:
                rawValue = KEY_CLEAR
            case .ClearToEndOfScreen:
                rawValue = KEY_EOS
            case .ClearToEndOfLine:
                rawValue = KEY_EOL
            case .ScrollForward:
                rawValue = KEY_SF
            case .ScrollBackward:
                rawValue = KEY_SR
            case .NextPage:
                rawValue = KEY_NPAGE
            case .PreviousPage:
                rawValue = KEY_PPAGE
            case .SetTab:
                rawValue = KEY_STAB
            case .ClearTab:
                rawValue = KEY_CTAB
            case .ClearAllTabs:
                rawValue = KEY_CATAB
            case .Enter:
                rawValue = KEY_ENTER
            case .Print:
                rawValue = KEY_PRINT
            case .HomeDown:
                rawValue = KEY_LL
            case .KeyPadUpperLeft:
                rawValue = KEY_A1
            case .KeyPadUpperRight:
                rawValue = KEY_A3
            case .KeyPadCenter:
                rawValue = KEY_B2
            case .KeyPadLowerLeft:
                rawValue = KEY_C1
            case .KeyPadLowerRight:
                rawValue = KEY_C3
            case .BackTab:
                rawValue = KEY_BTAB
            case .Begin:
                rawValue = KEY_BEG
            case .Cancel:
                rawValue = KEY_CANCEL
            case .Close:
                rawValue = KEY_CLOSE
            case .Command:
                rawValue = KEY_COMMAND
            case .Copy:
                rawValue = KEY_COPY
            case .Create:
                rawValue = KEY_CREATE
            case .End:
                rawValue = KEY_END
            case .Exit:
                rawValue = KEY_EXIT
            case .Find:
                rawValue = KEY_FIND
            case .Help:
                rawValue = KEY_HELP
            case .Mark:
                rawValue = KEY_MARK
            case .Message:
                rawValue = KEY_MESSAGE
            case .Move:
                rawValue = KEY_MOVE
            case .Next:
                rawValue = KEY_NEXT
            case .Open:
                rawValue = KEY_OPEN
            case .Options:
                rawValue = KEY_OPTIONS
            case .Previous:
                rawValue = KEY_PREVIOUS
            case .Redo:
                rawValue = KEY_REDO
            case .Reference:
                rawValue = KEY_REFERENCE
            case .Refresh:
                rawValue = KEY_REFRESH
            case .Replace:
                rawValue = KEY_REPLACE
            case .Restart:
                rawValue = KEY_RESTART
            case .Resume:
                rawValue = KEY_RESUME
            case .Save:
                rawValue = KEY_SAVE
            case .ShiftBegin:
                rawValue = KEY_SBEG
            case .ShiftCancel:
                rawValue = KEY_SCANCEL
            case .ShiftCommand:
                rawValue = KEY_SCOMMAND
            case .ShiftCopy:
                rawValue = KEY_SCOPY
            case .ShiftCreate:
                rawValue = KEY_SCREATE
            case .ShiftDeleteCharacter:
                rawValue = KEY_SDC
            case .ShiftDeleteLine:
                rawValue = KEY_SDL
            case .Select:
                rawValue = KEY_SELECT
            case .ShiftEnd:
                rawValue = KEY_SEND
            case .ShiftClearToEndOfLine:
                rawValue = KEY_SEOL
            case .ShiftExit:
                rawValue = KEY_SEXIT
            case .ShiftFind:
                rawValue = KEY_SFIND
            case .ShiftHelp:
                rawValue = KEY_SHELP
            case .ShiftHome:
                rawValue = KEY_SHOME
            case .ShiftInsertCharacter:
                rawValue = KEY_SIC
            case .ShiftLeftArrow:
                rawValue = KEY_SLEFT
            case .ShiftMessage:
                rawValue = KEY_SMESSAGE
            case .ShiftMove:
                rawValue = KEY_SMOVE
            case .ShiftNext:
                rawValue = KEY_SNEXT
            case .ShiftOptions:
                rawValue = KEY_SOPTIONS
            case .ShiftPrevious:
                rawValue = KEY_SPREVIOUS
            case .ShiftPrint:
                rawValue = KEY_SPRINT
            case .ShiftRedo:
                rawValue = KEY_SREDO
            case .ShiftReplace:
                rawValue = KEY_SREPLACE
            case .ShiftRightArrow:
                rawValue = KEY_SRIGHT
            case .ShiftResume:
                rawValue = KEY_SRSUME
            case .ShiftSave:
                rawValue = KEY_SSAVE
            case .ShiftSuspend:
                rawValue = KEY_SSUSPEND
            case .ShiftUndo:
                rawValue = KEY_SUNDO
            case .Suspend:
                rawValue = KEY_SUSPEND
            case .Undo:
                rawValue = KEY_UNDO
            case .MouseEvent:
                rawValue = KEY_MOUSE
            case .ResizeEvent:
                rawValue = KEY_RESIZE
            case .Event:
                rawValue = KEY_EVENT
            case .Unknown(let value):
                rawValue = CInt(value)
        }

        return wint_t(rawValue)
    }
}

extension KeyCode: CustomStringConvertible {
    public var description: String {
        let rawValue = CInt(self.rawValue)

        if (rawValue > KEY_F0 && rawValue <= KEY_F0 + 64) {
            return "function key \(rawValue - KEY_F0)"
        } else if let description =  _keyCode[rawValue] {
            return description
        }

        return "unknown #\(rawValue)"
    }
}
