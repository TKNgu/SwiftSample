import SwiftSDL2

let SIZEX = 10
let SIZEY = 20
let OFFSETY = 640

// let BackGroundData = []

class BackGround: GameObject {
    let background: GameObjectSingle
    var blocks: [GameBlock]

    init(texture: Texture) {
        self.background = GameObjectSingle(sprite: Sprite(texture: texture, src: SDL_Rect(x: 0, y: 0, w: 160, h: 320)),
            dst: SDL_Rect(x: 0, y: 0, w: 320, h: 640))
        self.blocks = []
        for indexY in 1...SIZEY {
            for indexX in 0..<SIZEX {
                self.blocks.append(GameBlock(sprite: Sprite(texture: texture, src: SDL_Rect(x: 160, y: 16, w: 16, h: 16)),
                dst: SDL_Rect(x: Int32(indexX * 32), y: Int32(OFFSETY - indexY * 32), w: 32, h: 32)))
            }
        }
    }

    func update() {
        //TODO
    }

    func draw(window: Window) {
        self.background.draw(window: window)
        for block in self.blocks {
            block.draw(window: window)
        }
    }
}