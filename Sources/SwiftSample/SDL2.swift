import SwiftSDL2

typealias Rect = SDL_Rect

enum SDLError: Error {
    case initVideo
    case initImage
    case initTTF
}

extension Game {
    func initSDL2() throws {
        if SDL_Init(SDL_INIT_VIDEO) < 0 {
            throw SDLError.initVideo
        }
        let imgFlag = IMG_INIT_PNG
        if IMG_Init(Int32(imgFlag.rawValue)) & Int32(imgFlag.rawValue) == 0 {
            throw SDLError.initImage
        }
        if TTF_Init() == -1 {
            throw SDLError.initTTF
        }
    }
}