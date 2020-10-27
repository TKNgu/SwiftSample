import SwiftSDL2

enum SDLError: Error {
    case initVideo
    case initWindow
    case initSurface
    case initImage
}

typealias SDL_Texture = OpaquePointer

class Window {
    static var count: Int = 0
    var name: String
    var rect: Rect
    var flag: SDL_WindowFlags
    let window: OpaquePointer?
    let screenTexture: OpaquePointer?

    init(name: String, rect: Rect, flag: SDL_WindowFlags) throws {
        Window.count += 1
        if Window.count == 1 {
            if SDL_Init(SDL_INIT_VIDEO) < 0 {
                throw SDLError.initVideo
            }
            let imgFlags: IMG_InitFlags = IMG_INIT_PNG
            if (IMG_Init(Int32(imgFlags.rawValue)) & Int32(imgFlags.rawValue)) == 0 {
        print("Init")
                throw SDLError.initImage
            }
        }
        self.name = name
        self.rect = rect
        self.flag = flag
        self.window = SDL_CreateWindow(self.name,
            self.rect.x, self.rect.y, self.rect.w, self.rect.h,
            self.flag.rawValue)
        if self.window == nil {
            throw SDLError.initWindow
        }
        self.screenTexture = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED.rawValue)
        if self.screenTexture == nil {
            throw SDLError.initSurface
        }
    }

    func clean(color: Color) {
        SDL_SetRenderDrawColor(self.screenTexture, color.r, color.g, color.b, color.a);
        SDL_RenderClear(self.screenTexture)
    }

    func update() {
        SDL_RenderPresent(self.screenTexture);
    }

    deinit {
        SDL_DestroyRenderer(self.screenTexture)
        SDL_DestroyWindow(self.window)
        Window.count -= 1
        if Window.count == 0 {
            SDL_Quit()
        }
    }
}