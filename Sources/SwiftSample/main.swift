import SwiftSDL2

let TIME_FRAME = UInt32(40)
let NAME = "Sample"
let RECT = SDL_Rect(
    x: SDL_WINDOWPOS.CENTERED.rawValue,
    y: SDL_WINDOWPOS.CENTERED.rawValue,
    w: 640, h: 480)

func InitSDL2() {
    if SDL_Init(SDL_INIT_VIDEO) < 0 {
        print("Error InitSDL2")
    }

    let imageFlag = IMG_INIT_PNG
    if IMG_Init(Int32(imageFlag.rawValue)) & Int32(imageFlag.rawValue) == 0 {
        print("Error IMGInit")
    }

    if TTF_Init() == -1 {
        print("Error InitTTF")
    }
}

func Delay(startTime: inout UInt32, endTime: inout UInt32) {
    endTime = SDL_GetTicks()
    let delta = endTime - startTime
    startTime = endTime
    if TIME_FRAME > delta {
        SDL_Delay(TIME_FRAME - delta)
    }
}

func Input() -> Bool {
    var event = SDL_Event(type: UInt32(0))
    while SDL_PollEvent(&event) != 0{
        switch event.type {
            case SDL_QUIT.rawValue:
                return false
            default:
                break
            }
        }
    return true
}

InitSDL2()
do {
    let window = try Window(name: NAME, rect: RECT, flag: SDL_WINDOW_SHOWN)
    let texture = try Texture(renderer: window.renderer, path: "Data/UIpack/Spritesheet/blueSheet.png")
    var isRunning = true
    var endTime = SDL_GetTicks()
    var startTime = endTime
    while isRunning {
        isRunning = Input()
        window.clear()
        window.draw(texture: texture, src: nil, dst: nil)
        window.present()
        Delay(startTime: &startTime, endTime: &endTime)
    }
} catch SDLWindowError.initWindow {
    print("Error create Window")
} catch SDLWindowError.initRenderer {
    print("Error create Renderer")
} catch ImageError.loadSurface {
    print("Error create Surface")
} catch ImageError.convertTexture {
    print("Error create Texture")
}