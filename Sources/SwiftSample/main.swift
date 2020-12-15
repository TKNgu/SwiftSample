import SwiftSDL2

let TIME_FRAME = UInt32(40)
let NAME = "Sample"
let RECT = SDL_Rect(
    x: SDL_WINDOWPOS.CENTERED.rawValue,
    y: SDL_WINDOWPOS.CENTERED.rawValue,
    w: 640, h: 640)

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

InitSDL2()
do {
    let window = try Window(name: NAME, rect: RECT, flag: SDL_WINDOW_SHOWN)
    let texture = try Texture(renderer: window.renderer, path: "Data/Title.png")
    let textureTitle = try Texture(renderer: window.renderer, path: "Data/Tetromino.png")


    var gameObjects: [GameObject] = []

    let background = BackGround(texture: texture)
    gameObjects.append(background)
    let tetromino = Tetromino(texture: textureTitle)
    gameObjects.append(tetromino)

    var isRunning = true
    Input.instance.quit = {
        isRunning = false
    }
    Input.instance.keyMapDown[SDL_SCANCODE_RIGHT.rawValue] = tetromino.right
    Input.instance.keyMapDown[SDL_SCANCODE_LEFT.rawValue] = tetromino.left
    Input.instance.keyMapDown[SDL_SCANCODE_DOWN.rawValue] = tetromino.down
    Input.instance.keyMapDown[SDL_SCANCODE_UP.rawValue] = tetromino.rotate

    var endTime = SDL_GetTicks()
    var startTime = endTime
    while isRunning {
        Input.instance.update()
        window.clear()
        for gameObject in gameObjects {
            gameObject.update()
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