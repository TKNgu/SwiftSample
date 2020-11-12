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
    var window: OpaquePointer?
    var renderer: OpaquePointer?
    var gameObjects: [GameObject] = []

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

        InputHandler.inputHandler.quit = {
            self.running = false
        }
        InputHandler.inputHandler.keyMapDown[Int(SDL_SCANCODE_RIGHT.rawValue)] = {
            print("SDL_SCANCODE_RIGHT Down")
        }
        InputHandler.inputHandler.keyMapUp[Int(SDL_SCANCODE_RIGHT.rawValue)] = {
            print("SDL_SCANCODE_RIGHT Up")
        }

        try ImageManager.imageManager.load(
            fileName: "Data/freeknight/png/Attack",
            id: "knight_attack",
            count: 11,
            screenTexture: self.renderer
        )
        try ImageManager.imageManager.load(
            fileName: "Data/robotfree/png/Jump",
            id: "robot_attack",
            count: 11,
            screenTexture: self.renderer
        )
        try ImageManager.imageManager.load(
            fileName: "Data/robotfree/png/Dead",
            id: "robot_dead",
            count: 11,
            screenTexture: self.renderer
        )
        self.gameObjects.append(Player(x: 0, y: 0, width: 100, height: 100, id: "knight_attack"))
        self.gameObjects.append(Player(x: 200, y: 200, width: 100, height: 100, id: "knight_attack"))
        self.gameObjects.append(Player(x: 300, y: 300, width: 100, height: 100, id: "robot_attack"))
        self.gameObjects.append(Player(x: 300, y: 200, width: 100, height: 100, id: "robot_dead"))
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
        for gameObject in self.gameObjects {
            gameObject.draw()
        }
        SDL_RenderPresent(self.renderer)
    }

    func update() {
        let tick = SDL_GetTicks()
        for gameObject in self.gameObjects {
            gameObject.update(time: Double(tick) / 1000.0)
        }
    }

    func handleEvents() {
        InputHandler.inputHandler.update()
        // var event = SDL_Event(type: UInt32(0))
        // while SDL_PollEvent(&event) != 0 {
        //     switch event.type {
        //     case SDL_QUIT.rawValue:
        //         self.running = false
        //     default:
        //         break
        //     }
        // }
    }
}