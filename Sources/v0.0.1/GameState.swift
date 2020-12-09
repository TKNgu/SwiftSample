protocol GameState {
    var changState: () -> Void {
        set
        get
    }
    func enter()
    func resume()
    func update()
    func render()
    func pause()  
    func exit()
}