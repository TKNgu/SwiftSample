import SwiftSDL2

func Start01() {
    print("Start 01")
    if (SDL_Init(SDL_INIT_VIDEO) < 0) {
        print("Error init sdl")
        return
    }
    let SCREEN_WIDTH: Int32 = 640
    let SCREEN_HEIGHT: Int32 = 480
    if let window = SDL_CreateWindow("SDL Tutorial",
        0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN.rawValue) {
        if let screenSurface = SDL_GetWindowSurface(window) {
            SDL_FillRect(screenSurface, nil,
                SDL_MapRGB(screenSurface.pointee.format, 0xFF, 0xFF, 0xFF))
            SDL_UpdateWindowSurface(window)
            SDL_Delay(2000)
        }
        SDL_DestroyWindow(window)
        SDL_Quit()
    }
}