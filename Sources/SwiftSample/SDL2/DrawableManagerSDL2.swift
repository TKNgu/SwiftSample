// import SwiftSDL2

// class DrawableManagerSDL2: DrawableManager {
//     var mapDrawable: [String: Drawable] = [:]
//     var windowSDL2: WindowSDL2

//     init(windowSDL2: WindowSDL2) {
//         self.windowSDL2 = windowSDL2
//     }

//     func getDrawable(id: String) throws -> Drawable {
//         if let drawable = self.mapDrawable[id] {
//             return drawable
//         }
//         let image = try ImageSDL2(path: id, windowSDL2: self.windowSDL2)
//         self.mapDrawable[id] = image
//         return image
//     }
// }