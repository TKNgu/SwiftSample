import SwiftSDL2

enum ImageError: Error {
    case loadSurface
    case convertTexture
}

class Texture {
    let texture: OpaquePointer

    init(renderer: OpaquePointer, path: String) throws {
        guard let surface = UnsafeMutablePointer<SDL_Surface>(IMG_Load(path)) else {
            throw ImageError.loadSurface
        }
        defer {
            SDL_FreeSurface(surface)
        }
        guard let texture = SDL_CreateTextureFromSurface(renderer, surface) else {
            throw ImageError.convertTexture
        } 
        self.texture = texture
    }

    deinit {
        SDL_DestroyTexture(self.texture)
    }
}

extension Window {
    func  draw(texture: Texture, src: UnsafePointer<SDL_Rect>?, dst: UnsafePointer<SDL_Rect>?) {
        SDL_RenderCopy(self.renderer, texture.texture, src, dst)
    }

    func draw(texture: Texture, src: UnsafePointer<SDL_Rect>?, dst: UnsafePointer<SDL_Rect>?,
        angle: Double, center: UnsafePointer<SDL_Point>?, flip: SDL_RendererFlip) {
        SDL_RenderCopyEx(self.renderer, texture.texture, src, dst, angle, center, flip)
    }
}