import SwiftSDL2

class MenuState: GameState {
    var screenTexture: OpaquePointer?
    var gameObjects: [GameObject] = []
    var mouseEvents: [(_ x: Int, _ y: Int) -> Void] = []
    var mouseUp: [() -> Void] = []
    var mouseDown: [() -> Void] = []
    var startButton: MenuButton
    var exitButton: MenuButton

    init(screenTexture: OpaquePointer?) {
        self.screenTexture = screenTexture
        self.startButton = MenuButton(x: 160, y: 185,
            width: 320, height: 49,
            id: "ui",
            nomal: SDL_Rect(x: Int32(0), y: Int32(94), w: Int32(190), h: Int32(49)),
            select: SDL_Rect(x: Int32(190), y: Int32(49), w: Int32(190), h: Int32(45))
        )
        self.mouseEvents.append(startButton.onMouseMove)
        self.mouseDown.append(startButton.onMouseDown)
        self.mouseUp.append(startButton.onMouseUp)
        self.gameObjects.append(startButton)
        self.exitButton = MenuButton(x: 160, y: 245,
            width: 320, height: 49,
            id: "ui",
            nomal: SDL_Rect(x: Int32(0), y: Int32(94), w: Int32(190), h: Int32(49)),
            select: SDL_Rect(x: Int32(190), y: Int32(49), w: Int32(190), h: Int32(45))
        )
        self.mouseEvents.append(exitButton.onMouseMove)
        self.mouseDown.append(exitButton.onMouseDown)
        self.mouseUp.append(exitButton.onMouseUp)
        self.gameObjects.append(exitButton)
    }

    func onEnter() throws {
        try ImageManager.imageManager.load(
            fileName: "Data/UIpack/Spritesheet/blueSheet.png",
            id: "ui",
            screenTexture: self.screenTexture
        )
    }

    func onResume() {
        InputHandler.inputHandler.mouseEvents = self.mouseEvents
        InputHandler.inputHandler.mouseDown = self.mouseDown
        InputHandler.inputHandler.mouseUp = self.mouseUp
    }

    func update(time: Double) {
        for gameObject in self.gameObjects {
            gameObject.update(time: time)
        }
    }

    func render() {
        for gameObject in self.gameObjects {
            gameObject.draw()
        }
    }

    func onPause() {
        InputHandler.inputHandler.mouseEvents = []
        InputHandler.inputHandler.mouseDown = []
        InputHandler.inputHandler.mouseUp = []
    }

    func onExit() {
        //TODO
    }
}