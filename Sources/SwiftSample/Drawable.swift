
typealias Texture = OpaquePointer

protocol Drawable {
    var texture: Texture? {
        get
    }
}
