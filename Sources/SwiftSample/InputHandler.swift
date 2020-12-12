import SwiftSDL2

class InputHandler {
    static let instance = InputHandler()

    var quit: () -> Void = {}
    var keyMapDown: [UInt32: () -> Void] = [:]
    var keyMapUp: [UInt32: () -> Void] = [:]
    var keystate: UnsafePointer<UInt8>? = nil
    var mouseEvents: [(_ x: Int, _ y: Int) -> Void] = []
    var mouseDown: [() -> Void] = []
    var mouseUp: [() -> Void] = []

    private init() {
        //TODO
    }

    func onKeyDown() {
        for (keyCode, event) in self.keyMapDown {
            if self.keystate![Int(keyCode)] == 1 {
                event()
            }
        }
    }

    func onKeyUp() {
        for (keyCode, event) in self.keyMapUp {
            if self.keystate![Int(keyCode)] == 0 {
                event()
            }
        }
    }

    func onMouseMove(event: SDL_Event) {
        var x = Int32(0)
        var y = Int32(0)
        SDL_GetMouseState(&x, &y)
        for event in self.mouseEvents {
            event(Int(x), Int(y))
        }
    }

    func onMouseButtonDown(event: SDL_Event) {
        for event in self.mouseDown {
            event()
        }
    }

    func onMouseButtonUp(event: SDL_Event) {
        for event in self.mouseUp {
            event()
        }
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
                    onMouseButtonDown(event: event)
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