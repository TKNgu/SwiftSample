import SwiftSDL2

enum SDLWindowError: Error {
    case initWindow
    case initTexture
}

enum SDL_WINDOWPOS: Int32 {
    case CENTERED = 0x1FFF0000
    case UNDEFINED = 0
}

class WindowSDL2: Window {
    var window: OpaquePointer?
    var texture: OpaquePointer?

    override init(name: String, rect: Rect) {
        self.window = nil
        self.texture = nil
        super.init(name: name, rect: rect)
    }

    func initSDL2 (flag: SDL_WindowFlags) throws {
        self.window = SDL_CreateWindow(self.name,
            self.rect.x, self.rect.y, self.rect.w, self.rect.h,
            flag.rawValue)
        if self.window == nil {
            throw SDLWindowError.initWindow
        }
        self.texture = SDL_CreateRenderer(self.window, -1,
            SDL_RENDERER_ACCELERATED.rawValue | SDL_RENDERER_PRESENTVSYNC.rawValue)
        if self.texture == nil {
            throw SDLWindowError.initTexture
        }
    }

    override func clean() {
        SDL_RenderClear(self.texture)
    }

    override func draw() {
        SDL_RenderPresent(self.texture)
    }
}