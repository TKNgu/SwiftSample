import SwiftSDL2

class MotionPoint {
    var x: Double
    var y: Double
    var speedX: Double
    var speedY: Double

    init(x: Double, y: Double, speedX: Double, speedY: Double) {
        self.x = x
        self.y = y
        self.speedX = speedX
        self.speedY = speedY
    }

    func update(delta: Double) {
        self.x += self.speedX * delta
        self.y += self.speedY * delta

        if self.x > 640 {
            self.x = 640 * 2 - self.x
            self.speedX = -self.speedX
        }
        if self.x < 0 {
            self.x = -self.x
            self.speedX = -self.speedX
        }
        if self.y > 480 {
            self.y = 480 * 2 - self.y
            self.speedY = -self.speedY
        }
        if self.y < 0 {
            self.y = -self.y
            self.speedY = -self.speedY
        }
    }
}