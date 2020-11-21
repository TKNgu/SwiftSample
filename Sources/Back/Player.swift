import SwiftSDL2

class Player: GameObject {
    var offset: Int
    var count: Int
    var flip: SDL_RendererFlip
    var lastTime: Double

    override init(x: Double, y: Double,
        width: Double, height: Double,
        id: String) {
        self.offset = Int.random(in: 0..<10)
        self.count = 10
        self.flip = SDL_FLIP_NONE
        self.lastTime = 0
        super.init(x: x, y: y, width: width, height: height, id: id)
        super.id = "robot_idle"
    }

    func idle() {
        super.id = "robot_idle"
        self.velocity = Vector(x: 0, y: 0)
    }

    func runJump() {
        super.id = "robot_jump"
        self.count = 10
        self.velocity = Vector(x: 0, y: 0)
    }

    func runLeft() {
        super.id = "robot_run"
        self.count = 8
        self.velocity = Vector(x: -60, y: 0)
        self.flip = SDL_FLIP_HORIZONTAL
    }

    func runRight() {
        super.id = "robot_run"
        self.count = 8
        self.velocity = Vector(x: 60, y: 0)
        self.flip = SDL_FLIP_NONE
    }

    override func update(time: Double) {
        if self.lastTime == 0 {
            self.lastTime = time
        }
        super.index = (Int(time * 10) + self.offset) % self.count
        self.position += self.velocity * (time - self.lastTime)
        self.lastTime = time
    }

    override func draw() {
        var rect = SDL_Rect(x: Int32(self.position.x), y: Int32(self.position.y),
            w: Int32(self.width), h: Int32(self.height))
        if let image = ImageManager.imageManager.getImage(id: self.id, index: self.index) {
            image.draw(src: nil, dst: &rect, angle: 0, center: nil, flip: self.flip)
        }
    }

    override func clean() {
        print("Clean")
    }
}