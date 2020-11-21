import SwiftSDL2

extension Window {
    func setDrawColor(color: Color) {
        SDL_SetRenderDrawColor(self.screenTexture, color.r, color.g, color.b, color.a)
    }

    func drawFileRect(rect: inout Rect) {
        SDL_RenderFillRect(self.screenTexture, &rect)
    }

    func drawRect(rect: inout Rect) {
        SDL_RenderDrawRect(self.screenTexture, &rect)
    }

    func drawLine(start: Point, end: Point) {
        SDL_RenderDrawLine(self.screenTexture, start.x, start.y, end.x, end.y)
    }

    func drawPoint(point: Point) {
        SDL_RenderDrawPoint(self.screenTexture, point.x, point.y)
    }

    func drawLines(points: [Point]) {
        SDL_RenderDrawLines(self.screenTexture, points, Int32(points.count))
    }
}