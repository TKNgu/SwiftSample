import SwiftSDL2
import SDL2GLFX
import LibC

let TIME_FRAME = UInt32(40)

func MainLoop() {
    let game = Game(name: "SwifSDL2", rect: Rect(
        x: SDL_WINDOWPOS.CENTERED.rawValue,
        y: SDL_WINDOWPOS.CENTERED.rawValue,
        w: 640, h: 480))
    do {
        try game.initSDL2()
        let window = WindowSDL2(name: game.window.name, rect: game.window.rect)
        try window.initSDL2(flag: SDL_WINDOW_SHOWN)
        game.window = window
        print("Init OK")
    } catch SDLError.initVideo {
        print("Error init SDL2")
    } catch SDLError.initImage {
        print("Error init SDL2_Image")
    } catch SDLError.initTTF {
        print("Error init SDL2_TTF")
    } catch {
        print("Error unknow")
    }
    game.load()
    var endTime = SDL_GetTicks()
    var startTime = endTime
    var delta = UInt32(0)
    while game.isRunning {
        game.input()
        game.update()
        game.draw()
        endTime = SDL_GetTicks()
        delta = endTime - startTime
        startTime = endTime
        if TIME_FRAME > delta {
            SDL_Delay(TIME_FRAME - delta)
        }
    }
    game.save()
}

MainLoop()