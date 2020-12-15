import SwiftSDL2

class GameBlock: GameObject {
    let sprite: Sprite
    var dst: SDL_Rect
    var enable: Bool

    init(sprite: Sprite, dst: SDL_Rect, enable: Bool = false) {
        self.sprite = sprite
        self.dst = dst
        self.enable = enable
    }

    func update() {
        //TODO
    }

    func draw(window: Window) {
        if self.enable {
            withUnsafePointer(to: &self.dst, {(dst: UnsafePointer<SDL_Rect>) in
                window.draw(sprite: self.sprite, dst: dst)
            })
        }
    }
}