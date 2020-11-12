class FSM {
    var states: [GameState] = []

    func pushState(state: GameState) throws {
        if let last = self.states.last {
            last.onPause()
        }
        try state.onEnter()
        state.onResume()
        self.states.append(state)
    }

    func popState(state: GameState) {
        if let last = self.states.last {
            last.onPause()
            last.onExit()
            _ = self.states.popLast()
        }
        if let last = self.states.last {
            last.onResume()
        }
    }
}