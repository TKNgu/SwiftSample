import SwiftSDL2

class Player: GameObject {
    var offset: Int
    var count: Int
    var flip: SDL_RendererFlip
    var lastTime: Double
    var position: Vector
    var velocity: Vector
    var width: Double = 0
    var height: Double = 0
    var id: String
    var index: Int

    // init(x: Double, y: Double,
    //     width: Double, height: Double,
    //     id: String) {
    //     self.position = Vector(x: x, y: y)
    //     self.velocity = Vector()
    //     self.width = width
    //     self.height = height
    //     self.id = id
    //     self.index = 0   
    // }


    init(x: Double, y: Double,
        width: Double, height: Double,
        id: String) {
        self.offset = Int.random(in: 0..<10)
        self.count = 10
        self.flip = SDL_FLIP_NONE
        self.lastTime = 0
        self.position = Vector(x: x, y: y)
        self.velocity = Vector()
        self.width = width
        self.height = height
        self.id = "robot_idle"
        self.index = 0
    }

    func idle() {
        self.id = "robot_idle"
        self.velocity = Vector(x: 0, y: 0)
    }

    func runJump() {
        self.id = "robot_jump"
        self.count = 10
        self.velocity = Vector(x: 0, y: 0)
    }

    func runLeft() {
        self.id = "robot_run"
        self.count = 8
        self.velocity = Vector(x: -60, y: 0)
        self.flip = SDL_FLIP_HORIZONTAL
    }

    func runRight() {
        self.id = "robot_run"
        self.count = 8
        self.velocity = Vector(x: 60, y: 0)
        self.flip = SDL_FLIP_NONE
    }

    func update(time: Double) {
        if self.lastTime == 0 {
            self.lastTime = time
        }
        self.index = (Int(time * 10) + self.offset) % self.count
        self.position += self.velocity * (time - self.lastTime)
        self.lastTime = time
    }

    func draw(renderStates: RenderStates) {
        var rect = SDL_Rect(x: Int32(self.position.x), y: Int32(self.position.y),
            w: Int32(self.width), h: Int32(self.height))
        if let image = ImageManager.imageManager.getImage(id: self.id, index: self.index) {
            image.draw(src: nil, dst: &rect, angle: 0, center: nil, flip: self.flip)
        }
    }
}