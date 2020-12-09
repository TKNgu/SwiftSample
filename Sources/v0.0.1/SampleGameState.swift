class SampleGameState: GameState {
    var changState: () -> Void

    init() {
        print("Init")
        self.changState = {}
    }

    func enter() {
        print("Enter")
    }

    func resume() {
        print("Resume")
    }

    func update() {
        print("Update")
    }

    func render() {
        print("Render")
    }

    func pause() {
        print("Pause")
    }

    func exit() {
        print("Exit")
    }

    deinit {
        print("Exit")
    }
}