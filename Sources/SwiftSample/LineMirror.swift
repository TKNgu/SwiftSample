import SwiftSDL2

class RealVector {
    var x: Double = 0.0
    var y: Double = 0.0

    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }

    func convert() -> (Point) {
        return Point(x: Int32(self.x), y: Int32(self.y))
    }

    func nomal() -> (RealVector) {
        let leng = sqrt(self.x * self.x + self.y * self.y)
        self.x /= leng
        self.y /= leng
        return self
    }
}

class LineMirror {
    var source: RealVector
    var vector: RealVector
    var t: Double
    var speed: Double

    init(source: RealVector, vector: RealVector, t: Double, speed: Double) {
        self.source = source
        self.vector = vector.nomal()
        self.t = t
        self.speed = speed
    }

    func findMirror(start: RealVector, end: RealVector) -> (RealVector, RealVector, Bool) {
        let v = RealVector(x: end.x - start.x, y: end.y - start.y)
        if end.x > 640 {
            let t = (640 - start.x) / v.x
            end.x = 640 * 2 - end.x
            return (RealVector(x: 640, y: start.y + t * v.y), end, true)
        } 
        if end.x < 0 {
            let t = -start.x / v.x
            end.x = -end.x
            return (RealVector(x: 0, y: start.y + t * v.y), end, true)
        }
        
        if end.y > 480 {
            let t = (480 - start.y) / v.y
            end.y = 480 * 2 - end.y
            print("Bug")
            print(v.y)
            return (RealVector(x: start.x + t * v.y, y: 480), end, true)
        }
        if end.y < 0 {
            let t = -start.y / v.y
            end.y = -end.y
            return (RealVector(x: start.x + t * v.y, y: 0), end, true)
        }
        return (start, end, false)
    }

    func update(delta: Double) {
        if delta <= 0 {
            return
        }
        let tmp = self.source
        self.source.x += delta * self.speed * self.vector.x
        self.source.y += delta * self.speed * self.vector.y

        let(mirror, new, flag) = findMirror(start: tmp, end: self.source)

        print("Log \(tmp.x) \(tmp.y)")
        print("Log \(self.source.x) \(self.source.y)")

        if flag {
            self.source = new
            self.vector = RealVector(x: new.x - mirror.x, y: new.y - mirror.y).nomal()
        }
    }
}

extension Window {
    func drawLineMirror(lineMirror: LineMirror) {
        print(lineMirror.source.x)
        print(lineMirror.source.y)
        
        SDL_RenderDrawLine(self.screenTexture,
            Int32(0), Int32(0),
            Int32(lineMirror.source.x), Int32(lineMirror.source.y))
        // self.drawLine(start: lineMirror.tail, end: lineMirror.head)
        // var point: [Point] = []
        // // point.append(lineMirror.head.convert())
        // for realPoint in lineMirror.body {
        //     point.append(realPoint.convert())
        // }
        // // point.append(lineMirror.tail.convert())
        // self.drawLines(points: point)
    }
}