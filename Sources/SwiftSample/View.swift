import SwiftSDL2

class View: RenderTarget {
    var rect: Rect
    var screenTexture: OpaquePointer?

    init(rect: Rect, screenTexture: OpaquePointer?) {
        self.rect = rect
        self.screenTexture = screenTexture
    }

    func getTexture() -> OpaquePointer? {
        SDL_RenderSetViewport(self.screenTexture, &self.rect)
        return self.screenTexture
    }
}