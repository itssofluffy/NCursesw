import NCursesw
import Foundation

var ripLine: NCurseswWindow?

func ripWindow(_ handle: WindowHandle?, _ columns: CInt) -> CInt {
    ripLine = NCurseswWindow(handle: handle!)

    try! ripLine!.print(string: "this is a rip-off line and has \(columns) columns...", origin: Coordinate(y: 0, x:0))

    return EXIT_SUCCESS
}

do {
    try Terminal.ripOff(from: .Lower, lines: 1, function: ripWindow)

    do {
        let window = try Terminal.initialiseWindows()

        func doRefresh() throws {
            try ripLine!.refresh()
            try window.refresh()
        }

        let boxDrawingType = BoxDrawingType.Light(detail: .Normal)

        try window.border(boxDrawingType)

        try window.print(string: "\(window.size)", origin: Coordinate(y: 1, x: 1))
        try window.print(character: BoxDrawing(boxDrawingType).graphic(.UpperLeftCorner), origin: Coordinate(y: 2, x: 1))

        try doRefresh()

        let _: UIResult<Character?> = try window.read(origin: Coordinate(y: 2, x: 2))

        try ripLine!.clear()
        try ripLine!.print(string: "and now the rip-off line has changed!!!", origin: Coordinate(y: 0, x: 0))

        try doRefresh()

        let _: UIResult<Character?> = try window.read(origin: Coordinate(y: 2, x: 2))
    } catch {
        print(error)
    }

    try Terminal.endWindows()
} catch {
    print(error)
}

exit(EXIT_SUCCESS)
