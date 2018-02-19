/*
    Colour.swift

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

public enum Colour {
    case Default
    case Black
    case Red
    case Green
    case Yellow
    case Blue
    case Magenta
    case Cyan
    case White
    case BLACK
    case RED
    case GREEN
    case YELLOW
    case BLUE
    case MAGENTA
    case CYAN
    case WHITE
    case UserDefined(code: Int)

    public init(rawValue: CInt) {
        switch rawValue {
            case -1:
                self = .Default
            case COLOR_BLACK:
                self = .Black
            case COLOR_RED:
                self = .Red
            case COLOR_GREEN:
                self = .Green
            case COLOR_YELLOW:
                self = .Yellow
            case COLOR_BLUE:
                self = .Blue
            case COLOR_MAGENTA:
                self = .Magenta
            case COLOR_CYAN:
                self = .Cyan
            case COLOR_WHITE:
                self = .White
            case COLOR_BLACK + 8:
                self = .BLACK
            case COLOR_RED + 8:
                self = .RED
            case COLOR_GREEN + 8:
                self = .GREEN
            case COLOR_YELLOW + 8:
                self = .YELLOW
            case COLOR_BLUE + 8:
                self = .BLUE
            case COLOR_MAGENTA + 8:
                self = .MAGENTA
            case COLOR_CYAN + 8:
                self = .CYAN
            case COLOR_WHITE + 8:
                self = .WHITE
            default: // >= 16
                guard (rawValue > 255) else {
                    fatalError("colour rawValue of \(rawValue) can not be > 255")
                }

                self = .UserDefined(code: Int(rawValue - (COLOR_WHITE + 1 + 8)))
        }
    }

    public var rawValue: CInt {
        switch self {
            case .Default:
                return -1
            case .Black:
                return COLOR_BLACK
            case .Red:
                return COLOR_RED
            case .Green:
                return COLOR_GREEN
            case .Yellow:
                return COLOR_YELLOW
            case .Blue:
                return COLOR_BLUE
            case .Magenta:
                return COLOR_MAGENTA
            case .Cyan:
                return COLOR_CYAN
            case .White:
                return COLOR_WHITE
            case .BLACK:
                return COLOR_BLACK + 8
            case .RED:
                return COLOR_RED + 8
            case .GREEN:
                return COLOR_GREEN + 8
            case .YELLOW:
                return COLOR_YELLOW + 8
            case .BLUE:
                return COLOR_BLUE + 8
            case .MAGENTA:
                return COLOR_MAGENTA + 8
            case .CYAN:
                return COLOR_CYAN + 8
            case .WHITE:
                return COLOR_WHITE + 8
            case .UserDefined(let code):
                guard (code >= 0 && code <= 239) else {
                    fatalError("user defined colour code must be between 0 and 239")
                }

                return CInt(code + Int(COLOR_WHITE) + 1 + 8)
        }
    }

    public var rgb: RGB {
        get {
            return wrapper(do: {
                               var red:   CInt = 0
                               var green: CInt = 0
                               var blue:  CInt = 0

                               guard (extended_color_content(self.rawValue, &red, &green, &blue) == OK) else {
                                   throw NCurseswError.ColourContent(colour: self)
                               }

                               return try RGB(red: red, green: green, blue: blue)
                           },
                           catch: { failure in
                               ncurseswErrorLogger(failure)
                           })!
        }
        set (rgb) {
            let this = self

            wrapper(do: {
                        guard (init_extended_color(this.rawValue, rgb._red, rgb._green, rgb._blue) == OK) else {
                            throw NCurseswError.InitialiseColour(colour: this, rgb: rgb)
                        }
                    },
                    catch: { failure in
                        ncurseswErrorLogger(failure)
                    })
        }
    }
}

extension Colour: Equatable {
    public static func ==(lhs: Colour, rhs: Colour) -> Bool {
        return (lhs.rawValue == rhs.rawValue)
    }
}

extension Colour: CustomStringConvertible {
    public var description: String {
        var description: String = ""

        switch self {
            case .Default:
                description = "default"
            case .Black:
                description = "black"
            case .Red:
                description = "red"
            case .Green:
                description = "green"
            case .Yellow:
                description = "yellow"
            case .Blue:
                description = "blue"
            case .Magenta:
                description = "magenta"
            case .Cyan:
                description = "cyan"
            case .White:
                description = "white"
            case .BLACK:
                description = "BLACK"
            case .RED:
                description = "RED"
            case .GREEN:
                description = "GREEN"
            case .YELLOW:
                description = "YELLOW"
            case .BLUE:
                description = "BLUE"
            case .MAGENTA:
                description = "MAGENTA"
            case .CYAN:
                description = "CYAN"
            case .WHITE:
                description = "WHITE"
            case .UserDefined(let code):
                description = "UserDefined(\(code))"
        }

        if (NCursesw._includeRGBs) {
            description += ", rgb: (\(rgb))"
        }

        return description
    }
}
