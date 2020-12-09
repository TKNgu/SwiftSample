import SwiftSDL2

enum SDLError: Error {
    case initVideo
    case initImage
    case initTTF
}

final class Game {
    var window: Window
    var isRunning: Bool
    var imageManager: ImageManager
    var runningState: GameState

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
        self.window = try Window(name: name, rect: rect, flags: SDL_WINDOW_SHOWN)
        self.imageManager = ImageManager(window: self.window)
        self.isRunning = true
        self.runningState = try Menu(imageManager: self.imageManager, window: self.window)
        self.runningState.onEnter()
        InputHandler.instance.quit = {
            self.isRunning = false
        }
    }

    func input() {
        InputHandler.instance.update()
    }

    func update() {
        self.runningState.update()
    }

    func draw() {
        self.window.clean()
        self.runningState.render()
        self.window.present()
    }
}