import SwiftSDL2

var glScreenTexture: OpaquePointer?

class DemoCP {
    var screenTexture: OpaquePointer?
    var space: UnsafeMutablePointer<cpSpace>

    init(screenTexture: OpaquePointer?) {
        glScreenTexture = screenTexture
        self.screenTexture = screenTexture
        self.space = cpSpaceNew()
    }

    func update(timeStep: cpFloat) {
        cpSpaceStep(self.space, timeStep);
    }

    func draw() {
        SDL_SetRenderDrawColor(self.screenTexture, 0, 0, 0, 255)
        SDL_RenderClear(self.screenTexture)
        drawBody()
        SDL_RenderPresent(self.screenTexture)
    }

    func drawBody() {

    }

    deinit {
        ChipmunkDemoFreeSpaceChildren(space: self.space)
        cpSpaceFree(self.space)
    }
}

func ShapeFreeWrap(space: UnsafeMutablePointer<cpSpace>?,
    raw: UnsafeMutableRawPointer?, unused: UnsafeMutableRawPointer?) {
        let shape = raw!.bindMemory(to: cpShape.self, capacity: 1)
        cpSpaceRemoveShape(space, shape)
        cpShapeFree(shape)
}

func ConstraintFreeWrap(space: UnsafeMutablePointer<cpSpace>?,
    raw: UnsafeMutableRawPointer?, unused: UnsafeMutableRawPointer?) {
        let constraint = raw!.bindMemory(to: cpConstraint.self, capacity: 1)
        cpSpaceRemoveConstraint(space, constraint)
        cpConstraintFree(constraint)
}

func BodyFreeWrap(space: UnsafeMutablePointer<cpSpace>?,
    raw: UnsafeMutableRawPointer?, unused: UnsafeMutableRawPointer?) {
        let body = raw!.bindMemory(to: cpBody.self, capacity: 1)
        cpSpaceRemoveBody(space, body)
        cpBodyFree(body)
}

func PostShapeFree(shape: UnsafeMutablePointer<cpShape>?, raw: UnsafeMutableRawPointer?) {
    let space = raw!.bindMemory(to: cpSpace.self, capacity: 1)
    cpSpaceAddPostStepCallback(space, ShapeFreeWrap, shape, nil)
}

func PostConstraintFree(constraint: UnsafeMutablePointer<cpConstraint>?, raw: UnsafeMutableRawPointer?) {
    let space = raw!.bindMemory(to: cpSpace.self, capacity: 1)
    cpSpaceAddPostStepCallback(space, ConstraintFreeWrap, constraint, nil)
}

func PostBodyFree(body: UnsafeMutablePointer<cpBody>?, raw: UnsafeMutableRawPointer?) {
    let space = raw!.bindMemory(to: cpSpace.self, capacity: 1)
    cpSpaceAddPostStepCallback(space, BodyFreeWrap, body, nil)
}

func ChipmunkDemoFreeSpaceChildren(space: UnsafeMutablePointer<cpSpace>) {
    cpSpaceEachShape(space, PostShapeFree, space)
    cpSpaceEachConstraint(space, PostConstraintFree, space)
    cpSpaceEachBody(space, PostBodyFree, space)
}