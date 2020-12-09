import SwiftSDL2

enum SDLWindowError: Error {
    case initWindow
    case initRenderer
}

enum SDL_WINDOWPOS: Int32 {
    case CENTERED = 0x1FFF0000
    case UNDEFINED = 0
}

class Window {
    let window: OpaquePointer
    let renderer: OpaquePointer

    init(name: String, rect: SDL_Rect, flag: SDL_WindowFlags) throws {
        guard let window = SDL_CreateWindow(name,
            rect.x, rect.y, rect.w, rect.h, flag.rawValue) else {
            throw SDLWindowError.initWindow
        }
        self.window = window
        guard let renderer = SDL_CreateRenderer(self.window, -1,
            SDL_RENDERER_ACCELERATED.rawValue | SDL_RENDERER_PRESENTVSYNC.rawValue) else {
            SDL_DestroyWindow(self.window)
            throw SDLWindowError.initRenderer
        }
        self.renderer = renderer
    }

    deinit {
        SDL_DestroyRenderer(self.renderer)
        SDL_DestroyWindow(self.window)
    }

    func clear() {
        SDL_RenderClear(self.renderer)
    }

    func present() {
        SDL_RenderPresent(self.renderer)
    }
}