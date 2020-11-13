import SwiftSDL2

class PlayState: GameState {
    var screenTexture: OpaquePointer?
    var player: Player
    var keyMapDown: [UInt32: () -> Void] = [:]
    var keyMapUp: [UInt32: () -> Void] = [:]

    init(screenTexture: OpaquePointer?) {
        self.screenTexture = screenTexture
        self.player = Player(x: 0, y: 100, width: 100, height: 100, id: "robot")

        self.keyMapDown[SDL_SCANCODE_LEFT.rawValue] = self.player.runLeft
        self.keyMapDown[SDL_SCANCODE_RIGHT.rawValue] = self.player.runRight
        self.keyMapDown[SDL_SCANCODE_UP.rawValue] = self.player.runJump

        self.keyMapUp[SDL_SCANCODE_LEFT.rawValue] = self.player.idle
        self.keyMapUp[SDL_SCANCODE_RIGHT.rawValue] = self.player.idle
        self.keyMapUp[SDL_SCANCODE_UP.rawValue] = self.player.idle
    }

    func onEnter() throws {
        try ImageManager.imageManager.load(
            fileName: "Data/robotfree/png/Idle",
            id: "robot_idle",
            count: 11,
            screenTexture: self.screenTexture
        )
        try ImageManager.imageManager.load(
            fileName: "Data/robotfree/png/Run",
            id: "robot_run",
            count: 9,
            screenTexture: self.screenTexture
        )
        try ImageManager.imageManager.load(
            fileName: "Data/robotfree/png/Jump",
            id: "robot_jump",
            count: 11,
            screenTexture: self.screenTexture
        )
    }

    func onResume() {
        InputHandler.inputHandler.keyMapDown = self.keyMapDown
        InputHandler.inputHandler.keyMapUp = self.keyMapUp
    }

    func update(time: Double) {
        self.player.update(time: time)
    }

    func render() {
        self.player.draw()
    }

    func onPause() {

    }

    func onExit() {
        
    }
}