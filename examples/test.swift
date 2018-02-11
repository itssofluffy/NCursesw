import NCursesw
import Foundation

do {
    do {
        let window = try Terminal.initialiseWindows()

        try window.border(.Double)

        try window.put(string: "columns: \(Terminal.columns), lines: \(Terminal.lines)", origin: Coordinate(y: 1, x: 1))
        try window.put(character: BoxDrawing(.Light, attributes: .Low).graphic(.UpperLeftCorner), origin: Coordinate(y: 2, x: 1))

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
