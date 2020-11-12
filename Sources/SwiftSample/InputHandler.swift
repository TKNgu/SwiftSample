import SwiftSDL2

class InputHandler {
    static let inputHandler = InputHandler()

    var quit: () -> Void = {}
    var keyMapDown: [Int: () -> Void] = [:]
    var keyMapUp: [Int: () -> Void] = [:]
    var keystate: UnsafePointer<UInt8>? = nil

    private init() {
        //TODO
    }

    func onKeyDown() {
        for (keyCode, event) in self.keyMapDown {
            if self.keystate![keyCode] == 1 {
                event()
            }
        }
    }

    func onKeyUp() {
        for (keyCode, event) in self.keyMapUp {
            if self.keystate![keyCode] == 0 {
                event()
            }
        }
    }

    func onMouseMove(event: SDL_Event) {
        //TODO
    }

    func onMouseButtonDown(event: SDL_Event) {
        //TODO
    }

    func onMouseButtonUp(event: SDL_Event) {
        //TODO
    }

    func onQuit(event: SDL_Event) {
        self.quit()
    }

    func update() {
        var event = SDL_Event(type: UInt32(0))
        while SDL_PollEvent(&event) != 0 {
            self.keystate = SDL_GetKeyboardState(nil)
            switch event.type {
                case SDL_QUIT.rawValue:
                    onQuit(event: event)
                case SDL_MOUSEMOTION.rawValue:
                    onMouseMove(event: event)
                case SDL_MOUSEBUTTONDOWN.rawValue:
                    onMouseButtonUp(event: event)
                case SDL_MOUSEBUTTONUP.rawValue:
                    onMouseButtonUp(event: event)
                case SDL_KEYDOWN.rawValue:
                    onKeyDown()
                case SDL_KEYUP.rawValue:
                    onKeyUp()
                default:
                    break
            }
        }
    }
}