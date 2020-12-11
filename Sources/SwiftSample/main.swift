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
    let texture = try Texture(renderer: window.renderer, path: "Data/Title.png")


    var gameObjects: [GameObject] = []

    let background = GameBlock(sprite: Sprite(texture: texture, src: SDL_Rect(x: 0, y: 0, w: 160, h: 320)),
        dst: SDL_Rect(x: 0, y: 0, w: 320, h: 640))
    gameObjects.append(background)
    let lineScore = GameBlock(sprite: Sprite(texture: texture, src: SDL_Rect(x: 160, y: 0, w: 160, h: 16)),
        dst: SDL_Rect(x: 0, y: 0, w: 320, h: 32))
    gameObjects.append(lineScore)
    let blockO = GameBlock(sprite: Sprite(texture: texture, src: SDL_Rect(x: 160, y: 16, w: 32, h: 32)),
        dst: SDL_Rect(x: 32, y: 32, w: 64, h: 64))
    gameObjects.append(blockO)

    var isRunning = true
    var endTime = SDL_GetTicks()
    var startTime = endTime
    while isRunning {
        isRunning = Input()
        window.clear()
        for gameObject in gameObjects {
            gameObject.draw(window: window)        }
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