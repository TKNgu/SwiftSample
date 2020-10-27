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

    func point() -> (Point) {
        return Point(x: Int32(self.x), y: Int32(self.y))
    }
}

// class LineRealVector: RealVector {
//     var t: Double

//     init(x: Double, y: Double, t: Double) {
//         self.x = x
//         self.y = y
//         self.t = t
//     } 
// }

class LineMirror {
    var tail: RealVector
    var tailSpeed: RealVector
    var head: RealVector
    var headSpeed: RealVector
    var leng: Double
    var bodys: [RealVector]

    init(tail: RealVector, speed: RealVector, leng: Double) {
        self.tail = tail
        self.tailSpeed = speed
        self.leng = leng
        self.head = RealVector(x: tail.x + speed.x * leng, y: tail.y + speed.y * leng)
        self.headSpeed = speed
        self.bodys = []

        var (mirror, point, speed, flag) = findMirror(tail: self.tail, head: self.head, vector: self.headSpeed)
        while flag {
            self.bodys.append(mirror)
            self.head = point
            self.headSpeed = speed
            (mirror, point, speed, flag) = findMirror(tail: self.bodys.last!, head: self.head, vector: self.headSpeed)
        }
    }

    func findMirror(tail: RealVector, head: RealVector, vector: RealVector) -> (RealVector, RealVector, RealVector, Bool) {
        var tmin = -1.0
        if head.x > 640 {
            let t = (640 - tail.x) / vector.x
            if tmin < 0 {
                tmin = t
            } else if tmin > t {
                tmin = t
            }
        }
        if head.x < 0 {
            let t = -tail.x / vector.x
            if tmin < 0 {
                tmin = t
            } else if tmin > t {
                tmin = t
            }
        }
        if head.y > 480 {
            let t = (480 - tail.y) / vector.y
            if tmin < 0 {
                tmin = t
            } else if tmin > t {
                tmin = t
            }
        }
        if head.y < 0 {
            let t = -tail.y / vector.y
            if tmin < 0 {
                tmin = t
            } else if tmin > t {
                tmin = t
            }
        }

        print(tmin)
        if tmin < 0 {
            return (tail, head, vector, false)
        }

        let mirror = RealVector(x: tail.x + tmin * vector.x, y: tail.y + tmin * vector.y)
        if mirror.x == 0 {
            head.x = -head.x
            vector.x = -vector.x
        }
        if mirror.x == 640 {
            head.x = 640 * 2 - head.x
            vector.x = -vector.x 
        }
        if mirror.y == 0 {
            head.y = -head.y
            vector.y = -vector.y
        }
        if mirror.y == 480 {
            head.y = 480 * 2 - head.y
            vector.y = -vector.y
        }
        return (mirror, head, vector, false)
    }

    // func findMirror(start: RealVector, end: RealVector) -> (RealVector, RealVector, Bool) {
    //     let v = RealVector(x: end.x - start.x, y: end.y - start.y)
    //     if end.x > 640 {
    //         let t = (640 - start.x) / v.x
    //         end.x = 640 * 2 - end.x
    //         return (RealVector(x: 640, y: start.y + t * v.y), end, true)
    //     } 
    //     if end.x < 0 {
    //         let t = -start.x / v.x
    //         end.x = -end.x
    //         return (RealVector(x: 0, y: start.y + t * v.y), end, true)
    //     }
        
    //     if end.y > 480 {
    //         let t = (480 - start.y) / v.y
    //         end.y = 480 * 2 - end.y
    //         print("Bug")
    //         print(v.y)
    //         return (RealVector(x: start.x + t * v.y, y: 480), end, true)
    //     }
    //     if end.y < 0 {
    //         let t = -start.y / v.y
    //         end.y = -end.y
    //         return (RealVector(x: start.x + t * v.y, y: 0), end, true)
    //     }
    //     return (start, end, false)
    // }

    func update(delta: Double) {
        // if delta <= 0 {
        //     return
        // }
        // let tmp = self.source
        // self.source.x += delta * self.speed * self.vector.x
        // self.source.y += delta * self.speed * self.vector.y

        // let(mirror, new, flag) = findMirror(start: tmp, end: self.source)

        // print("Log \(tmp.x) \(tmp.y)")
        // print("Log \(self.source.x) \(self.source.y)")

        // if flag {
        //     self.source = new
        //     self.vector = RealVector(x: new.x - mirror.x, y: new.y - mirror.y).nomal()
        // }
    }
}

extension Window {
    func drawLineMirror(lineMirror: LineMirror) {
        var points: [Point] = []
        points.append(lineMirror.tail.point())
        // print("Draw")
        for body in lineMirror.bodys {
            // print("Point \(body.x) \(body.y)")
            points.append(body.point())
        }
        points.append(lineMirror.head.point())        
        // SDL_RenderDrawLine(self.screenTexture,
        //     Int32(0), Int32(0),
        //     Int32(lineMirror.source.x), Int32(lineMirror.source.y))
        // self.drawLine(start: lineMirror.tail, end: lineMirror.head)
        // var point: [Point] = []
        // // point.append(lineMirror.head.convert())
        // for realPoint in lineMirror.body {
        //     point.append(realPoint.convert())
        // }
        // // point.append(lineMirror.tail.convert())
        self.drawLines(points: points)
    }
}