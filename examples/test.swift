import NCursesw
import Foundation

do {
    do {
        let window = try Terminal.initialiseWindows()

        let boxDrawingType = BoxDrawingType.Light(detail: .Normal)

        try window.border(boxDrawingType)

        try window.put(string: "columns: \(Terminal.columns), lines: \(Terminal.lines)", origin: Coordinate(y: 1, x: 1))
        try window.put(character: BoxDrawing(boxDrawingType).graphic(.UpperLeftCorner), origin: Coordinate(y: 2, x: 1))

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
