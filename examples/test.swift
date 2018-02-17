import NCursesw
import Foundation
import ISFLibrary

var ripLine: NCurseswWindow?

do {
    try Terminal.ripOff(from: .Lower, lines: 1, initialiser: {
        ripLine = NCurseswWindow(handle: $0!)

        do {
            try ripLine!.print(string: "this is a rip-off line and has \($1) columns...", origin: Coordinate(y: 0, x: 0))
        } catch {
            ncurseswErrorLogger(ErrorLoggerResult(error: error))

            return EXIT_FAILURE
        }

        return EXIT_SUCCESS
    })

    do {
        let window = try Terminal.initialiseWindows()

        try window.keypad(to: true)

        func doRefresh() throws {
            try ripLine!.refresh()
            try window.refresh()
        }

        let windowForeground = Colour.Yellow
        let windowBackground = Colour.Blue

        let windowPalette    = ColourPalette(foreground: windowForeground, background: windowBackground)
        let windowColourPair = try ColourPair(palette: windowPalette)
        let boxDrawingType   = BoxDrawingType.Light(detail: .Normal)

        try window.setBackground(character: ComplexCharacter(0x20, colourPair: windowColourPair))

        try window.border(boxDrawingType, colourPair: windowColourPair)

        let origin = Coordinate(y: 1, x: 1)

        try window.setAttributes(to: WindowAttributes(attributes: .Bold,
                                                      colourPair: ColourPair(palette: ColourPalette(foreground: .Red,
                                                                                                    background: windowBackground))),
                                 origin: origin)

        try window.print(string: "\(window.size)", origin: origin)

        try window.setAttributes(off: WindowAttributes(attributes: .Bold, colourPair: windowColourPair))

        try window.print(character: BoxDrawing(boxDrawingType).graphic(.UpperLeftCorner), origin: Coordinate(y: 2, x: 1))

        try doRefresh()

        var result: UICharacter

        result = try window.read(origin: Coordinate(y: 2, x: 2))
        print("result=\(result)", to: &errorStream)

        try ripLine!.clear()
        try ripLine!.print(string: "and now the rip-off line has changed!!!", origin: Coordinate(y: 0, x: 0))

        try doRefresh()

        result = try window.read(origin: Coordinate(y: 2, x: 2))
        print("result=\(result)", to: &errorStream)
    } catch {
        throw error
    }

    try Terminal.endWindows()
} catch {
    print(error, to: &errorStream)

    exit(EXIT_FAILURE)
}

exit(EXIT_SUCCESS)
