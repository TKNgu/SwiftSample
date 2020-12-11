import SwiftSDL2

class GameBlock: GameObject {
    let sprite: Sprite
    var dst: SDL_Rect

    init(sprite: Sprite, dst: SDL_Rect) {
        self.sprite = sprite
        self.dst = dst
    }

    func draw(window: Window) {
        withUnsafePointer(to: &self.dst, {(dst: UnsafePointer<SDL_Rect>) in
            window.draw(sprite: self.sprite, dst: dst)
        })
    }
}