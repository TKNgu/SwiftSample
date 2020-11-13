import SwiftSDL2

class Map: GameObject {
    var start: cpVect
    var end: cpVect
    var screenTexture: OpaquePointer?

    init(screenTexture: OpaquePointer?) {
        self.start = cpVect(x: 0, y: 0)
        self.end = cpVect(x: 640, y: 0)
        self.screenTexture = screenTexture
    }

    func addSpace(space: UnsafeMutablePointer<cpSpace>) {
        var ground = cpSegmentShapeNew(cpSpaceGetStaticBody(space), self.start, self.end, 0)
        cpShapeSetFriction(ground, 1)
        cpSpaceAddShape(space, ground)
    }

    func draw(renderStates: RenderStates) {
        var start = SDL_Point(x: Int32(self.start.x), y: Int32(400 - self.start.y))
        var end = SDL_Point(x: Int32(self.end.x), y: Int32(400 - self.end.y))
        SDL_SetRenderDrawColor(self.screenTexture, 255, 255, 255, 255)
        SDL_RenderDrawLine(self.screenTexture, start.x, start.y, end.x, end.y)
    }

    func update(time: Double) {

    }
}