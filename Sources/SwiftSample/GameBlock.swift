import SwiftSDL2

class GameBlock: GameObject {
    let sprite: Sprite
    var dst: SDL_Rect
    var location: Location

    init(sprite: Sprite, location: Location) {
        self.sprite = sprite
        self.location = location
        self.dst = SDL_Rect(x: Int32(self.location.x * 32),
            y: Int32(640 - self.location.y * 32), w: 32, h: 32)
    }

    init(block: GameBlock) {
        self.sprite = block.sprite
        self.dst = block.dst
        self.location = block.location
    }

    func chang(location: Location) {
        self.location = location
        self.dst = SDL_Rect(x: Int32(self.location.x * 32),
            y: Int32(640 - self.location.y * 32), w: 32, h: 32)
    }

    func update() {
    }

    func draw(window: Window) {
        withUnsafePointer(to: &self.dst, {(dst: UnsafePointer<SDL_Rect>) in
            window.draw(sprite: self.sprite, dst: dst)
        })
    }
}