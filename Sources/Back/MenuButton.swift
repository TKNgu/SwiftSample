import SwiftSDL2

class MenuButton: GameObject {
    var nomal: SDL_Rect
    var select: SDL_Rect
    var onMouse = false
    var click: () -> Void
    var flag = false

    init(x: Double, y: Double,
        width: Double, height: Double,
        id: String, nomal: SDL_Rect, select: SDL_Rect) {
        self.nomal = nomal
        self.select = select
        self.click = {}
        super.init(x: x, y: y, width: width, height: height, id: id)        
    }

    override func draw() {
        var rect = SDL_Rect(x: Int32(self.position.x), y: Int32(self.position.y),
            w: Int32(self.width), h: Int32(self.height))
        if let image = ImageManager.imageManager.getImage(id: self.id) {
            if self.onMouse {
                image.draw(src: &self.select, dst: &rect, angle: 0, center: nil, flip: SDL_FLIP_NONE)
            } else {
                image.draw(src: &self.nomal, dst: &rect, angle: 0, center: nil, flip: SDL_FLIP_NONE)
            }
        }
    }

    func onMouseMove(x: Int, y: Int) {
        self.onMouse = Int(self.position.x) < x && x < Int(self.position.x + super.width) && Int(self.position.y) < y && y < Int(self.position.y + super.height)
    }

    func onMouseDown() {
        self.flag = self.onMouse
    }

    func onMouseUp() {
        if self.onMouse {
            if self.flag {
                self.click()
            }
            self.flag = false
        }
    }
}