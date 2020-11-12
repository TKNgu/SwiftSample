protocol GameState {
    func update()
    func render()
    func onEnter()
    func onResume()
    func onPause()
    func onExit()
}