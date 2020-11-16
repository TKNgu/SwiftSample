import SwiftSDL2
import SDL2GLFX

func LogoSmash() throws {

    let window = try Window(name: "Test", rect: Rect(x: SDL_WINDOWPOS.CENTERED.rawValue, y: SDL_WINDOWPOS.CENTERED.rawValue,
        w: 640, h: 480), flag: SDL_WINDOW_SHOWN)
    var running = true
    InputHandler.inputHandler.quit = {
        running = false
    }

    var ddpi: Float = 0
    var hdpi: Float = 0
    var vdpi: Float = 0
    SDL_GetDisplayDPI(0, &ddpi, &hdpi, &vdpi)
    print("DPI \(ddpi) \(hdpi) \(vdpi)")
    SDL_GetDisplayDPI(1, &ddpi, &hdpi, &vdpi)
    print("DPI \(ddpi) \(hdpi) \(vdpi)")


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
	63,15,-61,-16,0,31,-127,-127,-8,31,-1,-127,-8,31,-128,7,-128,0,0
    ]

    var space = cpSpaceNew()
    cpSpaceSetIterations(space, 1)
    cpSpaceUseSpatialHash(space, 2.0, 10000)
    
    var bodyCount = 0
    var body: UnsafeMutablePointer<cpBody>? = nil
    var shape: UnsafeMutablePointer<cpShape>? = nil

    let image_width = 188;
    let image_height = 35;
    let image_row_length = 24;

    for y in 0..<image_height {
        for x in 0..<image_height {
            if ((image_bitmap[(x>>3) + y*image_row_length]>>(~x&0x7)) & 1) == 0 {
                continue
            }
            var x_jitter = cpFloat(0.05 * cpFloat(rand()) / cpFloat(RAND_MAX))
            var y_jitter = cpFloat(0.05 * cpFloat(rand()) / cpFloat(RAND_MAX))

            body = cpBodyNew(1.0, cpFloat(Double.infinity))
            cpBodySetPosition(body, cpv(cpFloat(x), cpFloat(y)))
            shape = cpCircleShapeNew(body, 0.95, cpvzero)
            cpShapeSetElasticity(shape, 0.0)
            cpShapeSetFriction(shape, 0.0)
            cpSpaceAddBody(space, body)
            cpSpaceAddShape(space, shape)

            bodyCount += 1
            // (cpFloat)rand()/(cpFloat)RAND_MAX
        }
    }

//   // cpVect is a 2D vector and cpv() is a shortcut for initializing them.
//   var gravity = cpv(0, -1);
  
//   // Create an empty space.
//   var space = cpSpaceNew();
//   cpSpaceSetGravity(space, gravity);
  
//   // Add a static line segment shape for the ground.
//   // We'll make it slightly tilted so the ball will roll off.
//   // We attach it to a static body to tell Chipmunk it shouldn't be movable.
//   var ground = cpSegmentShapeNew(cpSpaceGetStaticBody(space), cpv(-20, 5), cpv(20, -5), 0);
//   cpShapeSetFriction(ground, 1);
//   cpSpaceAddShape(space, ground);
  
//   // Now let's make a ball that falls onto the line and rolls off.
//   // First we need to make a cpBody to hold the physical properties of the object.
//   // These include the mass, position, velocity, angle, etc. of the object.
//   // Then we attach collision shapes to the cpBody to give it a size and shape.
  
//   var radius = cpFloat(5)
//   var mass = cpFloat(1)
  
//   // The moment of inertia is like mass for rotation
//   // Use the cpMomentFor*() functions to help you approximate it.
//   var moment = cpMomentForCircle(mass, 0, radius, cpvzero);
  
//   // The cpSpaceAdd*() functions return the thing that you are adding.
//   // It's convenient to create and add an object in one line.
//   var ballBody = cpSpaceAddBody(space, cpBodyNew(mass, moment));
//   cpBodySetPosition(ballBody, cpv(0, 15));
  
//   // Now we create the collision shape for the ball.
//   // You can create multiple collision shapes that point to the same body.
//   // They will all be attached to the body and move around to follow it.
//   var ballShape = cpSpaceAddShape(space, cpCircleShapeNew(ballBody, radius, cpvzero));
//   cpShapeSetFriction(ballShape, 0.7);
  
//   // Now that it's all set up, we simulate all the objects in the space by
//   // stepping forward through time in small increments called steps.
//   // It is *highly* recommended to use a fixed size time step.
//     // var timeStep = cpFloat(1.0/60.0)
//     // var time = cpFloat(0)
//     // while time < 2 {

//     // var pos = cpBodyGetPosition(ballBody);
//     // var vel = cpBodyGetVelocity(ballBody);
//     // print("Time is \(time). ballBody is at (\(pos.x), \(pos.y)). It's velocity is (\(vel.x), \(vel.y))")
    
//     // cpSpaceStep(space, timeStep);

//     //   time += timeStep
//     // }

    var startTime = SDL_GetTicks()
    let frameTime = Uint32(1000 / 25)
//     var timeStep = cpFloat(1.0 / 25.0)
//     var time = cpFloat(0)
    while running {
        InputHandler.inputHandler.update()

        // var pos = cpBodyGetPosition(ballBody);
        // var vel = cpBodyGetVelocity(ballBody);
        // // print("Time is \(time). ballBody is at (\(pos.x), \(pos.y)). It's velocity is (\(vel.x), \(vel.y))")
        
        // cpSpaceStep(space, timeStep);

        // time += timeStep

        SDL_SetRenderDrawColor(window.screenTexture,
            0, 0, 0, 255)
        SDL_RenderClear(window.screenTexture)

        // SDL_SetRenderDrawColor(window.screenTexture,
        //     255, 255, 255, 255)
        // window.drawLine(start: Point(x: 100 - 200, y: 240 - 50), end: Point(x: 100 + 200, y: 240 + 50))
        // window.drawPoint(point: Point(x: 100 + Int32(pos.x * 10), y: 240 - Int32(pos.y * 10)))
        rectangleColor(window.screenTexture, 10, 10, 100, 100, 0xffffffff)
        // int rectangleColor(SDL_Renderer * renderer, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint32 color)

        SDL_RenderPresent(window.screenTexture)
        let runTime = SDL_GetTicks() - startTime
        if frameTime > runTime {
            SDL_Delay(frameTime - runTime)
        }
    }

  //   for(cpFloat time = 0; time < 2; time += timeStep){
  //   var pos = cpBodyGetPosition(ballBody);
  //   var vel = cpBodyGetVelocity(ballBody);
  //   printf(
  //     "Time is %5.2f. ballBody is at (%5.2f, %5.2f). It's velocity is (%5.2f, %5.2f)\n",
  //     time, pos.x, pos.y, vel.x, vel.y
  //   );
    
  //   cpSpaceStep(space, timeStep);
  // }
  
  // Clean up our objects and exit!
//   cpShapeFree(ballShape);
//   cpBodyFree(ballBody);
//   cpShapeFree(ground);
//   cpSpaceFree(space);
}

func ShapeFreeWrap(space: UnsafeMutablePointer<cpSpace>,
    shape: UnsafeMutablePointer<cpShape>, unused: UnsafeMutableRawPointer) {
        cpSpaceRemoveShape(space, shape)
        cpShapeFree(shape)
}

func ConstraintFreeWrap