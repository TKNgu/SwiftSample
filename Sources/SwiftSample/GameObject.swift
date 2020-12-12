import SwiftSDL2

protocol GameObject {
    func draw(window: Window)
    func update()
}