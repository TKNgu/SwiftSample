// import SwiftSDL2

// enum SDLWindowError: Error {
//     case initWindow
//     case initRenderer
// }

// enum SDL_WINDOWPOS: Int32 {
//     case CENTERED = 0x1FFF0000
//     case UNDEFINED = 0
// }

// class WindowSDL2 {
//     var rect: Rect
//     var window: OpaquePointer?
//     var renderer: OpaquePointer?

//     init(name: String, rect: Rect, flags: SDL_WindowFlags) throws {
//         self.rect = rect
//         self.window = SDL_CreateWindow(name,
//             self.rect.x, self.rect.y, self.rect.w, self.rect.h,
//             flags.rawValue)
//         if self.window == nil {
//             throw SDLWindowError.initWindow
//         }
//         self.renderer = SDL_CreateRenderer(self.window, -1,
//             SDL_RENDERER_ACCELERATED.rawValue | SDL_RENDERER_PRESENTVSYNC.rawValue)
//         if self.renderer == nil {
//             throw SDLWindowError.initRenderer
//         }
//     }

//     func draw(drawable: Drawable, renderStates: RenderStates) {
//         SDL_RenderCopy(self.renderer, drawable.texture, nil, nil)
//     }

//     func draw(sprite: Sprite, renderStates: RenderStates) {
//         // SDL_RenderCopy(self.renderer, sprite.drawable.texture, &sprite.rect, nil)
//     }

//     func clean() {
//         SDL_RenderClear(self.renderer)
//     }

//     func present() {
//         SDL_RenderPresent(self.renderer)
//     }
// }