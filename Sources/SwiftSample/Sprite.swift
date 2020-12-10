import SwiftSDL2

class Sprite {
    let texture: Texture
    var src: SDL_Rect

    init(texture: Texture, src: SDL_Rect) {
        self.texture = texture
        self.src = src
    }
}

extension Window {
    func draw(sprite: Sprite, dst: UnsafePointer<SDL_Rect>) {
        withUnsafePointer(to: &sprite.src, {(src: UnsafePointer<SDL_Rect>) in
            draw(texture: sprite.texture, src: src, dst: dst)
        })
    }

    func draw(sprite: Sprite, dst: UnsafePointer<SDL_Rect>?,
        angle: Double, center: UnsafePointer<SDL_Point>?, flip: SDL_RendererFlip) {
        withUnsafePointer(to: &sprite.src, {(src: UnsafePointer<SDL_Rect>) in
            draw(texture: sprite.texture, src: src, dst: dst,
                angle: angle, center: center, flip: flip)
        })
    }
}