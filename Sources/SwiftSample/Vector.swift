import Foundation

class Vector {
    var x: Double
    var y: Double

    init(x: Double = 0, y: Double = 0) {
        self.x = x
        self.y = y
    }

    static func +(left: Vector, right: Vector) -> Vector {
        return Vector(x: left.x + right.x, y: left.y + right.y)
    }

    static func +=(left: inout Vector, right: Vector) -> Vector {
        left = left + right
        return left
    }

    static func *(left: Vector, scalar: Double) -> Vector {
        return Vector(x: left.x * scalar, y: left.y * scalar)
    }

    static func *=(left: inout Vector, scalar: Double) -> Vector {
        left = left * scalar
        return left
    }

    static func -(left: Vector, right: Vector) -> Vector {
        return Vector(x: left.x - right.x, y: left.y - right.y)
    }

    static func -=(left: inout Vector, right: Vector) -> Vector {
        left = left - right
        return right
    }

    static func /(left: Vector, scalar: Double) -> Vector {
        return Vector(x: left.x / scalar, y: left.y / scalar)
    }

    static func /=(left: inout Vector, scalar: Double) -> Vector {
        left = left / scalar
        return left
    }

    func length() -> Double {
        return sqrt(pow(self.x, 2) + pow(self.y, 2))
    }

    func normalize() {
        var l = self.length()
        self.x /= l
        self.y /= l
    }
}