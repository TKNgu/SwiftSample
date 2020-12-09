protocol GameState {
    func onEnter()
    func onResume()
    func update()
    func render()
    func onPause()
    func onExit()
}