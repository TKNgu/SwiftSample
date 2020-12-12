class GameLogic {
    var tetromino: Tetromino
    var background: BackGround

    init(tetromino: Tetromino, background: BackGround) {
        self.tetromino = tetromino
        self.background = background
    }

    func update() {
        if self.tetromino.move.x >= 0 && self.tetromino.move.x <= 9 {
            self.tetromino.location.x = self.tetromino.move.x
        } else {
            self.tetromino.move.x = self.tetromino.location.x
        }
        self.tetromino.location.y = self.tetromino.move.y
    }
}