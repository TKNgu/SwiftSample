final class Game {
    var isRunning: Bool
    var inputHandler: InputHandler
    var window: Window
    init(name: String, rect: Rect) {
        print("Init")
        self.isRunning = false
        self.inputHandler = InputHandler()
        self.window = Window(name: name, rect: rect)
        self.inputHandler.quit = {
            self.isRunning = false
        }
    }
    func load() {
        self.isRunning = true
    }
    func input() {
        self.inputHandler.update()
    }
    func update() {
        print("update")
    }
    func draw() {
        print("draw")
    }
    func save() {
        print("save")
    }
}