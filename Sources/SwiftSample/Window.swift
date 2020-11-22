class Window {
    var name: String
    var rect: Rect

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
    }

    func clean() { }
    func draw() { }
}