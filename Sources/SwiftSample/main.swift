import SwiftSDL2
import SDL2GLFX
import LibC

let TIME_FRAME = UInt32(40)

func MainLoop() throws {
    let game: Game
    game = try Game(name: "SwifSDL2", rect: SDL_Rect(
    x: SDL_WINDOWPOS.CENTERED.rawValue,
    y: SDL_WINDOWPOS.CENTERED.rawValue,
    w: 640, h: 480))
    var endTime = SDL_GetTicks()
    var startTime = endTime
    var delta = UInt32(0)
    while game.isRunning {
        game.input()
        // game.update()
        game.draw()
        endTime = SDL_GetTicks()
        delta = endTime - startTime
        startTime = endTime
        if TIME_FRAME > delta {
            SDL_Delay(TIME_FRAME - delta)
        }
    }
    // game.save()
}

do {
    try MainLoop()
} catch SDLError.initVideo {
    print("Error init SDL2")
} catch SDLError.initImage {
    print("Error init SDL2_Image")
} catch SDLError.initTTF {
    print("Error init SDL2_TTF")
} catch SDLWindowError.initWindow {
    print("Errir create Window")
} catch SDLWindowError.initRenderer {
    print("Error create renderer")
} catch ImageError.loadSurface {
    print("Error create load surface")
} catch ImageError.convertTexture {
    print("Error create texture")
} catch {
    print("Error unknow")
}