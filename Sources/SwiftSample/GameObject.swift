import SwiftSDL2

class GameObject {
    let sprite: Sprite
    var dst: SDL_Rect

    init(sprite: Sprite, dst: SDL_Rect) {
        self.sprite = sprite
        self.dst = dst
    }
}

extension Window {
    func draw(gameObject: GameObject) {
        withUnsafePointer(to: &gameObject.dst, {(dst: UnsafePointer<SDL_Rect>) in
            draw(sprite: gameObject.sprite, dst: dst)
        })
    }

    func draw(gameObject: GameObject,
        angle: Double, center: UnsafePointer<SDL_Point>?, flip: SDL_RendererFlip) {
        withUnsafePointer(to: &gameObject.dst, {(dst: UnsafePointer<SDL_Rect>) in
            draw(sprite: gameObject.sprite, dst: dst,
                angle: angle, center: center, flip: flip)
        })
    }
}