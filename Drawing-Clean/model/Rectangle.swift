//
//  Rectangle.swift
//  Drawing-Clean
//
//  Created by 김동준 on 2023/02/18.
//

import Foundation

class Rectangle {
    private(set) var uniqueName: Unique
    private(set) var size: Size
    private(set) var point: Point
    private(set) var color: Color
    private(set) var alpha: Alpha
    
    init(uniqueName: Unique,
         size: Size,
         point: Point,
         color: Color,
         alpha: Alpha) {
        self.uniqueName = uniqueName
        self.size = size
        self.point = point
        self.color = color
        self.alpha = alpha
    }
    
    func veryfyIsRectangleRange(by point: Point) -> Bool {
        let minX = self.point.x
        let maxX = self.point.x + size.width
        let minY = self.point.y
        let maxY = self.point.y + size.height
        return (minX <= point.x && point.x <= maxX) && (minY <= point.y && point.y <= maxY)
    }
    
    func changeColor() {
        self.color = Color.randomColor()
    }
    
    func changeAlpha(with alpha: Double) {
        self.alpha = Alpha(value: alpha)
    }
}
extension Rectangle: CustomStringConvertible, Equatable, Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(uniqueName.id)
    }
    
    static func == (lhs: Rectangle, rhs: Rectangle) -> Bool {
        lhs.uniqueName.id == rhs.uniqueName.id
    }
    
    var description: String {
        return """
        id : \(uniqueName), width: \(size.width),
        height: \(size.height),x: \(point.x), y: \(point.y), alpha : \(alpha),
        color \(color.r) \(color.g) \(color.b)
        """
    }
}

struct Size {
    let width: Double
    let height: Double
}
extension Size {
    static func randomSize() -> Size {
        let minSize = 100
        let maxSize = 200
        let width = Int.random(in: minSize ..< maxSize)
        let height = Int.random(in: minSize ..< maxSize)
        return Size(width: Double(width), height: Double(height))
    }
}

struct Point {
    let x: Double
    let y: Double
}
extension Point {
    static func randomPoint() -> Point {
        let xMaxValue = 700
        let yMaxValue = 500
        let x = Int.random(in: 1 ..< xMaxValue)
        let y = Int.random(in: 1 ..< yMaxValue)
        return Point(x: Double(x), y: Double(y))
    }
}

struct Color {
    let r: UInt8
    let g: UInt8
    let b: UInt8
}
extension Color: CustomStringConvertible {
    static let maxValue: UInt8 = 255
    static func randomColor() -> Color {
        let r = UInt8.random(in: 0 ..< maxValue)
        let g = UInt8.random(in: 0 ..< maxValue)
        let b = UInt8.random(in: 0 ..< maxValue)
        return Color(r: r, g: g, b: b)
    }
    
    var description: String {
        return String(describing: String(format:"%02X", Int(r)) + String(format:"%02X", Int(g)) + String(format:"%02X", Int(b)))
    }
}

struct Alpha {
    let value: Double
}
extension Alpha: CustomStringConvertible {
    static func defaultAlpha() -> Alpha {
        return Alpha(value: 1.0)
    }
    
    var description: String {
        return String(describing: value)
    }
}

struct Unique {
    let id: String
}
extension Unique {
    static func randomUniqueID() -> Unique {
        let uniqueWordsSize = 3
        let randomWordLength = 3
        var uniqueName: String = ""
        
        for count in 1 ... uniqueWordsSize {
            uniqueName += randomWord(length: randomWordLength)
            if count != uniqueWordsSize {
                uniqueName += "-"
            }
        }
        return Unique(id: uniqueName)
    }
    
    static func randomWord(length: Int) -> String {
        let randomString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomStringElement = (0 ..< length).map{ _ in randomString.randomElement()! }
        return String(randomStringElement)
    }
}
