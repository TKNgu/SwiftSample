import SwiftSDL2

struct Color {
    var r: Uint8 = 0xFF
    var g: Uint8 = 0xFF
    var b: Uint8 = 0xFF
    var a: Uint8 = 0xFF
}

typealias Rect = SDL_Rect
typealias Point = SDL_Point

// enum SDL_WINDOWPOS: Int32 {
//     case CENTERED = 0x1FFF0000
//     case UNDEFINED = 0
// }