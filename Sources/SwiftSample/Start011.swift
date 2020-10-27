import SwiftSDL2

func Start011() {
    if SDL_Init(SDL_INIT_VIDEO) < 0 {
        print("Errir create init")
        return
    }
    let SCREEN_WIDTH: Int32 = 640
    let SCREEN_HEIGHT: Int32 = 480
    var window: OpaquePointer
    window = SDL_CreateWindow("Start 02",
        SDL_WINDOWPOS.CENTERED.rawValue, SDL_WINDOWPOS.CENTERED.rawValue,
        SCREEN_WIDTH, SCREEN_HEIGHT, SDL_WINDOW_SHOWN.rawValue)
    print(type(of: window))
    guard let screenSurface = UnsafeMutablePointer<SDL_Surface>(SDL_GetWindowSurface(window)) else {
        print("Error create surface")
        return
    }
    print(type(of: screenSurface))
    SDL_FillRect(screenSurface, nil, SDL_MapRGB(screenSurface.pointee.format, 0xFF, 0xFF, 0xFF))
    SDL_UpdateWindowSurface(window)
    SDL_Delay(2000)
}