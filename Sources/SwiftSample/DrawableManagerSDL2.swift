final class DrawableManagerSDL2: DrawableManager {
    var renderer: OpaquePointer

    init(renderer: OpaquePointer) {
        self.renderer = renderer
    }

    func load(path: String, id: String) throws {
        let image = try Image(path: path)
            .load()
            .optimized(renderer: renderer)
        super.mapDrawable[id] = image
    }
}