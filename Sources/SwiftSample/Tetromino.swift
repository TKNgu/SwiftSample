import SwiftSDL2

struct Location {
    var x: Int32
    var y: Int32

    static func +(a: Location, b: Location) -> Location {
        return Location(x: a.x + b.x, y: a.y + b.y)
    }    
}

class Tetromino: GameObject {
    var sprites: [Sprite]
    var lastTime: UInt32

    var location: Location
    var cache: [Location]
    var profile: [[Location]]
    var maple: [SDL_Rect]
    var index: Int

    init(texture: Texture) {
        self.sprites = []
        let spriteO = Sprite(texture: texture,
            src: SDL_Rect(x: 0, y: 128, w: 64, h: 64))
        self.sprites.append(spriteO)
        let spriteI = Sprite(texture: texture,
            src: SDL_Rect(x: 64, y: 128, w: 64, h: 64))
        self.sprites.append(spriteI)
        let spriteL = Sprite(texture: texture,
            src: SDL_Rect(x: 128, y: 128, w: 64, h: 64))
        self.sprites.append(spriteL)
        let spriteJ = Sprite(texture: texture,
            src: SDL_Rect(x: 192, y: 128, w: 64, h: 64))
        self.sprites.append(spriteJ)
        self.lastTime = SDL_GetTicks()

        self.location = Location(x: 3, y: 10)
        self.profile = [[Location(x: 0, y: 2), Location(x: 1, y: 2), Location(x: 2, y: 2), Location(x: 3, y: 2)],
                [Location(x: 2, y: 0), Location(x: 2, y: 1), Location(x: 2, y: 2), Location(x: 2, y: 3)],
                [Location(x: 0, y: 1), Location(x: 1, y: 1), Location(x: 2, y: 1), Location(x: 3, y: 1)],
                [Location(x: 1, y: 0), Location(x: 1, y: 1), Location(x: 1, y: 2), Location(x: 1, y: 3)]]
        self.maple = [SDL_Rect(x: 0, y: 32, w: 128, h: 128)]
        self.index = 0
        self.cache = [self.profile[self.index][0] + self.location,
            self.profile[self.index][1] + self.location,
            self.profile[self.index][2] + self.location,
            self.profile[self.index][3] + self.location]
    }

    func left() {
        self.location.x -= 1
    }

    func right() {
        self.location.x += 1
    }

    func down() {
        self.location.y -= 1
    }

    func rotate() {
        self.index += 1
        self.index %= 4
    }

    func update() {
        if SDL_GetTicks() - self.lastTime > 1000 {
            // self.location.y -= 1
            self.lastTime += 1000
        }
        self.cache = [self.profile[self.index][0] + self.location,
            self.profile[self.index][1] + self.location,
            self.profile[self.index][2] + self.location,
            self.profile[self.index][3] + self.location]
    }

    func draw(window: Window) {
        var tmp = SDL_Rect(x: Int32(self.maple[0].x + self.location.x * 32),
            y: Int32(self.maple[0].y + (20 - self.location.y) * 32),
            w: self.maple[0].w, h: self.maple[0].h)
        withUnsafePointer(to: &tmp, {(dst: UnsafePointer<SDL_Rect>) in
            window.draw(sprite: self.sprites[self.index], dst: dst)
        })
    }
}