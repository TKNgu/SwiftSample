import SwiftSDL2

struct Location {
    var x: Int
    var y: Int
}

class Tetromino: GameObjectSingle {
    var move: Location
    var location: Location

    init(texture: Texture) {
        self.location = Location(x: 0, y: 0)
        self.move = self.location
        super.init(sprite: Sprite(texture: texture,
            src: SDL_Rect(x: 160, y: 16, w: 16, h: 16)),
            dst: SDL_Rect(x: Int32(self.location.x * 32), y: Int32(640 - self.location.y * 32), w: 32, h: 32))
    }

    override func update() {
        super.dst = SDL_Rect(x: Int32(self.location.x * 32),
            y: Int32(640 - self.location.y * 32), w: 32, h: 32)
    }
}