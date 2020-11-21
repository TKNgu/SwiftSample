import SwiftSDL2

struct InputHandler {
    var quit: () -> Void = {}

    func update() {
        var event = SDL_Event(type: UInt32(0))
        while SDL_PollEvent(&event) != 0 {
            switch event.type {
                case SDL_QUIT.rawValue:
                    self.quit()
                default:
                    break
            }
        }
    }
}