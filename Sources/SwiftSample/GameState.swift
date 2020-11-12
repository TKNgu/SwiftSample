protocol GameState {
    func onEnter() throws
    func onResume()
    func update(time: Double)
    func render()
    func onPause()
    func onExit()
}