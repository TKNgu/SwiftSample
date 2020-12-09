import SwiftSDL2

enum SDLError: Error {
    case initVideo
    case initImage
    case initTTF
}

let TIME_FRAME = UInt32(40)
let NAME = "Sample"
let RECT = SDL_Rect(
    x: SDL_WINDOWPOS.CENTERED.rawValue,
    y: SDL_WINDOWPOS.CENTERED.rawValue,
    w: 640, h: 480)

class Game {
    var isRunning: Bool
    var window: Window
    var state: GameState
    var stateOtomata: StateOtomata

    init() throws {
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
        self.window = try Window(name: NAME, rect: RECT, flags: SDL_WINDOW_SHOWN)
        self.isRunning = true
        self.stateOtomata = StateOtomata(window: self.window)
        self.state = self.stateOtomata.getState()
        self.state.changState = self.changState
        InputHandler.instance.quit = {
            self.isRunning = false
        }
    }

    func changState() {

    }

    func loop() { 
        var endTime = SDL_GetTicks()
        var starTime = endTime
        var delta = UInt32(0)
        while self.isRunning {
            self.input()
            self.update()
            self.render()
            endTime = SDL_GetTicks()
            delta = endTime - starTime
            starTime = endTime
            if TIME_FRAME > delta {
                SDL_Delay(TIME_FRAME - delta)
            }
        }
    }

    func input() {
        InputHandler.instance.update()
    }

    func update() {
        self.state.update()
    }

    func render() {
        self.window.clean()
        self.state.render()
        self.window.present()
    }
}