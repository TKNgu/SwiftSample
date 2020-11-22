import SwiftSDL2

enum SDLError: Error {
    case initVideo
    case initWindow
    case initSurface
    case initImage
    case initTTF
}

typealias SDL_Texture = OpaquePointer

class Window: RenderTarget {
    static var count: Int = 0
    var name: String
    var rect: Rect
    var show: Rect
    var flag: SDL_WindowFlags
    let window: OpaquePointer?
    let screenTexture: OpaquePointer?
    var view: SDL_Rect

    func draw(drawable: Drawable, renderstates: RenderStates) {
        SDL_RenderCopy(self.screenTexture, drawable.texture, nil, nil);
    }

    init(name: String, rect: Rect, flag: SDL_WindowFlags) throws {
        Window.count += 1
        if Window.count == 1 {
            if SDL_Init(SDL_INIT_VIDEO) < 0 {
                throw SDLError.initVideo
            }
            let imgFlags: IMG_InitFlags = IMG_INIT_PNG
            if (IMG_Init(Int32(imgFlags.rawValue)) & Int32(imgFlags.rawValue)) == 0 {
                throw SDLError.initImage
            }
            if (TTF_Init() == -1) {
                throw SDLError.initTTF
            }
        }
        self.view = SDL_Rect(x: Int32(rect.w / 2), y: Int32(rect.h / 2), w: Int32(rect.w / 2), h: Int32(rect.h / 2))
        self.name = name
        self.rect = rect
        self.show = Rect(x: 0, y: 0, w: rect.w, h: rect.h)
        self.flag = flag
        self.window = SDL_CreateWindow(self.name,
            self.rect.x, self.rect.y, self.rect.w, self.rect.h,
            self.flag.rawValue)
        if self.window == nil {
            throw SDLError.initWindow
        }
        self.screenTexture = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED.rawValue | SDL_RENDERER_PRESENTVSYNC.rawValue)
        if self.screenTexture == nil {
            throw SDLError.initSurface
        }
        SDL_RenderSetViewport(self.screenTexture, &self.view)
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

    func getTexture() -> OpaquePointer? {
        SDL_RenderSetViewport(self.screenTexture, &self.show)
        return self.screenTexture
    }
}