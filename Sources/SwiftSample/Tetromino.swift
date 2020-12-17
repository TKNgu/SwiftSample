import SwiftSDL2

struct Location {
    var x: Int
    var y: Int
}

let DEFAULT_LOCATION = Location(x: 5, y: 6)

class Tetromino: GameObject {
    var move: Location
    var location: Location
    var block: GameBlock
    var isMove: Bool
    var isDown: Bool

    init(texture: Texture) {
        self.location = DEFAULT_LOCATION
        self.move = self.location
        self.block = GameBlock(sprite: Sprite(texture: texture,
            src: SDL_Rect(x: 160, y: 16, w: 16, h: 16)),
            location: self.location)
        self.isMove = false
        self.isDown = false
    }

    func reset() {
        self.location = DEFAULT_LOCATION
        self.move = self.location
    }

    func moveLeft() {
        self.move.x = self.location.x - 1
        self.isMove = true
    }

    func moveRight() {
        self.move.x = self.location.x + 1
        self.isMove = true
    }

    func rotate() {
        self.move.y = self.location.y + 1
        self.isMove = true
    }

    func speed() {
        self.move.y = self.location.y - 1
        self.isDown = true
    }

    func appline() {
        self.location = self.move
    }

    func update() {
        self.block.chang(location: self.location)
    }

    func draw(window: Window) {
        self.block.draw(window: window)
    }
}