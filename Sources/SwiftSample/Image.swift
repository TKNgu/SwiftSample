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
    var textureSDL: OpaquePointer? = nil

    var texture: Texture? {
        get {
            return self.textureSDL
        }
    }

    init(path: String? = nil) {
        self.path = path
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
        let texture = SDL_CreateTextureFromSurface(window.screenTexture, self.image);
        if texture == nil {
            throw ImageError.optimized
        }
        SDL_FreeSurface(self.image)
        self.image = nil
        self.textureSDL = texture
        return self
    }

    func optimized(renderer: OpaquePointer) throws -> (Image) {
        let texture = SDL_CreateTextureFromSurface(renderer, self.image);
        if texture == nil {
            throw ImageError.optimized
        }
        SDL_FreeSurface(self.image)
        self.image = nil
        self.textureSDL = texture
        return self
    }

    deinit {
        if self.image == nil {
            SDL_FreeSurface(self.image)
        }
        SDL_DestroyTexture(self.texture)
    }

    // func draw(target: RenderTarget, state: RenderStates) {
    //     // SDL_RenderCopy(target.getTexture(), self.texture, nil, nil)
    //     SDL_RenderCopyEx(target.getTexture(), self.texture, nil, nil, 90, nil, SDL_FLIP_VERTICAL)
    // }
}

// extension Window {
//     func drawImage(image: Image) {
//         SDL_RenderCopy(self.screenTexture, image.texture, nil, nil);
//     }
// }

// extension View {
//     func drawImage(image: Image) {
//         SDL_RenderSetViewport(self.screenTexture, &self.rect)       
//     }
// }

