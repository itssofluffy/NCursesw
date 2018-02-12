import NCursesw
import Foundation

do {
    do {
        let window = try Terminal.initialiseWindows()

        var userDefinedGraphics = try UserDefinedBoxDrawing(base: .Light(detail: .Normal))

        userDefinedGraphics.graphic[.UpperLeftCorner] = try ComplexCharacter(0x256d)
        userDefinedGraphics.graphic[.UpperRightCorner] = try ComplexCharacter(0x256e)
        userDefinedGraphics.graphic[.LowerLeftCorner] = try ComplexCharacter(0x2570)
        userDefinedGraphics.graphic[.LowerRightCorner] = try ComplexCharacter(0x256f)

        let boxDrawingType = BoxDrawingType.UserDefined(graphics: userDefinedGraphics)

        try window.border(boxDrawingType)

        try window.print(string: "columns: \(Terminal.columns), lines: \(Terminal.lines)", origin: Coordinate(y: 1, x: 1))
        try window.print(character: BoxDrawing(boxDrawingType).graphic(.UpperLeftCorner), origin: Coordinate(y: 2, x: 1))

        try window.refresh()

        sleep(10)
    } catch {
        print(error)
    }

    try Terminal.endWindows()
} catch {
    print(error)
}

exit(EXIT_SUCCESS)
