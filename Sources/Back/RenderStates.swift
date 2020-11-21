import SwiftSDL2

struct RenderStates {
    var src: SDL_Rect
    var dst: SDL_Rect
    var angle: Double
    var point: SDL_Point
    var flip: SDL_RendererFlip
}