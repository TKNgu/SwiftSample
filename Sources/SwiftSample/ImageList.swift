import SwiftSDL2

class ImageList {
    var images: [Image] = []

    init(images: [Image]) {
        self.images = images
    }

    func draw(src: UnsafePointer<SDL_Rect>?, dst: UnsafePointer<SDL_Rect>?, index: Int) {
        self.images[index].draw(src: src, dst: dst)
    }

    func draw(src: UnsafePointer<SDL_Rect>?, dst: UnsafePointer<SDL_Rect>?, angle: Double, center: UnsafePointer<SDL_Point>?, flip: SDL_RendererFlip, index: Int) {
        self.images[index].draw(src: src, dst: dst, angle: angle, center: center, flip: flip)
    }
}