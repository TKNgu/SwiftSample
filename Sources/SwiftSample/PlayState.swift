import SwiftSDL2

class PlayState: GameState {
    var screenTexture: OpaquePointer?
    var player: Player
    var keyMapDown: [UInt32: () -> Void] = [:]
    var keyMapUp: [UInt32: () -> Void] = [:]
    var space: UnsafeMutablePointer<cpSpace>
    var map: Map

    init(screenTexture: OpaquePointer?) {
        self.screenTexture = screenTexture
        self.space = cpSpaceNew()
        let gravity = cpv(0, -1)
        cpSpaceSetGravity(self.space, gravity)

        self.player = Player(x: 0, y: 100, width: 100, height: 100, id: "robot")

        self.keyMapDown[SDL_SCANCODE_LEFT.rawValue] = self.player.runLeft
        self.keyMapDown[SDL_SCANCODE_RIGHT.rawValue] = self.player.runRight
        self.keyMapDown[SDL_SCANCODE_UP.rawValue] = self.player.runJump

        self.keyMapUp[SDL_SCANCODE_LEFT.rawValue] = self.player.idle
        self.keyMapUp[SDL_SCANCODE_RIGHT.rawValue] = self.player.idle
        self.keyMapUp[SDL_SCANCODE_UP.rawValue] = self.player.idle

        self.map = Map(screenTexture: screenTexture)
        self.map.addSpace(space: self.space)
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
        var renderStates = RenderStates(src: SDL_Rect(x: 0, y: 0, w: 0, h: 0),
        dst: SDL_Rect(x: 0, y: 0, w: 0, h: 0),
        angle: 0,
        point: SDL_Point(x: 0, y: 0),
        flip: SDL_FLIP_NONE)
        self.player.draw(renderStates: renderStates)
        self.map.draw(renderStates: renderStates)
    }

    func onPause() {

    }

    func onExit() {
        
    }
}