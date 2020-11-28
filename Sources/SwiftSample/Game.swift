import SwiftSDL2

enum SDLError: Error {
    case initVideo
    case initImage
    case initTTF
}

final class Game {
    var inputHandler: InputHandler
    // var image: Drawable?
    // var drawableManager: DrawableManager
    var image: Image
    var window: Window
    var isRunning: Bool
    var imageManager: ImageManager

    init(name: String, rect: SDL_Rect) throws {
        if SDL_Init(SDL_INIT_VIDEO) < 0 {
            throw SDLError.initVideo
        }
        let imgFlag = IMG_INIT_PNG
        if IMG_Init(Int32(imgFlag.rawValue)) & Int32(imgFlag.rawValue) == 0 {
            throw SDLError.initImage
        }
        if TTF_Init() == -1 {
            throw SDLError.initTTF
        }
        // let windowSDL2 = try WindowSDL2(name: name, rect: rect, flags: SDL_WINDOW_SHOWN)
        // let drawableManager = DrawableManagerSDL2TextureAtlas(windowSDL2: windowSDL2)
        // self.drawableManager = drawableManager
        self.inputHandler = InputHandler()
        self.window = try Window(name: name, rect: rect, flags: SDL_WINDOW_SHOWN)
        self.imageManager = ImageManager(window: self.window)
        self.image = try self.imageManager.load(path: "Data/freeknight/png/Attack (1).png")
        self.isRunning = true
        // self.image = nil
        self.inputHandler.quit = {
            self.isRunning = false
        }

        // drawableManager.loadXML(path: "Data/map/Tiles/tiles_spritesheet.xml")
    }

    // func load() throws {
    //     self.image = try self.drawableManager.getDrawable(id: "Data/freeknight/png/Attack (1).png")
    //     self.isRunning = true
    // }
    
    func input() {
        self.inputHandler.update()
    }

    // func update() {

    // }

    func draw() {
        self.window.clean()
        var dst = self.image.rect
        self.window.draw(image: self.image, src: &self.image.rect, dst: &dst) 
        self.window.present()
    }

    // func save() {

    // }
}