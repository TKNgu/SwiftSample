import SwiftSDL2
import XML

final class Menu: GameState {
    let imageManager: ImageManager
    let window: Window
    let image: Image
    var sprites: [String: Sprite]
    var playButton: Button?

    init(imageManager: ImageManager, window: Window) throws {
        self.imageManager = imageManager
        self.window = window
        self.image = try self.imageManager.load(path: "Data/UIpack/Spritesheet/blueSheet.png")
        self.sprites = [:]
        self.playButton = nil
    }

    func onEnter() {
        let fb = fopen("Data/UIpack/Spritesheet/blueSheet.xml", "r")
        let node = mxmlLoadFile(nil, fb, mxml_ignore_cb)
        fclose(fb)
        var sub = mxmlGetFirstChild(node)
        while  sub != nil {
            print(String(cString: mxmlGetElement(sub)))
            let name = String(cString: mxmlElementGetAttr(sub, "name"))
            let x = String(cString: mxmlElementGetAttr(sub, "x"))
            let y = String(cString: mxmlElementGetAttr(sub, "y"))
            let w = String(cString: mxmlElementGetAttr(sub, "width"))
            let h = String(cString: mxmlElementGetAttr(sub, "height"))
            self.sprites[name] = Sprite(image: self.image,
                rect: SDL_Rect(x: Int32(x) ?? 0, y: Int32(y) ?? 0, w: Int32(w) ?? 0, h: Int32(h) ?? 0))
            print("Value \(x) \(y) \(w) \(h)")
            sub = mxmlGetNextSibling(sub)
        }
        mxmlDelete(node)
        self.playButton = Button(nomal: self.sprites["blue_button00.png"]!,
            active: self.sprites["blue_button00.png"]!,
            action: self.sprites["blue_button00.png"]!)
    }

    func onResume() {

    }

    func update() {

    }

    func render() {
        // for (_, value) in self.sprites {
        //     var rect = value.rect
        //     self.window.draw(sprite: value, dst: &rect)
        // }
        var rect = SDL_Rect(x: 0, y: 0, w: 100, h: 100)
        self.window.draw(button: self.playButton!, dst: &rect)
    }

    func onPause() {

    }

    func onExit() {
        
    }
}