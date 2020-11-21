import SwiftSDL2
import SDL2GLFX

final class LogoSmash: DemoCP {
    let image_bitmap = [
        15,-16,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,-64,15,63,-32,-2,0,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,0,31,-64,15,127,-125,-1,-128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
        0,0,0,127,-64,15,127,15,-1,-64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,-64,15,-2,
        31,-1,-64,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-1,-64,0,-4,63,-1,-32,0,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,1,-1,-64,15,-8,127,-1,-32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
        1,-1,-64,0,-8,-15,-1,-32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-31,-1,-64,15,-8,-32,
        -1,-32,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7,-15,-1,-64,9,-15,-32,-1,-32,0,0,0,0,0,
        0,0,0,0,0,0,0,0,0,0,31,-15,-1,-64,0,-15,-32,-1,-32,0,0,0,0,0,0,0,0,0,0,0,0,0,
        0,0,63,-7,-1,-64,9,-29,-32,127,-61,-16,63,15,-61,-1,-8,31,-16,15,-8,126,7,-31,
        -8,31,-65,-7,-1,-64,9,-29,-32,0,7,-8,127,-97,-25,-1,-2,63,-8,31,-4,-1,15,-13,
        -4,63,-1,-3,-1,-64,9,-29,-32,0,7,-8,127,-97,-25,-1,-2,63,-8,31,-4,-1,15,-13,
        -2,63,-1,-3,-1,-64,9,-29,-32,0,7,-8,127,-97,-25,-1,-1,63,-4,63,-4,-1,15,-13,
        -2,63,-33,-1,-1,-32,9,-25,-32,0,7,-8,127,-97,-25,-1,-1,63,-4,63,-4,-1,15,-13,
        -1,63,-33,-1,-1,-16,9,-25,-32,0,7,-8,127,-97,-25,-1,-1,63,-4,63,-4,-1,15,-13,
        -1,63,-49,-1,-1,-8,9,-57,-32,0,7,-8,127,-97,-25,-8,-1,63,-2,127,-4,-1,15,-13,
        -1,-65,-49,-1,-1,-4,9,-57,-32,0,7,-8,127,-97,-25,-8,-1,63,-2,127,-4,-1,15,-13,
        -1,-65,-57,-1,-1,-2,9,-57,-32,0,7,-8,127,-97,-25,-8,-1,63,-2,127,-4,-1,15,-13,
        -1,-1,-57,-1,-1,-1,9,-57,-32,0,7,-1,-1,-97,-25,-8,-1,63,-1,-1,-4,-1,15,-13,-1,
        -1,-61,-1,-1,-1,-119,-57,-32,0,7,-1,-1,-97,-25,-8,-1,63,-1,-1,-4,-1,15,-13,-1,
        -1,-61,-1,-1,-1,-55,-49,-32,0,7,-1,-1,-97,-25,-8,-1,63,-1,-1,-4,-1,15,-13,-1,
        -1,-63,-1,-1,-1,-23,-49,-32,127,-57,-1,-1,-97,-25,-1,-1,63,-1,-1,-4,-1,15,-13,
        -1,-1,-63,-1,-1,-1,-16,-49,-32,-1,-25,-1,-1,-97,-25,-1,-1,63,-33,-5,-4,-1,15,
        -13,-1,-1,-64,-1,-9,-1,-7,-49,-32,-1,-25,-8,127,-97,-25,-1,-1,63,-33,-5,-4,-1,
        15,-13,-1,-1,-64,-1,-13,-1,-32,-49,-32,-1,-25,-8,127,-97,-25,-1,-2,63,-49,-13,
        -4,-1,15,-13,-1,-1,-64,127,-7,-1,-119,-17,-15,-1,-25,-8,127,-97,-25,-1,-2,63,
        -49,-13,-4,-1,15,-13,-3,-1,-64,127,-8,-2,15,-17,-1,-1,-25,-8,127,-97,-25,-1,
        -8,63,-49,-13,-4,-1,15,-13,-3,-1,-64,63,-4,120,0,-17,-1,-1,-25,-8,127,-97,-25,
        -8,0,63,-57,-29,-4,-1,15,-13,-4,-1,-64,63,-4,0,15,-17,-1,-1,-25,-8,127,-97,
        -25,-8,0,63,-57,-29,-4,-1,-1,-13,-4,-1,-64,31,-2,0,0,103,-1,-1,-57,-8,127,-97,
        -25,-8,0,63,-57,-29,-4,-1,-1,-13,-4,127,-64,31,-2,0,15,103,-1,-1,-57,-8,127,
        -97,-25,-8,0,63,-61,-61,-4,127,-1,-29,-4,127,-64,15,-8,0,0,55,-1,-1,-121,-8,
        127,-97,-25,-8,0,63,-61,-61,-4,127,-1,-29,-4,63,-64,15,-32,0,0,23,-1,-2,3,-16,
        63,15,-61,-16,0,31,-127,-127,-8,31,-1,-127,-8,31,-128,7,-128,0,0]

    override init(screenTexture: OpaquePointer?) {
        super.init(screenTexture: screenTexture)
        cpSpaceSetIterations(super.space, 1)
        cpSpaceUseSpatialHash(super.space, 2.0, 10000)

        var ddpi: Float = 0
        var hdpi: Float = 0
        var vdpi: Float = 0
    
        var body: UnsafeMutablePointer<cpBody>? = nil
        var shape: UnsafeMutablePointer<cpShape>? = nil
        let image_width = 188;
        let image_height = 35;
        let image_row_length = 24;
        for y in 0..<image_height {
            for x in 0..<image_width {
                if ((image_bitmap[(x>>3) + y*image_row_length]>>(~x&0x7)) & 1) == 0 {
                    continue
                }
                var x_jitter = Double(x) + 0.05 - 0.1 * Double(rand() / RAND_MAX)
                var y_jitter = Double(y) + 0.05 - 0.1 * Double(rand() / RAND_MAX)
                body = cpBodyNew(1.0, Double.infinity)
                cpBodySetPosition(body, cpv(cpFloat(x_jitter), cpFloat(y_jitter)))
                shape = cpCircleShapeNew(body, 0.4, cpvzero)
                cpShapeSetElasticity(shape, 0.0)
                cpShapeSetFriction(shape, 0.0)
                cpSpaceAddBody(super.space, body)
                cpSpaceAddShape(super.space, shape)
            }
        }
        body = cpSpaceAddBody(space, cpBodyNew(1e9, Double.infinity))
        cpBodySetPosition(body, cpv(-1, 15))
        cpBodySetVelocity(body, cpv(4, 0))
        shape = cpSpaceAddShape(space, cpCircleShapeNew(body, 2.0, cpvzero))
        cpShapeSetElasticity(shape, 0.0)
        cpShapeSetFriction(shape, 0.0)
        var GRABBABLE_MASK_BIT = UInt32(1<<31)
        var NOT_GRABBABLE_FILTER = cpShapeFilter(
            group: CP_NO_GROUP,
            categories: ~GRABBABLE_MASK_BIT,
            mask: ~GRABBABLE_MASK_BIT
        )
	    cpShapeSetFilter(shape, NOT_GRABBABLE_FILTER);
    }
    override func drawBody() {
        cpSpaceEachBody(super.space, DrawDot, nil);
    }
}

func DrawDot(body: UnsafeMutablePointer<cpBody>?, unused: UnsafeMutableRawPointer?) {
    let pos = cpBodyGetPosition(body!)
    let vec = cpBodyGetVelocity(body!)
    var x = Int16.max - 10 
    if Int(pos.x * 10) < Int16.max - 10 {
        x = Int16(Int(pos.x * 10))
    } else {
        cpBodySetPosition(body, cpv(0, pos.y))
    }
    var y = Int16.max - 10
    if Int(pos.y * 10 + 300) < Int16.max - 10 {
        y = Int16(Int(pos.y * 10 + 300))
    } else {
        cpBodySetPosition(body, cpv(pos.x, 0))
    }
    filledCircleColor(glScreenTexture, x, y, Int16(1), 0xffffffff)
}