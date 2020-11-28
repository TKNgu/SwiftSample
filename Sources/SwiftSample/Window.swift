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
    var rect: SDL_Rect
    var window: OpaquePointer? = nil
    var renderer: OpaquePointer? = nil

    init(name: String, rect: SDL_Rect, flags: SDL_WindowFlags) throws {
        self.rect = rect
        self.window = SDL_CreateWindow(name,
            self.rect.x, self.rect.y, self.rect.w, self.rect.h,
            flags.rawValue)
        if self.window == nil {
            throw SDLWindowError.initWindow
        }
        self.renderer = SDL_CreateRenderer(self.window, -1,
            SDL_RENDERER_ACCELERATED.rawValue | SDL_RENDERER_PRESENTVSYNC.rawValue)
        if self.renderer == nil {
            throw SDLWindowError.initRenderer
        }
    }

    deinit {
        if self.renderer == nil {
            SDL_DestroyRenderer(self.renderer)
        }
        if self.window == nil {
            SDL_DestroyWindow(self.window)
        }
    }

    func draw(texture: OpaquePointer, src: inout SDL_Rect, dst: inout SDL_Rect) {
        SDL_RenderCopy(self.renderer, texture, &src, &dst)
    }

    func draw(texture: OpaquePointer, src: inout SDL_Rect, dst: inout SDL_Rect, angle: Double, center: inout SDL_Point, flip: SDL_RendererFlip) {
        SDL_RenderCopyEx(self.renderer, texture, &src, &dst, angle, &center, flip)
    }

    func clean() {
        SDL_RenderClear(self.renderer)
    }

    func present() {
        SDL_RenderPresent(self.renderer)
    }
}