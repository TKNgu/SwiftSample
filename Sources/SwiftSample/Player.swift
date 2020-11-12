import SwiftSDL2

class Player: GameObject {
    var offset: Int
    override init(x: Double, y: Double,
        width: Double, height: Double,
        id: String) {
        self.offset = Int.random(in: 0..<10)
        super.init(x: x, y: y, width: width, height: height, id: id)
    }

    override func update(time: Double) {
        self.velocity = Vector(x: 1, y: 1)
        super.index = (Int(time * 20) + self.offset) % 10
        super.update(time: time)
    }

    override func clean() {
        print("Clean")
    }
}