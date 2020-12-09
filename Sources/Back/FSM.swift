class FSM {
    var states: [GameState] = []

    func change(state: GameState) {
        self.pop()
        add(state: state)
    }

    func push(state: GameState) {
        if let last = self.states.last {
            last.onResume()
        }
        self.add(state: state)
    }

    func pop() {
        if let last = self.states.last {
            last.onPause()
            _ = self.states.popLast()
        }
    }

    private func add(state: GameState) {
        state.onResume()
        self.states.append(state)
    }
}