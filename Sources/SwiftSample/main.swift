import SwiftSDL2

func drawView(window: Window) {
    window.setDrawColor(color: Color(r: 0xFF, g: 0x00, b: 0x00, a: 0x00))
    var rect = Rect(x: window.rect.w / 4, y: window.rect.h / 4, w: window.rect.w / 2, h: window.rect.h / 2)
    window.drawFileRect(rect: &rect)

    window.setDrawColor(color: Color(r: 0x00, g: 0xFF, b: 0x00, a: 0xFF))
    rect = Rect(x: window.rect.w / 6, y: window.rect.h / 6, w: window.rect.w * 2 / 3, h: window.rect.h * 2 / 3)
    window.drawRect(rect: &rect)

    window.setDrawColor(color: Color(r: 0x00, g: 0x00, b: 0xFF, a: 0xFF))
    let start = Point(x: 0, y: window.rect.h / 2)
    let end = Point(x: window.rect.w, y: window.rect.h / 2)
    window.drawLine(start: start, end: end)

    window.setDrawColor(color: Color(r: 0xFF, g: 0xFF, b: 0x00, a: 0xFF))
    for index in 0..<window.rect.h / 4 {
        window.drawPoint(point: Point(x: window.rect.w / 2, y: index * 4))
    }
}

func main() throws{
    let window = try Window(name: "Hello",
        rect: Rect(x: SDL_WINDOWPOS.CENTERED.rawValue, y: SDL_WINDOWPOS.CENTERED.rawValue, w: 640, h: 480),
        flag: SDL_WINDOW_SHOWN)
    // let image = try Image(path: "/home/ngocpt/Downloads/06_extension_libraries_and_loading_other_image_formats/loaded.png")
    //     .load()
    //     .optimized(window: window)

    var quit = false
    var event: SDL_Event = SDL_Event(type: Uint32(0))

    let speedX = 130.0
    let speedY = 70.0
    var snack: [MotionPoint] = []
    for index in 0...10 {
        snack.append(MotionPoint(x: Double(index * 13), y: Double(index * 7), speedX: speedX, speedY: speedY))
    }
    var points: [Point] = []
    for index in 0...100 {
        points.append(Point(x: Int32(index), y: Int32(index * index / 100)))
    }
    let lineMirror = LineMirror(source: RealVector(x: 100, y: 100),
        vector: RealVector(x: 10, y: 10), t: 100, speed: 100)
    var lastTime = SDL_GetTicks()
    while !quit {
        let startTime = SDL_GetTicks()
        while SDL_PollEvent(&event) != 0 {
            if event.type == SDL_QUIT.rawValue {
                quit = true
            }
        }
        window.clean(color: Color(r: 0xff, g: 0xff, b: 0xff, a: 0xff))
        // window.drawImage(image: image)
        drawView(window: window)
        window.setDrawColor(color: Color(r: 0x00, g: 0xFF, b: 0x00, a: 0x00))
        window.drawLines(points: points)

        let delta = Double(startTime - lastTime) / 1000
        lastTime = startTime
        window.setDrawColor(color: Color(r: 0x00, g: 0x00, b: 0x00, a: 0x00))
        for head in snack {
            head.update(delta: delta)
            window.drawPoint(point: Point(x: Int32(head.x), y: Int32(head.y)))
        }
        lineMirror.update(delta: delta)
        window.drawLineMirror(lineMirror: lineMirror)
        window.update()
        let runTime = SDL_GetTicks() - startTime
        SDL_Delay(Uint32(1000 / 60) - runTime)
    }
} 

try main()