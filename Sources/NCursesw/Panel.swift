/*
    Panel.swift

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

private var _panels = Set<Panel>()

// http://invisible-island.net/ncurses/man/panel.3x.html
public var bottomPanel: Panel? {
    if let panel = _panels.first(where: { $0._handle == panel_above(nil) }) {
        return panel
    }

    return nil
}

public var topPanel: Panel? {
    if let panel = _panels.first(where: { $0._handle == panel_below(nil) }) {
        return panel
    }

    return nil
}

public func updatePanels() {
    update_panels()
}

public class Panel {
    fileprivate let _handle: PanelHandle
    public private(set) var window: Window

    public init(with window: Window) throws {
        guard let handle = new_panel(window._handle) else {
            throw NCurseswError.NewPanel
        }

        _handle = handle
        self.window = window

        _panels.insert(self)
    }

    deinit {
        wrapper(do: {
                    defer {
                        _panels.remove(self)
                    }

                    guard (del_panel(self._handle) == OK) else {
                        throw NCurseswError.DeletePanel
                    }
                },
                catch: { failure in
                    ncurseswErrorLogger(failure)
                })
    }
}

extension Panel {
    public func hide() throws {
        guard (hide_panel(_handle) == OK) else {
            throw NCurseswError.HidePanel
        }
    }

    public var isHidden: Bool {
        return wrapper(do: {
                           let returnCode = panel_hidden(self._handle)

                           guard (returnCode != ERR) else {
                               throw NCurseswError.IsPanelHidden
                           }

                           return NCursesw._ncurseswBool(returnCode)
                       },
                       catch: { failure in
                           ncurseswErrorLogger(failure)
                       })!
    }

    public func show() throws {
        guard (show_panel(_handle) == OK) else {
            throw NCurseswError.ShowPanel
        }
    }

    public func gotoTop() throws {
        guard (top_panel(_handle) == OK) else {
            throw NCurseswError.TopPanel
        }
    }

    public func gotoBottom() throws {
        guard (bottom_panel(_handle) == OK) else {
            throw NCurseswError.BottomPanel
        }
    }

    public func move(to origin: Coordinate) throws {
        guard (move_panel(_handle, origin._y, origin._x) == OK) else {
            throw NCurseswError.MovePanel(origin: origin)
        }
    }

    public func replace(with window: Window) throws {
        guard (replace_panel(_handle, window._handle) == OK) else {
            throw NCurseswError.ReplacePanel
        }

        self.window = window
    }

    public var isTopPanel: Bool {
        return (topPanel == self) ? true : false
    }

    public var isBottomPanel: Bool {
        return (bottomPanel == self) ? true : false
    }

    public var above: Panel? {
        if let panel = _panels.first(where: { $0._handle == panel_above(_handle) }) {
            return panel
        }

        return nil
    }

    public var below: Panel? {
        if let panel = _panels.first(where: { $0._handle == panel_below(_handle) }) {
            return panel
        }

        return nil
    }
}

extension Panel: Hashable {
    public var hashValue: Int {
        return _handle.hashValue
    }
}

extension Panel: Equatable {
    public static func ==(lhs: Panel, rhs: Panel) -> Bool {
        return (lhs._handle == rhs._handle)
    }
}
