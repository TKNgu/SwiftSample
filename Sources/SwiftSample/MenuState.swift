import SwiftSDL2

class MenuState: GameState {
    var screenTexture: OpaquePointer?
    var gameObjects: [GameObject] = []
    var mouseEvents: [(_ x: Int, _ y: Int) -> Void] = []
    var mouseUp: [() -> Void] = []
    var mouseDown: [() -> Void] = []

    init(screenTexture: OpaquePointer?) throws {
        self.screenTexture = screenTexture
        let start = MenuButton(x: 160, y: 185,
            width: 320, height: 49,
            id: "ui",
            nomal: SDL_Rect(x: Int32(0), y: Int32(94), w: Int32(190), h: Int32(49)),
            select: SDL_Rect(x: Int32(190), y: Int32(49), w: Int32(190), h: Int32(45)),
            click: {
                print("Start")
            }
        )
        self.mouseEvents.append(start.onMouseMove)
        self.mouseDown.append(start.onMouseDown)
        self.mouseUp.append(start.onMouseUp)
        self.gameObjects.append(start)
        let exit = MenuButton(x: 160, y: 245,
            width: 320, height: 49,
            id: "ui",
            nomal: SDL_Rect(x: Int32(0), y: Int32(94), w: Int32(190), h: Int32(49)),
            select: SDL_Rect(x: Int32(190), y: Int32(49), w: Int32(190), h: Int32(45)),
            click: {
                print("Exit")
            }
        )
        self.mouseEvents.append(exit.onMouseMove)
        self.mouseDown.append(exit.onMouseDown)
        self.mouseUp.append(exit.onMouseUp)
        self.gameObjects.append(exit)
    }

    func onEnter() throws {
        print("Menu state enter")
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