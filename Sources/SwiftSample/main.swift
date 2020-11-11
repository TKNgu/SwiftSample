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

func controll(event: SDL_Event) {
    print("Event")
    var type = event.type
    if (type == SDL_MOUSEMOTION.rawValue || type == SDL_MOUSEBUTTONDOWN.rawValue || type == SDL_MOUSEBUTTONUP.rawValue) {
        print("Mouse controll")
        var x: Int32 = 0
        var y: Int32 = 0
        SDL_GetMouseState( &x, &y );
        print("Mouse \(x) \(y) \(type)")
        let currentKeyStates = SDL_GetKeyboardState(nil)
        if currentKeyStates![Int(SDL_SCANCODE_UP.rawValue)] != UInt8(0) {
            print("Up")
        }
    }

    let currentKeyStates = SDL_GetKeyboardState(nil)
    if currentKeyStates![Int(SDL_SCANCODE_UP.rawValue)] != UInt8(0) {
        print("Up")
    }
    if currentKeyStates![Int(SDL_SCANCODE_DOWN.rawValue)] != UInt8(0) {
        print("Down")
    }
    if currentKeyStates![Int(SDL_SCANCODE_LEFT.rawValue)] != UInt8(0) {
        print("Left")
    }
    if currentKeyStates![Int(SDL_SCANCODE_RIGHT.rawValue)] != UInt8(0) {
        print("Right")
    }
}

func test() throws{
    let window = try Window(name: "Hello",
        rect: Rect(x: SDL_WINDOWPOS.CENTERED.rawValue, y: SDL_WINDOWPOS.CENTERED.rawValue, w: 640, h: 480),
        flag: SDL_WINDOW_SHOWN)
    let image = try Image(path: "Data/image.png")
        .load()
        .optimized(window: window)
    let hero = try Image(path: "Data/freeknight/png/Attack (1).png")
        .load()
        .optimized(window: window)

    var heros: [Image] = []
    for index in 1..<11 {
        var tmp = try Image(path: "Data/freeknight/png/Attack (\(index)).png")
            .load()
            .optimized(window: window)
        heros.append(tmp)
        print(index)
    }

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
    let lineMirror = LineMirror(tail: RealVector(x: 7, y: 233),
        speed: RealVector(x: 23, y: -83), leng: 10)
    var lastTime = SDL_GetTicks()
    let view = View(rect: Rect(x: 50, y: 50, w: 300, h: 300), screenTexture: window.getTexture())

    let gFont = TTF_OpenFont( "Data/UbuntuMono-R.ttf", 14)
    if gFont == nil {
        print("Error load fornt")
    }
    var textColor = SDL_Color(r: 0xff, g: 0xff, b: 0xff, a: 0xff)
    var textSurface = TTF_RenderText_Solid(gFont, "Phạm Trung Ngọc The quick brown fox jumps over the lazy dog", textColor);
    var mWidth = textSurface!.pointee.w;
    var mHeight = textSurface!.pointee.h;
    var mTexture = SDL_CreateTextureFromSurface(window.getTexture(), textSurface)
    SDL_FreeSurface(textSurface)
    // if (gTextTexture.loadFromRenderedText( "The quick brown fox jumps over the lazy dog", textColor) != 0) {
    //     print( "Failed to render text texture!\n" )
    // }

    while !quit {
        let startTime = SDL_GetTicks()
        while SDL_PollEvent(&event) != 0 {
            if event.type == SDL_QUIT.rawValue {
                quit = true
            }
            controll(event: event)
        }
        window.clean(color: Color(r: 0x00, g: 0x00, b: 0x00, a: 0x00))
        // window.drawImage(image: image)
        // image.draw(target: window, state: Sample())
        // image.draw(target: view, state: Sample())
        // hero.draw(target: window, state: Sample())
        // drawView(window: window)
        // window.setDrawColor(color: Color(r: 0x00, g: 0xFF, b: 0x00, a: 0x00))
        // window.drawLines(points: points)

        // let delta = Double(startTime - lastTime) / 1000
        // lastTime = startTime
        // window.setDrawColor(color: Color(r: 0x00, g: 0x00, b: 0x00, a: 0x00))
        // for head in snack {
        //     head.update(delta: delta)
        //     window.drawPoint(point: Point(x: Int32(head.x), y: Int32(head.y)))
        // }
        // lineMirror.update(delta: delta)
        // window.drawLineMirror(lineMirror: lineMirror)
        // var index = Int(SDL_GetTicks() / 250) % 9 + 1
        // heros[index].draw(target: window, state: Sample())
        var rectText = Rect(x: 0, y: 0, w: mWidth, h: mHeight)
        var rectView = Rect(x: 0, y: 0, w: 100, h: 100)
        SDL_RenderCopy(window.getTexture(), mTexture, &rectText, &rectText)
        window.update()
        let runTime = SDL_GetTicks() - startTime
        if Uint32(1000 / 25) > runTime {
            SDL_Delay(Uint32(1000 / 25) - runTime)
        }
    }
} 

func main() throws {
    let game = try Game(title: "Hello",
        xpos: SDL_WINDOWPOS.CENTERED.rawValue, ypos: SDL_WINDOWPOS.CENTERED.rawValue,
        height: Uint32(480), width: Uint32(640),
        flags: SDL_WINDOW_SHOWN.rawValue)
    var startTime: Uint32
    let frameTime = Uint32(1000 / 25)
    while game.running {
        startTime = SDL_GetTicks()
        game.handleEvents()
        game.update()
        game.render()
        let runTime = SDL_GetTicks() - startTime
        if frameTime > runTime {
            SDL_Delay(frameTime - runTime)
        }
    }
}

try main()