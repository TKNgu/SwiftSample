class ImageManager {
    var images: [String: Image] = [:]
    var window: Window

    init(window: Window) {
        self.window = window
    }

    func load(path: String) throws -> Image {
        if let image = self.images[path] {
            return image
        }
        let image = try Image(path: path, window: self.window)
        self.images[path] = image
        return image
    }
}