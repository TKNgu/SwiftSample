import SwiftSDL2

class Sprite {
    var image: Image
    var rect: SDL_Rect

    init(image: Image, rect: SDL_Rect) {
        self.image = image
        self.rect = rect
    }

    init(image: Image) {
        self.image = image
        self.rect = image.rect
    }
}

extension Window {
    func draw(sprite: Sprite, dst: inout SDL_Rect) {
        draw(image: sprite.image, src: &sprite.rect, dst: &dst)
    }

    func draw(sprite: Sprite, dst: inout SDL_Rect, angle: Double, center: inout SDL_Point, flip: SDL_RendererFlip) {
        draw(image: sprite.image, src: &sprite.rect, dst: &dst, angle: angle, center: &center, flip: flip)
    }
}