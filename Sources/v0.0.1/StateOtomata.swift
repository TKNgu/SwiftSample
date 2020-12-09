class StateOtomata {
    let window: Window
    let imageManager: ImageManager
    var gameStates: [String: GameState]

    init(window: Window) {
        self.window = window
        self.imageManager = ImageManager(window: window)
        self.gameStates = ["MenuState": MenuState()]
    }

    func getState() -> GameState {
        return self.gameStates["MenuState"]!
    }
}