import SwiftSDL2

enum ImageError: Error {
    case pathNil
    case load
    case optimized
}

class Image: Drawable {
    var path: String?
    var image: UnsafeMutablePointer<SDL_Surface>? = nil
    var isLoaded: Bool = false
    var texture: OpaquePointer? = nil
    var target: OpaquePointer? = nil

    init(path: String? = nil) {
        self.path = path
    }

    init(path: String?, screenTexture: OpaquePointer?) throws {
        self.image = UnsafeMutablePointer<SDL_Surface>(IMG_Load(path))
        if self.image == nil {
            self.isLoaded = false
            throw ImageError.load
        }
        self.isLoaded = true
        self.texture = SDL_CreateTextureFromSurface(screenTexture, self.image)
        if self.texture == nil {
            throw ImageError.optimized
        }
        self.target = screenTexture
        SDL_FreeSurface(self.image)
        self.image = nil
    }

    func load(path: String? = nil) throws -> Image {
        if let tmp = path {
            self.path = tmp
        }
        guard let path = self.path else {
            throw ImageError.pathNil
        }
        self.image = UnsafeMutablePointer<SDL_Surface>(IMG_Load(path))
        if self.image == nil {
            self.isLoaded = false
            throw ImageError.load
        }
        self.isLoaded = true
        return self
    }

    func optimized(window: Window) throws -> (Image) {
        let texture = SDL_CreateTextureFromSurface(window.screenTexture, self.image)
        if texture == nil {
            throw ImageError.optimized
        }
        SDL_FreeSurface(self.image)
        self.image = nil
        self.texture = texture
        return self
    }

    deinit {
        if self.image == nil {
            SDL_FreeSurface(self.image)
        }
        SDL_DestroyTexture(self.texture)
    }

    func draw(src: UnsafePointer<SDL_Rect>?, dst: UnsafePointer<SDL_Rect>?) {
        SDL_RenderCopy(self.target, self.texture, src, dst)
    }

    func draw(src: UnsafePointer<SDL_Rect>?, dst: UnsafePointer<SDL_Rect>?, angle: Double, center: UnsafePointer<SDL_Point>?, flip: SDL_RendererFlip) {
        SDL_RenderCopyEx(self.target, self.texture, src, dst, angle, center, flip)
    }

    func draw(target: RenderTarget, state: RenderStates) {
        SDL_RenderCopyEx(target.getTexture(), self.texture, nil, nil, 90, nil, SDL_FLIP_VERTICAL)
    }


}

