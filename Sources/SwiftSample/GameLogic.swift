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

    func checkMove() {
        var flag = true
        flag = flag && self.tetromino.move.x >= 0 && self.tetromino.move.x <= 9
        flag = flag && !self.background.checkBlock(location: self.tetromino.move)
        if flag {
            self.tetromino.appline()
        } else {
            self.tetromino.move = self.tetromino.location
        }
    }

    func checkEnd() {
        if (SDL_GetTicks() - self.lastTime) >= SPEED {
            self.tetromino.speed()
            self.lastTime += SPEED
        }
        if self.tetromino.move.y <= 0 || self.background.checkBlock(location: self.tetromino.move){
            self.background.add(block: GameBlock(block: self.tetromino.block))
            self.tetromino.reset()
        }
    }

    func update() {
        checkMove()
        checkEnd()
    }
}