class DrawableManager {
    var mapDrawable: [String: Drawable] = [:]

    func getDrawable(id: String) -> Drawable? {
        return self.mapDrawable[id]
    }
}