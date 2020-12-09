import SwiftSDL2

enum ImageError: Error {
    case loadSurface
    case convertTexture
}

class Image {
    var texture: OpaquePointer
    var rect: SDL_Rect
    
    init(path: String, window: Window) throws {
        guard let surface = UnsafeMutablePointer<SDL_Surface>(IMG_Load(path)) else {
            throw ImageError.loadSurface
        }
        self.texture = SDL_CreateTextureFromSurface(window.renderer, surface)
        SDL_FreeSurface(surface)
        if Int(bitPattern: self.texture) == 0 {
            throw ImageError.convertTexture
        }

        var w = Int32(0)
        var h = Int32(0)
        SDL_QueryTexture(self.texture, nil, nil, &w, &h)
        self.rect = SDL_Rect(x: 0, y: 0, w: w, h: h)
    }

    deinit {
        SDL_DestroyTexture(self.texture)
    }
}

extension Window {
    func draw(image: Image, src: inout SDL_Rect, dst: inout SDL_Rect) {
        draw(texture: image.texture, src: &src, dst: &dst)
    }
    
    func draw(image: Image, src: inout SDL_Rect, dst: inout SDL_Rect, angle: Double, center: inout SDL_Point, flip: SDL_RendererFlip) {
        draw(texture: image.texture, src: &src, dst: &dst, angle: angle, center: &center, flip: flip)
    }
}