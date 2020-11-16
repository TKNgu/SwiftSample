import SwiftSDL2

class Map: GameObject {
    var start: cpVect
    var end: cpVect
    var screenTexture: OpaquePointer?
    var ground: UnsafeMutablePointer<cpShape>

    init(screenTexture: OpaquePointer?, space: UnsafeMutablePointer<cpSpace>) {
        self.start = cpVect(x: 0, y: 0)
        self.end = cpVect(x: 640, y: 0)
        self.screenTexture = screenTexture

        self.ground = cpSegmentShapeNew(cpSpaceGetStaticBody(space), self.start, self.end, 0)
        cpShapeSetFriction(self.ground, 1)
        cpSpaceAddShape(space, self.ground)
    }

    deinit {
        cpShapeFree(self.ground)
    }

    // func addSpace(space: UnsafeMutablePointer<cpSpace>) {
    //     self.ground = cpSegmentShapeNew(cpSpaceGetStaticBody(space), self.start, self.end, 0)
    //     cpShapeSetFriction(self.ground, 1)
    //     cpSpaceAddShape(space, self.ground)
    // }

    func draw(renderStates: RenderStates) {
        var start = SDL_Point(x: Int32(self.start.x), y: Int32(400 - self.start.y))
        var end = SDL_Point(x: Int32(self.end.x), y: Int32(400 - self.end.y))
        SDL_SetRenderDrawColor(self.screenTexture, 255, 255, 255, 255)
        SDL_RenderDrawLine(self.screenTexture, start.x, start.y, end.x, end.y)
    }

    func update(time: Double) {

    }
}