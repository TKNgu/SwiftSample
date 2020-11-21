import SwiftSDL2
import SDL2GLFX
import LibC

final class PyramidStack: DemoCP {
    override init(screenTexture: OpaquePointer?) {
        glScreenTexture = screenTexture
        super.init(screenTexture: screenTexture)
        cpSpaceSetIterations(super.space, 30)
        cpSpaceSetGravity(super.space, cpv(0, -100))
        cpSpaceSetCollisionSlop(space, 0.5)

        var GRABBABLE_MASK_BIT = UInt32(1<<31)
        var NOT_GRABBABLE_FILTER = cpShapeFilter(
            group: CP_NO_GROUP,
            categories: ~GRABBABLE_MASK_BIT,
            mask: ~GRABBABLE_MASK_BIT
        )
        var staticBody = cpSpaceGetStaticBody(super.space)

        var shape = cpSpaceAddShape(super.space,
            cpSegmentShapeNew(staticBody, cpv(-320, -240), cpv(-320, 240),
            0.0))
        cpShapeSetElasticity(shape, 1.0)
        cpShapeSetFriction(shape, 1.0)
        cpShapeSetFilter(shape, NOT_GRABBABLE_FILTER)

        shape = cpSpaceAddShape(super.space,
            cpSegmentShapeNew(staticBody, cpv(320, -240), cpv(320, 240),
            0.0))
        cpShapeSetElasticity(shape, 1.0)
        cpShapeSetFriction(shape, 1.0)
        cpShapeSetFilter(shape, NOT_GRABBABLE_FILTER)

        shape = cpSpaceAddShape(super.space,
            cpSegmentShapeNew(staticBody, cpv(-320, -240), cpv(320, -240),
            0.0))
        cpShapeSetElasticity(shape, 1.0)
        cpShapeSetFriction(shape, 1.0)
        cpShapeSetFilter(shape, NOT_GRABBABLE_FILTER)

        for i in 0..<14 {
            for j in 0..<(i+1) {
                var body = cpSpaceAddBody(super.space,
                    cpBodyNew(1.0, cpMomentForBox(1.0, 30.0, 30.0)))
                cpBodySetPosition(body, cpv(cpFloat(j * 32 - i * 16), cpFloat(300 - i * 32)))
                var shape = cpSpaceAddShape(super.space, cpBoxShapeNew(body, 30.0, 30.0, 0.5))
                cpShapeSetElasticity(shape, 0.0)
                cpShapeSetFriction(shape, 0.8)
            }
        }

        var radius = 15.0
        var body = cpSpaceAddBody(super.space, cpBodyNew(10.0, cpMomentForCircle(10.0, 0.0, radius, cpvzero)))
        cpBodySetPosition(body, cpv(0, -240 + radius + 5))

        shape = cpSpaceAddShape(super.space, cpCircleShapeNew(body, radius, cpvzero))
        cpShapeSetElasticity(shape, 0.0)
        cpShapeSetFriction(shape, 0.9)
    }

    override func drawBody() {
        var drawOptions = cpSpaceDebugDrawOptions(
            drawCircle: drawCircle,
            drawSegment: drawSegment,
            drawFatSegment: drawFatSegment,
            drawPolygon: drawPolygon,
            drawDot: drawDot,
            // flags: cpSpaceDebugDrawFlags(CP_SPACE_DEBUG_DRAW_SHAPES),
            flags: (cpSpaceDebugDrawFlags)(CP_SPACE_DEBUG_DRAW_SHAPES.rawValue | CP_SPACE_DEBUG_DRAW_CONSTRAINTS.rawValue | CP_SPACE_DEBUG_DRAW_COLLISION_POINTS.rawValue),
            shapeOutlineColor: cpSpaceDebugColor(r: 0xff, g: 0xff, b: 0xff, a: 0xff),
            colorForShape: ColorForShape,
            constraintColor: cpSpaceDebugColor(r: 0xff, g: 0xff, b: 0xff, a: 0xff),
            collisionPointColor: cpSpaceDebugColor(r: 0xff, g: 0xff, b: 0xff, a: 0xff),
            data: nil
        )
	    cpSpaceDebugDraw(space, &drawOptions);
    }
}

func drawCircle(pos: cpVect, angle: cpFloat, radius: cpFloat, outlineColor: cpSpaceDebugColor, fillColor: cpSpaceDebugColor, data: cpDataPointer?) {
    var tmp = UInt32(outlineColor.r) << 24 | UInt32(outlineColor.g) << 16 | UInt32(outlineColor.b) << 8 | UInt32(outlineColor.a)
    tmp = 0xff0000ff
    filledCircleColor(glScreenTexture, Sint16(pos.x + 640), Sint16(480 - pos.y), Int16(radius), tmp.byteSwapped)
}

func drawSegment(a: cpVect, b: cpVect, color: cpSpaceDebugColor, data: cpDataPointer?) {
    var tmp = UInt32(color.r) << 24 | UInt32(color.g) << 16 | UInt32(color.b) << 8 | UInt32(color.a)
    tmp = 0x00ff00ff
    thickLineColor(glScreenTexture, Sint16(a.x + 640), Sint16(480 - a.y), Sint16(b.x + 640), Sint16(480 - b.y), 10, tmp.byteSwapped)
}

func drawFatSegment(a: cpVect, b: cpVect, radius: cpFloat, outlineColor: cpSpaceDebugColor, fillColor: cpSpaceDebugColor, data: cpDataPointer?) {
    var tmp = UInt32(outlineColor.r) << 24 | UInt32(outlineColor.g) << 16 | UInt32(outlineColor.b) << 8 | UInt32(outlineColor.a)
    tmp = 0x0000ffff
    thickLineColor(glScreenTexture, Sint16(a.x + 640), Sint16(480 - a.y), Sint16(b.x + 640), Sint16(480 - b.y), 4, tmp.byteSwapped)
}

func drawPolygon(count: Int32, verts: UnsafePointer<cpVect>?, radius: Double, outlineColor: cpSpaceDebugColor, fillColor: cpSpaceDebugColor, data: cpDataPointer?) {
    var tmp = UInt32(outlineColor.r) << 24 | UInt32(outlineColor.g) << 16 | UInt32(outlineColor.b) << 8 | UInt32(outlineColor.a)
    tmp = 0xff00ffff
    if let value = verts {
        var start = value[0]
        for index in 0..<count {
            var end = value[Int(index)]
            thickLineColor(glScreenTexture, Sint16(start.x + 640), Sint16(480 - start.y), Sint16(end.x + 640), Sint16(480 - end.y), 4, tmp.byteSwapped)
            start = end
        }
        var end = value[0]
        thickLineColor(glScreenTexture, Sint16(start.x + 640), Sint16(480 - start.y), Sint16(end.x + 640), Sint16(480 - end.y), 4, tmp.byteSwapped)
    }
}

func drawDot(size: cpFloat, pos: cpVect, color: cpSpaceDebugColor, data: cpDataPointer?) {
    var tmp = UInt32(color.r) << 24  + UInt32(color.g) << 16 + UInt32(color.b) << 8 + UInt32(color.a)
    tmp = 0x00ffffff
    circleColor(glScreenTexture, Sint16(pos.x + 640), Sint16(pos.y + 480), Sint16(size), tmp.byteSwapped)
}

var Colors = [
	cpSpaceDebugColor(r: 0xb5, g: 0x89, b: 0x00, a: 0xff),
	cpSpaceDebugColor(r: 0xcb, g: 0x4b, b: 0x16, a: 0xff),
	cpSpaceDebugColor(r: 0xdc, g: 0x32, b: 0x2f, a: 0xff),
	cpSpaceDebugColor(r: 0xd3, g: 0x36, b: 0x82, a: 0xff),
	cpSpaceDebugColor(r: 0x6c, g: 0x71, b: 0xc4, a: 0xff),
	cpSpaceDebugColor(r: 0x26, g: 0x8b, b: 0xd2, a: 0xff),
	cpSpaceDebugColor(r: 0x2a, g: 0xa1, b: 0x98, a: 0xff),
	cpSpaceDebugColor(r: 0x85, g: 0x99, b: 0x00, a: 0xff)]

func colorForShape(shape: UnsafeMutablePointer<cpShape>?, data: cpDataPointer?) -> cpSpaceDebugColor {
    return cpSpaceDebugColor(r: 0xff, g: 0xff, b: 0xff, a: 0xff)
    // if(cpShapeGetSensor(shape) != 0){
    //     print("Sensor")
	// 	return cpSpaceDebugColor(r: 0xff, g: 0x00, b: 0x00, a: 0xff)
	// } else {
    //     var body = cpShapeGetBody(shape!)
    //     if cpBodyIsSleeping(body) != 0 {
    //         print("Sleep")
    //         return cpSpaceDebugColor(r: 0x00, g: 0xff, b: 0x00, a: 0xff)
    //     } else if(body!.pointee.sleeping.idleTime > shape!.pointee.space!.pointee.sleepTimeThreshold) {
    //         print("State")
    //         return cpSpaceDebugColor(r: 0x00, g: 0x00, b: 0xff, a: 0xff)
    //     } else {
    //         var val = UInt32(shape!.pointee.hashid)
    //         print("Not")
    //         val = (val+0x7ed55d16) + (val<<12);
	// 		// val = (val^0xc761c23c) ^ (val>>19);
	// 		// val = (val+0x165667b1) + (val<<5);
	// 		// val = (val+0xd3a2646c) ^ (val<<9);
	// 		// val = (val+0xfd7046c5) + (val<<3);
	// 		// val = (val^0xb55a4f09) ^ (val>>16);
    //         return Colors[3]
    //     }
    // }
}