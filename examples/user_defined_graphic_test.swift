import NCursesw
import Foundation
import ISFLibrary

do {
    do {
        let window = try Terminal.initialise()

        let graphicsColourPair = try ColourPair(palette: ColourPalette(foreground: .Green, background: .Default))

        var userDefinedGraphics = try UserDefinedBoxDrawing(base: .Light(detail: .Normal), colourPair: graphicsColourPair)

        userDefinedGraphics.graphic[.UpperLeftCorner] = try ComplexCharacter(0x256d, colourPair: graphicsColourPair)
        userDefinedGraphics.graphic[.UpperRightCorner] = try ComplexCharacter(0x256e, colourPair: graphicsColourPair)
        userDefinedGraphics.graphic[.LowerLeftCorner] = try ComplexCharacter(0x2570, colourPair: graphicsColourPair)
        userDefinedGraphics.graphic[.LowerRightCorner] = try ComplexCharacter(0x256f, colourPair: graphicsColourPair)

        let boxDrawingType = BoxDrawingType.UserDefined(graphics: userDefinedGraphics)

        try window.border(boxDrawingType)

        try window.print("columns: \(Terminal.columns), lines: \(Terminal.lines)", origin: Coordinate(y: 1, x: 1))
        try window.print(BoxDrawing(boxDrawingType).graphic(.UpperLeftCorner), origin: Coordinate(y: 2, x: 1))

        try window.refresh()

        sleep(10)
    } catch {
        throw error
    }

    try Terminal.endWindows()
} catch {
    print(error, to: &errorStream)
}

exit(EXIT_SUCCESS)
