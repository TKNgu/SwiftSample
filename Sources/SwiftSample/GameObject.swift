import SwiftSDL2

protocol GameObject {
    func update()
    func draw(window: Window)
}