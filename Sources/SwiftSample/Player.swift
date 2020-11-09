class Player: GameObject {
    override init(x: Double, y: Double,
        width: Double, height: Double,
        id: String) {
        super.init(x: x, y: y, width: width, height: height, id: id)
    }

    override func update() {
        self.index += 1
        self.index = self.index % 10
    }

    override func clean() {
        print("Clean")
    }
}