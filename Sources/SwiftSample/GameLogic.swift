import SwiftSDL2

let SPEED = UInt32(1000)

class GameLogic {
    var tetromino: Tetromino
    var background: BackGround
    var lastTime: UInt32

    init(tetromino: Tetromino, background: BackGround) {
        self.tetromino = tetromino
        self.background = background
        self.lastTime = SDL_GetTicks()
    }

    func update() {
        if self.tetromino.isMove {
            self.tetromino.isMove = false
            if !self.background.checkBlock(location: self.tetromino.move) {
                self.tetromino.appline()
                return
            }
            self.tetromino.move = self.tetromino.location
        }
        if (SDL_GetTicks() - self.lastTime) >= SPEED {
            self.tetromino.speed()
            self.lastTime += SPEED
        }
        if !self.tetromino.isDown {
            return
        }
        self.tetromino.isDown = false
        if !self.background.checkBlock(location: self.tetromino.move) {
            self.tetromino.appline()
            return
        }
        self.background.add(block: GameBlock(block: self.tetromino.block))
        self.tetromino.reset()
    }
}