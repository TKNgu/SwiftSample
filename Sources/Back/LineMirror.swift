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

class LineRealVector: RealVector {
    var t: Double

    init(x: Double, y: Double, t: Double) {
        self.t = t
        super.init(x: x, y: y)
    } 
}

class LineMirror {
    var tail: LineRealVector
    var tailSpeed: RealVector
    var head: LineRealVector
    var headSpeed: RealVector
    var leng: Double
    var bodys: [LineRealVector]

    init(tail: RealVector, speed: RealVector, leng: Double) {
        self.tail = LineRealVector(x: tail.x, y: tail.y, t: 0.0)
        self.tailSpeed = RealVector(x: speed.x, y: speed.y)
        self.leng = leng
        self.headSpeed = RealVector(x: speed.x, y: speed.y)

        self.head = LineRealVector(x: tail.x + speed.x * leng,y: tail.y + speed.y * leng, t: leng)
        self.bodys = []
        var (mirror, point, speedNew, flag) = findMirror(tail: self.tail, head: self.head, vector: self.headSpeed)
        while flag {
            self.bodys.append(mirror)
            self.head = point
            self.headSpeed = speedNew
            (mirror, point, speedNew, flag) = findMirror(tail: mirror, head: point, vector: speedNew)
        }
    }

    func findMirror(tail: LineRealVector, head: LineRealVector, vector: RealVector) -> (LineRealVector, LineRealVector, RealVector, Bool) {
        var index = 0
        var tmin = 0.0
        var flag = false
        if head.x > 640 {
            tmin = (640 - tail.x) / vector.x
            flag = true
            index = 1
        }
        if head.x < 0 {
            let t = -tail.x / vector.x
            if flag {
                if tmin > t {
                    tmin = t
                    index = 2
                }
            } else {
                tmin = t
                flag = true
                index = 2
            }
        }
        if head.y > 480 {
            let t = (480 - tail.y) / vector.y
            if flag {
                if tmin > t {
                    tmin = t
                    index = 3
                }
            } else {
                tmin = t
                flag = true
                index = 3
            }
        }
        if head.y < 0 {
            let t = -tail.y / vector.y
            if flag {
                if tmin > t {
                    tmin = t
                    index = 4
                }
            } else {
                tmin = t
                flag = true
                index = 4
            }
        }
        if !flag {
            return (tail, head, vector, flag)
        }
        let mirror = LineRealVector(x: tail.x + tmin * vector.x, y: tail.y + tmin * vector.y, t: tail.t + tmin)
        switch index {
        case 1:
            head.x = 640 * 2 - head.x
            vector.x = -vector.x
        case 2:
            head.x = -head.x
            vector.x = -vector.x
        case 3:
            head.y = 480 * 2 - head.y
            vector.y = -vector.y
        case 4:
            head.y = -head.y
            vector.y = -vector.y
        default:
            break
        }
        return (mirror, head, vector, flag)
    }

    func update(delta: Double) {
        self.head = LineRealVector(x: self.head.x + self.headSpeed.x * delta,
            y: self.head.y + self.headSpeed.y * delta, t: self.head.t + delta)
        let last = self.bodys.last ?? self.tail
        var (mirror, point, speed, flag) = findMirror(tail: last, head: self.head, vector: self.headSpeed)
        while flag {
            self.bodys.append(mirror)
            self.head = point
            self.headSpeed = speed
            (mirror, point, speed, flag) = findMirror(tail: mirror, head: point, vector: speed)
        }
        self.tail = LineRealVector(x: self.tail.x + self.tailSpeed.x * delta,
            y: self.tail.y + self.tailSpeed.y * delta, t: self.tail.t + delta)
        (mirror, point, speed, flag) = findMirror(tail: self.tail, head: self.tail, vector: self.tailSpeed)
        while flag {
            self.tail = point
            self.tailSpeed = speed
            (mirror, point, speed, flag) = findMirror(tail: self.tail, head: self.tail, vector: self.tailSpeed)
        }
        while self.bodys.count > 0 {
            let last = self.bodys.first!
            if last.t < point.t {
                self.bodys.removeFirst()
            } else {
                break
            }
        }
    }
}

extension Window {
    func drawLineMirror(lineMirror: LineMirror) {
        var points: [Point] = []
        points.append(lineMirror.tail.point())
        for body in lineMirror.bodys {
            points.append(body.point())
        }
        points.append(lineMirror.head.point())
        self.drawLines(points: points)
    }
}