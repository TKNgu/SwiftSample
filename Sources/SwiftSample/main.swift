import SwiftSDL2
import SDL2GLFX

func main() throws {
    let game = try Game(title: "Hello",
        xpos: SDL_WINDOWPOS.CENTERED.rawValue, ypos: SDL_WINDOWPOS.CENTERED.rawValue,
        height: Uint32(480), width: Uint32(640),
        flags: SDL_WINDOW_SHOWN.rawValue)
    var startTime: Uint32
    let frameTime = Uint32(1000 / 25)
    while game.running {
        startTime = SDL_GetTicks()
        game.handleEvents()
        game.update()
        game.render()
        let runTime = SDL_GetTicks() - startTime
        if frameTime > runTime {
            SDL_Delay(frameTime - runTime)
        }
    }
}

// try main()

func chip() throws {

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

  // cpVect is a 2D vector and cpv() is a shortcut for initializing them.
  var gravity = cpv(0, -1);
  
  // Create an empty space.
  var space = cpSpaceNew();
  cpSpaceSetGravity(space, gravity);
  
  // Add a static line segment shape for the ground.
  // We'll make it slightly tilted so the ball will roll off.
  // We attach it to a static body to tell Chipmunk it shouldn't be movable.
  var ground = cpSegmentShapeNew(cpSpaceGetStaticBody(space), cpv(-20, 5), cpv(20, -5), 0);
  cpShapeSetFriction(ground, 1);
  cpSpaceAddShape(space, ground);
  
  // Now let's make a ball that falls onto the line and rolls off.
  // First we need to make a cpBody to hold the physical properties of the object.
  // These include the mass, position, velocity, angle, etc. of the object.
  // Then we attach collision shapes to the cpBody to give it a size and shape.
  
  var radius = cpFloat(5)
  var mass = cpFloat(1)
  
  // The moment of inertia is like mass for rotation
  // Use the cpMomentFor*() functions to help you approximate it.
  var moment = cpMomentForCircle(mass, 0, radius, cpvzero);
  
  // The cpSpaceAdd*() functions return the thing that you are adding.
  // It's convenient to create and add an object in one line.
  var ballBody = cpSpaceAddBody(space, cpBodyNew(mass, moment));
  cpBodySetPosition(ballBody, cpv(0, 15));
  
  // Now we create the collision shape for the ball.
  // You can create multiple collision shapes that point to the same body.
  // They will all be attached to the body and move around to follow it.
  var ballShape = cpSpaceAddShape(space, cpCircleShapeNew(ballBody, radius, cpvzero));
  cpShapeSetFriction(ballShape, 0.7);
  
  // Now that it's all set up, we simulate all the objects in the space by
  // stepping forward through time in small increments called steps.
  // It is *highly* recommended to use a fixed size time step.
    // var timeStep = cpFloat(1.0/60.0)
    // var time = cpFloat(0)
    // while time < 2 {

    // var pos = cpBodyGetPosition(ballBody);
    // var vel = cpBodyGetVelocity(ballBody);
    // print("Time is \(time). ballBody is at (\(pos.x), \(pos.y)). It's velocity is (\(vel.x), \(vel.y))")
    
    // cpSpaceStep(space, timeStep);

    //   time += timeStep
    // }

    var startTime = SDL_GetTicks()
    let frameTime = Uint32(1000 / 25)
    var timeStep = cpFloat(1.0 / 25.0)
    var time = cpFloat(0)
    while running {
        InputHandler.inputHandler.update()

        var pos = cpBodyGetPosition(ballBody);
        var vel = cpBodyGetVelocity(ballBody);
        // print("Time is \(time). ballBody is at (\(pos.x), \(pos.y)). It's velocity is (\(vel.x), \(vel.y))")
        
        cpSpaceStep(space, timeStep);

        time += timeStep

        SDL_SetRenderDrawColor(window.screenTexture,
            0, 0, 0, 255)
        SDL_RenderClear(window.screenTexture)

        SDL_SetRenderDrawColor(window.screenTexture,
            255, 255, 255, 255)
        window.drawLine(start: Point(x: 100 - 200, y: 240 - 50), end: Point(x: 100 + 200, y: 240 + 50))
        window.drawPoint(point: Point(x: 100 + Int32(pos.x * 10), y: 240 - Int32(pos.y * 10)))
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
  cpShapeFree(ballShape);
  cpBodyFree(ballBody);
  cpShapeFree(ground);
  cpSpaceFree(space);
}

try LogoSmash()