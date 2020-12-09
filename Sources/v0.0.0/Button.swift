import SwiftSDL2

final class Button {
    let nomal: Sprite
    let active: Sprite
    let action: Sprite
    let show: Sprite

    init(nomal: Sprite, active: Sprite, action: Sprite) {
        self.nomal = nomal
        self.active = active
        self.action = action
        self.show = self.nomal
    }
}

extension Window {
    func draw(button: Button, dst: inout SDL_Rect) {
        draw(sprite: button.show, dst: &dst)
    }

    func draw(button: Button, dst: inout SDL_Rect, angle: Double, center: inout SDL_Point, flip: SDL_RendererFlip) {
        draw(sprite: button.show, dst: &dst, angle: angle, center: &center, flip: flip)
    }
}