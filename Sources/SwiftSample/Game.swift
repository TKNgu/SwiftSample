import SwiftSDL2

enum SDLGame: Error {
    case initVideo
    case initWindow
    case initRenderer
}

enum SDL_WINDOWPOS: Int32 {
    case CENTERED = 0x1FFF0000
    case UNDEFINED = 0
}

class Game {
    var running: Bool
    var window: Window
    var renderer: OpaquePointer?
    var drawableManager: DrawableManager
    var image: OpaquePointer? = nil
    var hero: OpaquePointer? = nil

    init(title: String, xpos: Int32, ypos: Int32,
        height: UInt32, width: UInt32, flags: SDL_WindowFlags) throws {
        self.window = try Window(name: title,
            rect: Rect(x: xpos, y: ypos, w: Int32(width), h: Int32(height)),
            flag: flags)
        // if SDL_Init(SDL_INIT_TIMER | SDL_INIT_AUDIO | SDL_INIT_VIDEO | SDL_INIT_EVENTS | SDL_INIT_JOYSTICK | SDL_INIT_HAPTIC | SDL_INIT_GAMECONTROLLER | SDL_INIT_SENSOR) < 0 {
        //     throw SDLGame.initVideo
        // }
        // self.window = SDL_CreateWindow(title,
        //     Int32(xpos), Int32(ypos), Int32(width), Int32(height),
        //     flags)
        // if self.window == nil {
        //     throw SDLGame.initWindow
        // }
        // self.renderer = SDL_CreateRenderer(self.window, -1,
        //     SDL_RENDERER_ACCELERATED.rawValue | SDL_RENDERER_PRESENTVSYNC.rawValue)
        // if self.renderer == nil {
        //     throw SDLGame.initRenderer
        // }
        self.running = true
        let drawableManagerSDL2 = DrawableManagerSDL2(renderer: self.window.screenTexture!)
        try drawableManagerSDL2.load(path: "Data/image.png", id: "back")
        try drawableManagerSDL2.load(path: "Data/freeknight/png/Attack (1).png", id: "herro")
        self.drawableManager = drawableManagerSDL2

        // var surface = UnsafeMutablePointer<SDL_Surface>(IMG_Load("Data/image.png"))
        // self.image = SDL_CreateTextureFromSurface(self.renderer, surface);
        // surface = UnsafeMutablePointer<SDL_Surface>(IMG_Load("Data/freeknight/png/Attack (1).png"))
        // self.hero = SDL_CreateTextureFromSurface(self.renderer, surface)
        // self.image = try Image(path: "Data/image.png")
        // .load()
        // .optimized(texture: self.window!)
        // self.hero = try Image(path: "Data/freeknight/png/Attack (1).png")
        // .load()
        // .optimized(texture: self.window!)
    }

    func render() {
        self.window.clean(color: Color(r: 0, g: 0, b: 0, a: 255))
        if let drawable = self.drawableManager.getDrawable(id: "herro") {
            self.window.draw(drawable: drawable, renderstates: Sample())
        }
        self.window.update()
    }

    func updae() {
        
    }

    func handleEvents() {
        var event = SDL_Event(type: UInt32(0))
        if SDL_PollEvent(&event) != 0 {
            switch event.type {
            case SDL_QUIT.rawValue:
                self.running = false
            default:
                break
            }
        }
    }
}