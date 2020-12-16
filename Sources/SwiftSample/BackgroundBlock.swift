class BackgroundBlock: GameBlock {
    var enable: Bool

    override init(sprite: Sprite, location: Location) {
        self.enable = false
        super.init(sprite: sprite, location: location)
    }

    override func draw(window: Window) {
        if self.enable {
            super.draw(window: window)
        }
    }
}