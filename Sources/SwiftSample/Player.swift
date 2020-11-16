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
    var body: UnsafeMutablePointer<cpBody>
    var shape: UnsafeMutablePointer<cpShape>

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
        id: String, space: UnsafeMutablePointer<cpSpace>) {
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

        var radius = cpFloat(5)
        var mass = cpFloat(60)
        var moment = cpMomentForCircle(mass, 0, radius, cpvzero)
        self.body = cpBodyNew(mass, moment)
        self.body = cpSpaceAddBody(space, self.body)
        cpBodySetPosition(self.body, cpv(x, 400 - y - self.height))
        self.shape = cpSpaceAddShape(space, cpBoxShapeNew(self.body, self.width, self.height, 1));
        cpShapeSetFriction(self.shape, 1);
    }

    deinit {
        cpShapeFree(self.shape)
        cpBodyFree(self.body);
    }

    func idle() {
        var pos = cpBodyGetPosition(self.body)
        // if pos.y <= 5.5 {
        //     return
        // }
        self.id = "robot_idle"
        self.velocity = Vector(x: 0, y: 0)
        cpBodySetForce(self.body, cpVect(x: self.velocity.x, y: self.velocity.y))
    }

    func runJump() {
        var pos = cpBodyGetPosition(self.body)
        // if pos.y > 50.5 {
        //     return
        // }
        self.id = "robot_jump"
        self.count = 10
        self.velocity.y = 500
        cpBodySetForce(self.body, cpVect(x: self.velocity.x, y: self.velocity.y))
    }

    func runLeft() {
        var pos = cpBodyGetPosition(self.body)
        // if pos.y > 50.5 {
        //     return
        // }
        self.id = "robot_run"
        self.count = 8
        self.velocity.x = -500
        cpBodySetForce(self.body, cpVect(x: self.velocity.x, y: self.velocity.y))
        self.flip = SDL_FLIP_HORIZONTAL
    }

    func runRight() {
        var pos = cpBodyGetPosition(self.body)
        // if pos.y > 50.5 {
        //     return
        // }
        self.id = "robot_run"
        self.count = 8
        self.velocity.x = 500
        cpBodySetForce(self.body, cpVect(x: self.velocity.x, y: self.velocity.y))
        self.flip = SDL_FLIP_NONE
    }

    func update(time: Double) {
        var pos = cpBodyGetPosition(self.body);
        if self.lastTime == 0 {
            self.lastTime = time
        }
        self.index = (Int(time * 10) + self.offset) % self.count
        // self.position += self.velocity * (time - self.lastTime)
        self.position = Vector(x: pos.x, y: 400 - pos.y - self.height / 2 + 10)
        // print("\(self.position.x) \(pos.y)")
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