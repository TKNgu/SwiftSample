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
    var window: OpaquePointer?
    var renderer: OpaquePointer?
    var running: Bool
    var fsm: FSM
    var menuState: MenuState
    var playState: PlayState

    init(title: String, xpos: Int32, ypos: Int32,
        height: UInt32, width: UInt32, flags: UInt32) throws {
        if SDL_Init(SDL_INIT_TIMER | SDL_INIT_AUDIO | SDL_INIT_VIDEO | SDL_INIT_EVENTS | SDL_INIT_JOYSTICK | SDL_INIT_HAPTIC | SDL_INIT_GAMECONTROLLER | SDL_INIT_SENSOR) < 0 {
            throw SDLGame.initVideo
        }
        self.window = SDL_CreateWindow(title,
            Int32(xpos), Int32(ypos), Int32(width), Int32(height),
            flags)
        if self.window == nil {
            throw SDLGame.initWindow
        }
        self.renderer = SDL_CreateRenderer(self.window, -1,
            SDL_RENDERER_ACCELERATED.rawValue | SDL_RENDERER_PRESENTVSYNC.rawValue)
        if self.renderer == nil {
            throw SDLGame.initRenderer
        }
        self.running = true
        self.fsm = FSM()
        self.menuState = MenuState(screenTexture: self.renderer)
        self.playState = PlayState(screenTexture: self.renderer) 
        self.menuState.exitButton.click = {
            self.running = false
        }
        self.menuState.startButton.click = self.changPlayState
        self.changMenuState()
        InputHandler.inputHandler.quit = {
            self.running = false
        }
    }

    func changPlayState() {
        self.fsm.popState()
        do {
            try self.fsm.pushState(state: self.playState)
        } catch {
            print("Error play")
        }
    }

    func changMenuState() {
        self.fsm.popState()
        do {
            try self.fsm.pushState(state: self.menuState)
        } catch {
            print("Error menu")
        }
    }

    deinit {
        SDL_DestroyRenderer(self.renderer)
        SDL_DestroyWindow(self.window)
        SDL_Quit()
    }

    func render() {
        SDL_SetRenderDrawColor(self.renderer,
            0, 0, 0, 255)
        SDL_RenderClear(self.renderer)
        for state in self.fsm.states {
            state.render()
        }
        SDL_RenderPresent(self.renderer)
    }

    func update() {
        let tick = SDL_GetTicks()
        for state in self.fsm.states {
            state.update(time: Double(tick) / 1000.0)
        }
    }

    func handleEvents() {
        InputHandler.inputHandler.update()
    }
}