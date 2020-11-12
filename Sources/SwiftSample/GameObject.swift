import SwiftSDL2

class GameObject {
    var position: Vector
    var velocity: Vector
    var width: Double = 0
    var height: Double = 0
    var id: String
    var index: Int

    init(x: Double, y: Double,
        width: Double, height: Double,
        id: String) {
        self.position = Vector(x: x, y: y)
        self.velocity = Vector()
        self.width = width
        self.height = height
        self.id = id
        self.index = 0   
    }

    func draw() {
        var rect = SDL_Rect(x: Int32(self.position.x), y: Int32(self.position.y),
            w: Int32(self.width), h: Int32(self.height))
        if let image = ImageManager.imageManager.getImage(id: self.id, index: self.index) {
            image.draw(src: nil, dst: &rect, angle: 0, center: nil, flip: SDL_FLIP_NONE)
        }
    }

    func update(time: Double) {
        _ = self.position += self.velocity * time
    }

    func clean() {
        //TODO
    }
}