import SwiftSDL2

class BackGround: GameObjectSingle {
    var background: []

    init(texture: Texture) {
        super.init(sprite: Sprite(texture: texture, src: SDL_Rect(x: 0, y: 0, w: 160, h: 320)),
            dst: SDL_Rect(x: 0, y: 0, w: 320, h: 640))
    }
}