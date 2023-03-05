//
//  RectangleFactoryStub.swift
//  Drawing-CleanTests
//
//  Created by 김동준 on 2023/03/05.
//

import Foundation
@testable import Drawing_Clean

final class RectangleFactoryStub: RectangleFactory {
    func makeRectangle() -> Rectangle {
        Rectangle(uniqueName: Unique.randomUniqueID(),
                  size: Size.randomSize(),
                  point: Point(x: 0, y: 0),
                  color: Color.randomColor(),
                  alpha: Alpha(value: 1.0))
    }
}
