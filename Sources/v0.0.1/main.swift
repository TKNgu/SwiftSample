import SwiftSDL2

do {
    let game = try Game()
    game.loop()
} catch SDLError.initVideo {
    print("Error init SDL2")
} catch SDLError.initImage {
    print("Error init SDL2_Image")
} catch SDLError.initTTF {
    print("Error init SDL2_TTF")
} catch SDLWindowError.initWindow {
    print("Errir create Window")
} catch SDLWindowError.initRenderer {
    print("Error create renderer")
// } catch ImageError.loadSurface {
//     print("Error create load surface")
// } catch ImageError.convertTexture {
//     print("Error create texture")
} catch {
    print("Error unknow")
}
