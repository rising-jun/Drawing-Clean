//
//  RectangleFactory.swift
//  Drawing-Clean
//
//  Created by 김동준 on 2023/02/18.
//

import Foundation

final class RectangleFactory {
    func makeRectangle() -> Rectangle {
        return Rectangle(uniqueName: Unique.randomUniqueID(),
                         size: Size.randomSize(),
                         point: Point.randomPoint(),
                         color: Color.randomColor(),
                         alpha: Alpha.defaultAlpha())
    }
    
    private func createUniqueName() -> String {
        let uniqueWordsSize = 3
        let randomWordLength = 3
        var uniqueName: String = ""
        
        for count in 1 ... uniqueWordsSize {
            uniqueName += randomWord(length: randomWordLength)
            if count != uniqueWordsSize {
                uniqueName += "-"
            }
        }
        return uniqueName
    }
    
    private func randomWord(length: Int) -> String {
        let randomString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomStringElement = (0 ..< length).map{ _ in randomString.randomElement()! }
        return String(randomStringElement)
    }
}
