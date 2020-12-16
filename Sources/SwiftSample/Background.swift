import SwiftSDL2

class BackGround: GameObject {
    var background: GameObjectSingle
    var blocks: [GameBlock]
    var cacheLocation: [[Bool]]
    var cacheBlock: [[BackgroundBlock]]

    init(texture: Texture) {
        self.background = GameObjectSingle(sprite: Sprite(texture: texture, src: SDL_Rect(x: 0, y: 0, w: 160, h: 320)),
            dst: SDL_Rect(x: 0, y: 0, w: 320, h: 640))
        self.blocks = []
        self.cacheLocation = Array(repeating: Array(repeating: false, count: 10), count: 20)
        self.cacheBlock = []
        for indexY in 1...20 {
            var line:[BackgroundBlock] = []
            for indexX in 0..<10 {
                line.append(BackgroundBlock(sprite: Sprite(texture: texture,
                    src: SDL_Rect(x: 160, y: 16, w: 16, h: 16)),
                    location: Location(x: indexX, y: indexY)))
            }
            self.cacheBlock.append(line)
        }
    }

    func add(block: GameBlock) {
        self.blocks.append(block)
        self.cacheLocation[block.location.y - 1][block.location.x] = true
    }

    func checkBlock(location: Location) -> Bool {
        return self.cacheLocation[location.y][location.x]
    }

    func update() {
        var tmp: [[Bool]] = []
        var count = 0
        for line in self.cacheLocation {
            var flag = true
            for block in line {
                flag = flag && block
            }
            if !flag {
                tmp.append(line)
            } else {
                count += 1
            }
        }
        for _ in 0..<count {
            tmp.append(Array(repeating: false, count: 10))
        }
        self.cacheLocation = tmp


        for indexY in 0..<20 {
            for indexX in 0..<10 {
                self.cacheBlock[indexY][indexX].enable = self.cacheLocation[indexY][indexX]
            }
        }
    }

    func draw(window: Window) {
        self.background.draw(window: window)
        for line in self.cacheBlock {
            for block in line {
                block.draw(window: window)
            }
        }
    }
}