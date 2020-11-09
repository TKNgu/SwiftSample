class ImageManager {
    static let imageManager = ImageManager()
    var mapImages: [String: Image] = [:]
    var mapImageList: [String: ImageList] = [:]
    
    private init() {
        //TODO
    }

    func load(fileName: String, id: String, screenTexture: OpaquePointer?) throws {
        let image = try Image(path: fileName, screenTexture: screenTexture)
        self.mapImages[id] = image
    }

    func load(fileName: String, id: String, count: Int, screenTexture: OpaquePointer?) throws {
        var images: [Image] = []
        for index in 1..<count {
            let image = try Image(path: "\(fileName) (\(index)).png", screenTexture: screenTexture)
            images.append(image)
        } 
        self.mapImageList[id] = ImageList(images: images)
    }

    func getImage(id: String) -> Image? {
        return self.mapImages[id]
    }

    func getImage(id: String, index: Int) -> Image? {
        if let imageList = self.mapImageList[id] {
            return imageList.images[index]
        }
        return nil
    }

    func getImageList(id: String) -> ImageList? {
        return self.mapImageList[id]
    }

    static func Instance() -> ImageManager {
        return imageManager
    }
}